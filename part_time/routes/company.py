#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Blueprint, render_template, \
    redirect, url_for, flash, request, current_app, abort
from flask_login import current_user
from ..decorators import company_required
from ..forms import RegisterCompanyForm, CompanyDetailForm, UserDetailForm
from ..models import Company, Job, Delivery, db

company = Blueprint('company', __name__, url_prefix='/company')


@company.route('/register', methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('front.index'))
    form = RegisterCompanyForm()
    if form.validate_on_submit():
        form.create_company()
        flash('Successful registration, please log in', 'success')
        return redirect(url_for('front.login'))
    return render_template('company/register.html', form=form, active='company_register')


@company.route('/')
def index():
    page = request.args.get('page', default=1, type=int)
    kw = request.args.get('kw')
    if not current_user.is_authenticated or (current_user.is_authenticated and current_user.is_admin() == False):
        flt = {Company.is_enable == True}
    else:
        flt = {}
    if kw is not None and kw != '':
        flt.update({Company.name.ilike('%{}%'.format(kw))})
    pagination = Company.query.filter(*flt).order_by(Company.updated_at.desc()).paginate(
        page=page, per_page=current_app.config['COMPANY_INDEX_PER_PAGE'], error_out=False)
    return render_template('company/index.html', pagination=pagination, kw=kw, active='company')


@company.route('/<int:company_id>')
def detail(company_id):
    company_obj = Company.query.get_or_404(company_id)
    if ((not company_obj.is_enable) and (current_user.is_authenticated
                                                                              and not current_user.is_admin())):
        abort(404)
    # if request.args.get('job'):
    page = request.args.get('page', default=1, type=int)
        # if current_user.is_authenticated and current_user.is_admin():
        #     pagination = company_obj(Job.updated_at.desc()).paginate(
        #         page=page, per_page=current_app.config['COMPANY_DETAIL_PER_PAGE'], error_out=False)
        # else:
    pagination = company_obj.enabled_jobs().order_by(Job.updated_at.desc()).paginate(
            page=page, per_page=current_app.config['COMPANY_DETAIL_PER_PAGE'], error_out=False)
    return render_template('company/detail.html', pagination=pagination, panel='jobs', company=company_obj)
    # return render_template('company/detail.html', company=company_obj, panel='about', active='detail')


@company.route('/account', methods=['GET', 'POST'])
@company_required
def edit():
    form = CompanyDetailForm(obj=current_user)
    logo_url = current_user.logo
    if form.validate_on_submit():
        logo_url = form.update_detail(current_user)
        print(logo_url)
        flash('Successful update of corporate information', 'success')
    return render_template('company/edit.html', form=form, file_url=logo_url, panel='edit', active='manage')


@company.route('/jobs')
@company_required
def jobs():
    page = request.args.get('page', default=1, type=int)
    pagination = current_user.jobs.paginate(
        page=page, per_page=current_app.config['LIST_PER_PAGE'], error_out=False)
    return render_template('company/jobs.html', pagination=pagination, active='manage', panel='jobs')


@company.route('/resumes')
@company_required
def resumes():
    status = request.args.get('status', '1')
    page = request.args.get('page', default=1, type=int)
    pagination = current_user.delivery.filter_by(status=status).order_by(Delivery.updated_at.desc()).paginate(
        page=page, per_page=current_app.config['LIST_PER_PAGE'], error_out=False)
    return render_template('company/resumes.html', pagination=pagination,
                           active='manage', panel='resumes', status=status)


@company.route('/resume/accept')
@company_required
def resume_accept():
    delivery_id = request.args.get('delivery_id')
    delivery = current_user.delivery.filter_by(id=delivery_id).first_or_404()
    delivery.accept()
    db.session.add(delivery)
    db.session.commit()
    flash('Included in interviews', 'success')
    return redirect(url_for('company.resumes'))


@company.route('/resume/reject')
@company_required
def resume_reject():
    delivery_id = request.args.get('delivery_id')
    delivery = current_user.delivery.filter_by(id=delivery_id).first_or_404()
    delivery.reject()
    db.session.add(delivery)
    db.session.commit()
    flash('Included as inappropriate', 'warning')
    return redirect(url_for('company.resumes'))


@company.errorhandler(413)
def page_not_found(error):
    flash('Image size exceeds the limit', 'warning')
    return redirect(request.path)


@company.route('/person', methods=['GET', 'POST'])
@company_required
def person():
    if not current_user.is_company():
        return redirect(url_for("front.index"))
    form = UserDetailForm(obj=current_user)
    if form.validate_on_submit():
        form.update_detail(current_user)
        flash('Personal Information Updated Successfully', 'success')
        return redirect(url_for('company.person'))
    return render_template('company/person.html', form=form, active='manage', panel='person')


@company.route('<int:company_id>/disable')
@company_required
def disable(company_id):
    company_obj = Company.query.get_or_404(company_id)
    if not company_obj.is_enable:
        flash('Unblocked', 'warning')
    else:
        company_obj.is_enable = False
        db.session.add(company_obj)
        db.session.commit()
        flash('Blocked', 'success')
    return redirect(url_for('admin.company'))


@company.route('<int:company_id>/enable')
@company_required
def enable(company_id):
    company_obj = Company.query.get_or_404(company_id)
    if company_obj.is_enable:
        flash('Banned accounts', 'warning')
    else:
        company_obj.is_enable = True
        db.session.add(company_obj)
        db.session.commit()
        flash('UpBlock', 'success')
    return redirect(url_for('admin.company'))


