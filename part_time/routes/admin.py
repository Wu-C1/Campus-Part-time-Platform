#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Blueprint, render_template, \
    current_app, redirect, url_for, flash, request
from flask_login import login_user, current_user

from ..forms import UserDetailForm
from ..models import User, Job, Company
from ..decorators import admin_required

admin = Blueprint('admin', __name__, url_prefix='/admin')


# @admin.route('/')
# @admin_required
# def index():
#     return render_template('admin/index.html')


@admin.route('/user')
@admin_required
def user():
    page = request.args.get('page', default=1, type=int)
    pagination = User.query.paginate(
        page=page,
        per_page=current_app.config['LIST_PER_PAGE'],
        error_out=False
    )
    return render_template('admin/user.html', pagination=pagination, panel='user', active='manage')


@admin.route('/company')
@admin_required
def company():
    page = request.args.get('page', default=1, type=int)
    pagination = Company.query.paginate(
        page=page,
        per_page=current_app.config['LIST_PER_PAGE'],
        error_out=False
    )
    return render_template('admin/company.html', pagination=pagination, panel='company', active='manage')


@admin.route('/job')
@admin_required
def job():
    page = request.args.get('page', default=1, type=int)
    pagination = Job.query.paginate(
        page=page,
        per_page=current_app.config['LIST_PER_PAGE'],
        error_out=False
    )
    return render_template('admin/job.html', pagination=pagination, panel='job', active='manage')


# @admin.route('/resume')
# @admin_required
# def resume():
#     page = request.args.get('page', default=1, type=int)
#     content = User.query.paginate(
#         page=page,
#         per_page=current_app.config['LIST_PER_PAGE'],
#         error_out=False
#     )
#     return render_template('admin/resumes.html', content=content)

@admin.route('/account', methods=['GET', 'POST'])
@admin_required
def edit():
    if not current_user.is_admin():
        return redirect(url_for("front.index"))
    form = UserDetailForm(obj=current_user)
    if form.validate_on_submit():
        form.update_detail(current_user)
        flash('Personal Information Updated Successfully', 'success')
        return redirect(url_for('admin.edit'))
    return render_template('admin/edit.html', form=form, active='manage', panel='edit')
