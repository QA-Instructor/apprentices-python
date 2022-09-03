from flask import Flask, render_template

app = Flask(__name__)


@app.route("/")
def main_page():
    return "Hello from Flask!"


@app.route("/bye")
def bye_page():
    return "Goodbye from Flask!"


@app.route("/greeting")
def greeting_page():
    return "Greetings from Flask!"


@app.route("/greeting2")
def greeting2_page():
    return "Greetings2 from Flask!"


@app.route("/static")
def static_page():
    return """
    <html>
    <head>
        <title>Simple Static Page</title>
    </head>
    <body>
        <h1>Static Page</h1>
        <p>This is a static page.</p>
    </body>
    </html>
    """


@app.route("/name/<name>/")
def dynamic_url(name):
    return """
<html>
<head>
    <title>Sample - Flask routes</title>
</head>
<body>
    <h1>Name page</h1>    
    <p>Hello {}!</p>
</body>
</html>
""".format(name)


@app.route("/age/<int:age>/")
def type_url(age):
    return """
<html>
<head>
    <title>Sample - Flask routes</title>
</head>
<body>
    <h1>Age page</h1>    
    <p>You are {} years old.</p>
</body>
</html>
""".format(age)


@app.route("/hello/<name>/")
def template_base(name):
    return render_template('base.html', name=name, group="Everyone")


@app.route("/loop/<name>/")
def loop_demo(name):
    return render_template('favourites.html', my_list=['Pilates', 'Cats', 'Chocolate'], name=name, group="Team")


@app.errorhandler(500)
def internal_500_error(error):
    return render_template('500.html', errors=[error]), 500


@app.errorhandler(404)
def internal_404_error(error):
    return render_template('404.html', errors=[error]), 404
