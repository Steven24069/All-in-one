from flask import Flask, render_template, request, redirect, url_for, session

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Thay 'your_secret_key' bằng một giá trị bất kỳ

# Danh sách người dùng mẫu (trong thực tế, bạn sẽ lưu trữ thông tin này trong cơ sở dữ liệu)
users = {'admin': '123456', 'user1': 'password456'}

@app.route('/')
def home():
    return 'Trang chủ'

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        # Xử lý đăng nhập
        username = request.form['username']
        password = request.form['password']

        if username in users and users[username] == password:
            session['username'] = username  # Lưu tên người dùng vào phiên làm việc
            return render_template('success.html', username=username)
        else:
            return 'Đăng nhập không thành công. <a href="/login">Thử lại</a>'
    
    return render_template('login.html')


@app.route('/success')
def success():
    if 'username' in session:
        return render_template('success.html')
    return redirect(url_for('login'))

@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)
