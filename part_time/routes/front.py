#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import login_user, logout_user, login_required, current_user
from ..models import Job, User, Company, Admin
from ..forms import LoginForm

front = Blueprint('front', __name__)


@front.route('/')
def index():
    company_all = Company.query.filter(Company.is_enable.is_(True)).order_by(Company.updated_at.desc())
    companies = []
    for c in company_all:
        if c and c.enabled_jobs().count() != 0:
            companies.append(c)
            if len(companies) == 8:
                break
    if not current_user.is_authenticated or (current_user.is_authenticated and not current_user.is_admin()):
        jobs = Job.query.join(Company).filter(Company.is_enable.is_(True), Job.is_enable.is_(True)).order_by(
            Job.updated_at.desc()).limit(12)
    else:
        jobs = Job.query.filter(Job.is_enable.is_(True)).order_by(Job.updated_at.desc()).limit(10)
    statistics = { 'job': 0, 'company': 0, 'user': 0 }
    statistics['job'] = Job.query.filter(Job.is_enable.is_(True)).count()
    statistics['company'] = Company.query.filter(Company.is_enable.is_(True)).count()
    statistics['user'] = User.query.filter(User.is_enable.is_(True)).count()
    return render_template('index.html', active='index', jobs=jobs, companies=companies, statistics=statistics)


@front.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('front.index'))
    form = LoginForm()
    if form.validate_on_submit():
        user_data = User.query.filter_by(email=form.email.data).first()
        if not user_data:
            user_data = Company.query.filter_by(email=form.email.data).first()
            if not user_data:
                user_data = Admin.query.filter_by(email=form.email.data).first()
            if not user_data:
                flash('Login information is incorrect, please login again', 'danger')
                return redirect(url_for('front.login'))
        if not user_data.check_password(form.password.data):
            flash('Login information is incorrect, please login again', 'danger')
            return redirect(url_for('front.login'))
        if not user_data.is_enable:
            flash('This user is not available, please contact the webmaster', 'danger')
            return redirect(url_for('front.login'))
        # print(user_data)
        login_user(user_data, form.remember_me.data)
        flash('Login Successful', 'success')
        next_page = request.args.get('next')
        return redirect(next_page or url_for('front.index'))
    return render_template('login.html', form=form, active='login')


@front.route('/logout', methods=['GET', 'POST'])
@login_required
def logout():
    logout_user()
    flash('You are logged out', 'success')
    return redirect(url_for('front.index'))


@front.route('/search')
def search():
    search_type = request.args.get('type')
    kw = request.args.get('kw')
    if search_type == 'job':
        return redirect(url_for('job.index', kw=kw))
    elif search_type == 'company':
        return redirect(url_for('company.index', kw=kw))
    else:
        return redirect(url_for('front.index'))
