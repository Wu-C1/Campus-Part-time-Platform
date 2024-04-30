from flask_ckeditor import CKEditorField
from flask_wtf import FlaskForm
from flask_login import current_user
from flask_wtf.file import FileField, FileRequired, FileAllowed
from wtforms import IntegerField, PasswordField, SelectField, \
    StringField, SubmitField, TextAreaField, ValidationError, BooleanField
from wtforms.validators import Email, EqualTo, Regexp, Length, URL, DataRequired
from .models import User, Company, db, Job, FINANCE_STAGE, FIELD, EDUCATION, EXP
from .app import uploaded_resume, uploaded_logo
import time
import random
import hmac


class RegisterUserForm(FlaskForm):
    def __init__(self, role=None, *args, **kwargs):
        super(RegisterUserForm, self).__init__(*args, **kwargs)
        if role == 'user':
            print('user')
            self.hobby = StringField('hobby', validators=[DataRequired(message='Please fill in your hobbies'),
                                                  Length(2, 24, message='Must be between 2 and 24 characters')])
            self.skill = TextAreaField('skill', validators=[DataRequired(message='Please fill in the skills'),
                                                    Length(2, 255, message='Must be between 2 and 255 characters')])
            self.education = StringField('education', validators=[DataRequired(message='Please fill in your education'),
                                                      Length(2, 10, message='Must be between 2 and 10 characters')])

    email = StringField('email', validators=[DataRequired(message='Please fill in the content'),
                                          Email(message='Please enter a valid email address')])
    password = PasswordField('password', validators=[DataRequired(message='Please fill in the password'),
                                               Length(6, 24, message='Must be between 6 and 24 characters'),
                                               Regexp(r'^[a-zA-Z]+\w+', message='Use only English, numbers, underscores, and begin with English')])
    repeat_password = PasswordField('repeat password', validators=[DataRequired(message='Please fill in the password'),
                                                        EqualTo('password', message='Two passwords do not match')])
    name = StringField('name', validators=[DataRequired(message='Please fill in the content'),
                                         Length(2, 8, message='Must be between 2 and 8 characters')])

    submit = SubmitField('submit')

    def validate_email(self, field):
        if User.query.filter_by(email=field.data).first() or \
                Company.query.filter_by(email=field.data).first():
            raise ValidationError('email is already in use by another account')

    def create_user(self):
        user = User()
        user.name = self.name.data
        user.email = self.email.data
        user.password = self.password.data
        if hasattr(self, 'hobby'):
            user.hobby = self.hobby.data
            user.skill = self.skill.data
            user.education = self.education.data
        user.id = int(time.time() * 100000000)
        db.session.add(user)
        db.session.commit()
        return user

class UserRegisterUserForm(FlaskForm):


    email = StringField('email', validators=[DataRequired(message='Please fill in the content'),
                                          Email(message='Please enter a valid email address')])
    password = PasswordField('password', validators=[DataRequired(message='Please fill in the password'),
                                               Length(6, 24, message='Must be between 6 and 24 characters'),
                                               Regexp(r'^[a-zA-Z]+\w+', message='Use only English, numbers, underscores, and begin with English')])
    repeat_password = PasswordField('repeat password', validators=[DataRequired(message='Please fill in the password'),
                                                        EqualTo('password', message='Two passwords do not match')])
    name = StringField('name', validators=[DataRequired(message='Please fill in the content'),
                                         Length(2, 8, message='Must be between 2 and 8 characters')])
    hobby = StringField('hobby', validators=[DataRequired(message='Please fill in your hobbies'),
                                               Length(2, 24, message='Must be between 2 and 24 characters')])
    skill = TextAreaField('skill', validators=[DataRequired(message='Please fill in the skills'),
                                                 Length(2, 255, message='Must be between 2 and 255 characters')])
    education = StringField('education', validators=[DataRequired(message='Please fill in your education'),
                                                   Length(2, 10, message='Must be between 2 and 10 characters')])
    submit = SubmitField('submit')

    def validate_email(self, field):
        if User.query.filter_by(email=field.data).first() or \
                Company.query.filter_by(email=field.data).first():
            raise ValidationError('email is already in use by another account')

    def create_user(self):
        user = User()
        user.name = self.name.data
        user.email = self.email.data
        user.password = self.password.data
        user.hobby = self.hobby.data
        user.skill = self.skill.data
        user.education = self.education.data
        user.id = int(time.time() * 100000000)
        db.session.add(user)
        db.session.commit()
        return user


class RegisterCompanyForm(FlaskForm):

    email = StringField('email', validators=[DataRequired(message='Please fill in the content'),
                                          Email(message='Please enter a valid email address')])
    password = PasswordField('password', validators=[DataRequired(message='Please fill in the password'),
                                               Length(6, 24, message='Must be between 6 and 24 characters'),
                                               Regexp(r'^[a-zA-Z]+\w+', message='Use only English, numbers, underscores, and begin with English')])
    repeat_password = PasswordField('repeat password', validators=[DataRequired(message='Please fill in the password'),
                                                        EqualTo('password', message='Two passwords do not match')])
    name = StringField('firm name', validators=[DataRequired(message='Please fill in the content'),
                                           Length(2, 32, message='Must be between 2 and 32 characters')])
    finance_stage = SelectField('financing stage', choices=[(i, i) for i in FINANCE_STAGE])
    field = SelectField('industry sectors', choices=[(i, i) for i in FIELD])
    description = StringField('company profile', validators=[Length(0, 50, message='Up to 50 characters')])
    submit = SubmitField('submit')

    def validate_email(self, field):
        if User.query.filter_by(email=field.data).first() or \
                Company.query.filter_by(email=field.data).first():
            raise ValidationError('email is already in use by another account')

    def create_company(self):
        company = Company()
        company.name = self.name.data
        company.email = self.email.data
        company.password = self.password.data
        db.session.add(company)
        db.session.commit()
        return company


