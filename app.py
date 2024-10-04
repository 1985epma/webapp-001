from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/services')
def services():
    return render_template('services.html')

@app.route('/about')
def about():
    return render_template('about.html')

if __name__ == '__main__':
    # Executando a aplicação na porta 5005
    app.run(host='0.0.0.0', port=5005)