# -*- coding: utf-8 -*-

from flask import Blueprint, render_template, abort,\
    current_app, redirect, url_for, flash, request
from flask_login import current_user, login_required
from ..decorators import company_required
from ..models import Job, db, Delivery, Company
from ..forms import EXP, JobForm
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

job = Blueprint('job', __name__, url_prefix='/job')


@job.route('/')
def index():
    page = request.args.get('page', default=1, type=int)
    kw = request.args.get('kw')
    # print(kw)
    if not current_user.is_authenticated or (current_user.is_authenticated and not current_user.is_admin()):
        query = Job.query.join(Company, Job.company_id == Company.id).filter(Company.is_enable==True).filter(Job.is_enable == True)
    else:
        query = Job.query.join(Company, Job.company_id == Company.id)
    if kw:
        query = query.filter(Job.name.like('%{}%'.format(kw)))

    if current_user.is_authenticated and current_user.is_user():
        user_profile = {}
        user_profile['interests'] = current_user.hobby
        user_profile['skills'] = current_user.skill
        user_profile['education'] = current_user.education
        results_list = []
        for item in query:
            item_dict = {}
            if hasattr(item, 'company') and item.company is not None:
                company_dict = {
                    'name': item.company.name,
                    'id': item.company.id
                }
                item_dict.update(company_dict)
            item_dict.update({key: value for key, value in item.__dict__.items() if not key.startswith('_')})
            results_list.append(item_dict)

        vectorizer = TfidfVectorizer()
        user_texts = [user_profile['interests'], user_profile['skills'], user_profile['education']]
        user_tfidf = vectorizer.fit_transform(user_texts)
        scores = []
        for job in results_list:
            job_texts = [job['treatment'], job['description'], job['education']]
            job_tfidf = vectorizer.transform(job_texts)
            similarity = cosine_similarity(user_tfidf, job_tfidf)
            scores.append(similarity.mean())
        for score, job in zip(scores, results_list):
            job['similarity_score'] = score
        sorted_jobs = sorted(results_list, key=lambda x: x['similarity_score'], reverse=True)
        job_ids = [job['id'] for job in sorted_jobs if 'id' in job]
        pagination = Job.query.join(Company, Job.company_id == Company.id).filter(Company.is_enable==True).filter(
            Job.is_enable==True).filter(Job.id.in_(job_ids)).paginate(
                page=page,
                per_page=current_app.config['JOB_INDEX_PER_PAGE'],
                error_out=False
            )
        return render_template('job/index.html', pagination=pagination, kw=kw, filter=EXP, active='job')

    pagination = query.order_by(Job.created_at.desc()).paginate(
        page=page,
        per_page=current_app.config['JOB_INDEX_PER_PAGE'],
        error_out=False
    )


    return render_template('job/index.html', pagination=pagination,
                           kw=kw, filter=EXP, active='job')



@job.route('/recommend')
def recommend():
    jobs = Job.query.join(Company, Job.company_id == Company.id).filter(Company.is_enable == True).filter(Job.is_enable == True).all()
    user_profile = {}
    if current_user.is_user():
        user_profile['interests'] = current_user.hobby
        user_profile['skills'] = current_user.skill
        user_profile['education'] = current_user.education

    results_list = []
    for item in jobs:
        item_dict = {}
        if hasattr(item, 'company') and item.company is not None:
            company_dict = {
                'name': item.company.name,
                'id': item.company.id
            }
            item_dict.update(company_dict)
        item_dict.update({key: value for key, value in item.__dict__.items() if not key.startswith('_')})
        results_list.append(item_dict)

    vectorizer = TfidfVectorizer()
    user_texts = [user_profile['interests'], user_profile['skills'], user_profile['education']]
    user_tfidf = vectorizer.fit_transform(user_texts)
    scores = []
    for job in results_list:
        job_texts = [job['treatment'], job['description'], job['education']]
        job_tfidf = vectorizer.transform(job_texts)
        similarity = cosine_similarity(user_tfidf, job_tfidf)
        scores.append(similarity.mean())
    for score, job in zip(scores, results_list):
        job['similarity_score'] = score

    sorted_jobs = sorted(results_list[:15], key=lambda x: x['similarity_score'], reverse=True)


    return render_template('job/recommend.html', jobs=sorted_jobs, filter=EXP, active='recommend')