class LoginForm(FlaskForm):

    email = StringField('email', validators=[DataRequired(message='Please fill in the content'),
                                          Email(message='Please enter a valid email address')])
    password = PasswordField('password', validators=[DataRequired(message='Please fill in the password'),
                                               Length(6, 24, message='Must be between 2 and 24 characters')])
    remember_me = BooleanField('Remember login status')
    submit = SubmitField('login')



class UserInformationDetailForm(UserRegisterUserForm):

    def validate_email(self, field):
        if current_user.email != self.email.data and \
                User.query.filter_by(email=field.data).first():
            raise ValidationError('email is already in use by another account')

    def update_detail(self, user):
        user.name = self.name.data
        user.email = self.email.data
        user.password = self.password.data
        user.education = self.education.data
        user.hobby = self.hobby.data
        user.skill = self.skill.data
        db.session.add(user)
        db.session.commit()
        return user


class UserDetailForm(RegisterUserForm):

    def validate_email(self, field):
        if current_user.email != self.email.data and \
                User.query.filter_by(email=field.data).first():
            raise ValidationError('email is already in use by another account')

    def update_detail(self, user):
        user.name = self.name.data
        user.email = self.email.data
        user.password = self.password.data
        db.session.add(user)
        db.session.commit()
        return user


class UserResumeForm(FlaskForm):

    resume = FileField('Resume upload (only images are supported for the time being, up to 300KB)', validators=[
                FileAllowed(uploaded_resume, 'Non-compliance with the format of the document'),
                FileRequired('Document not selected')])
    submit = SubmitField('upload')

    def upload_resume(self, user):
        filename = uploaded_resume.save(self.resume.data, name=random_name())
        resume_url = uploaded_resume.url(filename)
        user.resume = resume_url
        db.session.add(user)
        db.session.commit()
        return resume_url


class CompanyDetailForm(FlaskForm):

    address = StringField('word address', validators=[Length(0, 128, message='Up to 128 characters')])
    logo = FileField('LOGO Upload (300KB or less)', validators=[
        FileAllowed(uploaded_logo, 'Not conforming to image format or size')])
    finance_stage = SelectField('financing stage', choices=[(i, i) for i in FINANCE_STAGE])
    field = SelectField('industry sectors', choices=[(i, i) for i in FIELD])
    website = StringField('company website', validators=[URL(message='Please enter the correct URL')])
    description = TextAreaField('company profile', validators=[Length(0, 50, message='Up to 50 characters')])
    details = CKEditorField('company details', validators=[Length(0, 1000, message='Up to 1000 characters')])
    submit = SubmitField('submit')

    def update_detail(self, company):
        try:
            self.populate_obj(company)
            filename = uploaded_logo.save(self.logo.data, name=random_name())
            logo_url = uploaded_logo.url(filename)
            company.logo = logo_url
            db.session.add(company)
            db.session.commit()
            return logo_url
        except:
            return ''


class JobForm(FlaskForm):

    name = StringField('job name', validators=[DataRequired(message='Please fill in the content'), Length(4, 64)])
    salary_min = IntegerField('minimum salary (in thousands of dollars)', validators=[DataRequired(message='请填写整数')])
    salary_max = IntegerField('maximum salary (in thousands of dollars)', validators=[DataRequired(message='请填写整数')])
    city = StringField('work city', validators=[DataRequired(message='Please fill in the content'),
                                           Length(0, 16, message='Up to 16 characters')])
    tags = StringField('post tags (separated by commas)', validators=[Length(0, 64)])
    exp = SelectField('work experience', choices=[(i, i) for i in EXP])
    education = SelectField('academic requirements', choices=[(i, i) for i in EDUCATION])
    treatment = CKEditorField('position entitlement', validators=[Length(0, 256, message='Up to 256 characters')])
    description = CKEditorField('Job Description', validators=[DataRequired(message='Please fill in the content')])
    is_enable = SelectField('publish', choices=[(True, 'publish now'), (False, 'not release')], coerce=bool)
    submit = SubmitField('submit')

    def validate_salary_min(self, field):
        if field.data <= 0 or field.data > 100:
            raise ValidationError('Fill in an integer between 0 and 100')
        if self.salary_max.data and field.data >= self.salary_max.data:
            raise ValidationError('Needs to be less than the maximum salary')

    def validate_salary_max(self, field):
        if field.data <= 0 or field.data > 100:
            raise ValidationError('Fill in an integer between 0 and 100')
        if self.salary_min.data and field.data <= self.salary_min.data:
            raise ValidationError('Needs to be greater than minimum salary')

    def create_job(self, company_id):
        job = Job()
        self.populate_obj(job)
        job.company_id = company_id
        db.session.add(job)
        db.session.commit()
        return job

    def update_job(self, job):
        self.populate_obj(job)
        db.session.add(job)
        db.session.commit()
        return job


def random_name():
    key = ''.join([chr(random.randint(48, 122)) for _ in range(20)])
    h = hmac.new(key.encode('utf-8'), digestmod='MD5')
    return h.hexdigest() + '.'
