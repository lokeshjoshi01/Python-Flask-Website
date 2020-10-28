from flask import Flask, render_template , request ,redirect, session,request_finished , got_request_exception ,request
from flask_sqlalchemy import SQLAlchemy
# from werkzeug import secure_filename
from flask_mail import Mail
import json
from datetime import datetime
import os
import math

with open('config.json', 'r') as c:
    params = json.load(c)["params"]

local_server = True
app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config['UPLOAD_FOLDER'] = params['upload_location']
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password']
)
mail = Mail(app)
if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)

class Contact(db.Model):
    Sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone = db.Column(db.String(12), nullable=False)
    massage = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(50), nullable=True)
    email = db.Column(db.String(150), nullable=False)

class Post(db.Model):
    Sno = db.Column(db.Integer, primary_key=True)
    Title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    Content = db.Column(db.String(50000), nullable=False)
    tagline = db.Column(db.String(1200), nullable=False)
    Date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(25), nullable=True)

@app.route("/")
def indexx():
    return render_template('index.html',params=params)

@app.route("/")
def home():
    post = Post.query.filter_by().all()
    # [0:params['no_of_posts']]
    last = math.floor(len(post)/int(params['no_of_posts']))
    page = request.args.get('page')
    page = int('page')
    if(not int(page).isnumeric()):
        page = 1
    # post = post(page-1)*int(params['no_of_posts'])) : (page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])))
    if (page==1):
        prev = "#"
        next = "/?number="+str(page-1)
    elif(page==last):
        prev = "/?number=" + str(page + 1)
        next = "#"
    else:
        prev = "/?number=" + str(page - 1)
        next = "/?number=" + str(page + 1)

    return render_template('index.html', params=params, post=post,prev=prev,next=next)

@app.route("/post/<string:post_slug>", methods=['GET','POST'])
def post_route(post_slug):
    post = Post.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)

@app.route("/about")
def about():
    return render_template('about.html',params=params)

@app.route("/dashboard", methods=['GET','POST'])
def dashboard():

    if not session.get('logged_in'):
        return render_template('dashboard.html',params=params)
    if(request.methods=='POST'):
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if (username==params['admin_user'], userpass==params['admin_password']):
            # set the session variable
            session['uname'] = username
            return render_template('dashboard.html', params=params)
            posts = Posts.query.all()
    else:
        return render_template('dashboard.html', params=params,post=post)

@app.route("/uploader", methods = ['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if (request.method == 'POST'):
            f=request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return "Upload successfully"

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/delete/<string:Sno>",methods = ['GET','POST'])
def delete(Sno):
    if ('user' in session and session['user'] == params['admin_user']):
        post = Post.query.filter_by(Sno=Sno).first()
        db.session.add(post)
        db.session.commit()
    return redirect('/dashboard')

@app.route("/contact", methods = ['GET', 'POST'])
def contactss():
    if(request.method=='POST'):
        '''Add entry to the database'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        massage = request.form.get('massage')
        entry = Contact(name=name, email=email, phone=phone, date=datetime.now(), massage=massage )
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New message from ' + name,
                          sender=email,
                          recipients=[params['gmail-user']],
                          body=massage + "\n" + phone
                          )
    return render_template('contact.html',params=params)

@app.route("/layout")
def layout():
    return render_template('layout.html',params=params)

@app.route("/edit/<string:Sno>", methods = ['GET', 'POST'])
def edit(Sno):
    if ('user' in session and session['user']==params['admin_user']):
        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            Content = request.form.get('Content')
            img_file = request.form.get('img_file')
            Date = datetime.now()
            if Sno==0:
                post = Post(title=box_title,slug=slug,content=Content,img_file=img_file,tagline=tline,date=Date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Post.query.filter_by(Sno=Sno).first()
                post.title = box_title
                post.slug = slug
                post.content = Content
                post.tagline = tline
                post.img_file = img_file
                post.date = Date
                db.session.commit()
                return redirect('/edit'+ Sno)
        post = Post.query.filter_by(Sno=Sno).first()

        return render_template('edit.html', params=params,post=post,Sno=Sno)

app.run(debug=True)