@job.route('/<int:job_id>')
def detail(job_id):
    job_obj = Job.query.get_or_404(job_id)
    # if not job_obj.is_enable and job_obj.company_id != current_user.id:
    #     abort(404)
    company = Company.query.get(job_obj.company_id)
    if company is None or (company.is_enable == False and current_user.is_authenticated and (not current_user.is_admin())):
        abort(404)
    rate_score = None
    if current_user.is_authenticated and current_user.is_user():
        # print(job_obj.company_id, current_user.id)
        data = Delivery.query.filter(Delivery.user_id == current_user.id).\
            filter(Delivery.company_id == job_obj.company_id).\
            filter(Delivery.job_id == job_id).all()
        for item in data:
            rate_score = item.rate
    return render_template('job/detail.html', job=job_obj, rate=rate_score)

@job.route('/rate', methods=['GET', 'POST'])
@login_required
def rate():
    job_id = request.form.get("job_id")
    company_id = request.form.get("company_id")
    rate_score = int(request.form.get("ratings[1]"))
    if rate_score == None or job_id == None:
        abort(404)
    data = Delivery.query.filter(Delivery.user_id == current_user.id). \
        filter(Delivery.company_id == company_id). \
        filter(Delivery.job_id == job_id).all()
    for item in data:
        item.rate = rate_score
        db.session.add(item)
        db.session.commit()

    if not current_user.is_user():
        abort(404)

    data = Delivery.query.filter(Delivery.company_id == company_id).all()
    # rate_score = 0.0
    rate_length = 1
    for item in data:
        rate_length = rate_length + 1
        rate_score = rate_score + item.rate

    rate_score = round(rate_score / rate_length, 1)
    company = Company.query.get(company_id)
    company.rate = rate_score
    db.session.add(company)
    db.session.commit()
    return redirect(url_for('job.detail', job_id=job_id))


@job.route('/<int:job_id>/apply', methods=['GET', 'POST'])
@login_required
def apply(job_id):
    job_obj = Job.query.get_or_404(job_id)
    if not current_user.is_user():
        abort(404)
    if not current_user.resume:
        flash('Please upload your resume first', 'warning')
        return redirect(url_for('user.resume'))
    elif job_obj.is_applied():
        flash('Already submitted this position', 'warning')
        return redirect(url_for('job.detail', job_id=job_id))
    delivery = Delivery(
        job_id=job_id,
        user_id=current_user.id,
        company_id=job_obj.company.id,
        resume=current_user.resume
    )
    db.session.add(delivery)
    db.session.commit()
    flash('Resume Delivery Success', 'success')
    return redirect(url_for('job.detail', job_id=job_id))


@job.route('/create', methods=['GET', 'POST'])
@company_required
def create():
    form = JobForm()
    if form.validate_on_submit():
        company_id = current_user.id
        form.create_job(company_id)
        flash('Job Created Successfully', 'success')
        return redirect_job_index()
    return render_template('job/create.html', form=form, active='manage', panel='create')


@job.route('/<int:job_id>/edit', methods=['GET', 'POST'])
@company_required
def edit(job_id):
    job_obj = Job.query.get_or_404(job_id)
    if job_obj.company_id != current_user.id and not current_user.is_admin():
        abort(404)
    form = JobForm(obj=job_obj)
    if form.validate_on_submit():
        form.update_job(job_obj)
        flash('Job Updates Successful', 'success')
        return redirect_job_index()
    return render_template('job/edit.html', form=form, job_id=job_id)


@job.route('/<int:job_id>/delete', methods=['GET', 'POST'])
@company_required
def delete(job_id):
    job_obj = Job.query.get_or_404(job_id)
    if job_obj.company_id != current_user.id and not current_user.is_admin():
        abort(404)
    db.session.delete(job_obj)
    db.session.commit()
    flash('Post deleted successfully', 'success')
    return redirect_job_index()


@job.route('<int:job_id>/disable')
@company_required
def disable(job_id):
    job_obj = Job.query.get_or_404(job_id)
    if not current_user.is_admin() and current_user.id != job_obj.company.id:
        abort(404)
    if not job_obj.is_enable:
        flash('Job has been downgraded', 'warning')
    else:
        job_obj.is_enable = False
        db.session.add(job_obj)
        db.session.commit()
        flash('Job downgrade success', 'success')
    return redirect_job_index()


@job.route('<int:job_id>/enable')
@company_required
def enable(job_id):
    job_obj = Job.query.get_or_404(job_id)
    if not current_user.is_admin() and current_user.id != job_obj.company.id:
        abort(404)
    if job_obj.is_enable:
        flash('Job is on the shelf', 'warning')
    else:
        job_obj.is_enable = True
        db.session.add(job_obj)
        db.session.commit()
        flash('Job Posting Success', 'success')
    return redirect_job_index()


def redirect_job_index():
    if current_user.is_admin():
        return redirect(url_for('admin.job'))
    elif current_user.is_company():
        return redirect(url_for('company.jobs'))
    else:
        return redirect(url_for('front.index'))
