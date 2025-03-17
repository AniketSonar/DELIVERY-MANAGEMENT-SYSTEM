from flask import Flask, request, render_template, redirect, url_for, session, flash, get_flashed_messages
from decimal import Decimal
import mysql.connector

app = Flask(__name__)
app.secret_key = 'your_secret_key'  

# Function to connect to the database
def get_db_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database='amazon'
    )

# Home Page
@app.route('/')
def index():
    return render_template('login.html')

# Dashboard (Main Webpage after login)
@app.route('/user_dashboard')
def user_dashboard():
    if 'username' in session:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Fetch summed data for the cards
        cursor.execute("""
            SELECT 
                IFNULL(SUM(delivered), 0),
                IFNULL(SUM(delivery_attempt), 0),
                IFNULL(SUM(reject), 0),
                IFNULL(SUM(pickup_done), 0),
                IFNULL(SUM(mfn), 0),
                IFNULL(SUM(volumetric_parcel), 0)
            FROM da_data
            WHERE username = %s
        """, (session['username'],))
        data = cursor.fetchone()

        cursor.close()
        conn.close()

        # Extract values
        delivered = data[0]
        delivery_attempt = data[1]
        reject = data[2]
        volumetric_parcel = data[5]
        total = delivered + delivery_attempt + reject + volumetric_parcel
        #100 = 70 + 10 + 10 + 10

        # Acceptable reject and attempt limit (5% each)
        limit = Decimal('0.05') * total  # Convert 0.05 to Decimal
        # 5% of 100 = 5
        acceptable_attempts = max(0, delivery_attempt - limit)
        # 5 = 10 - 5 
        acceptable_rejects = max(0, reject - limit)
        # 5 = 10 - 5

        # Adjusted total
        effective_total = delivered + acceptable_attempts + acceptable_rejects 
        # 80 = 70 + 5 + 5 

        # Calculate success rate (avoid division by zero)
        success_rate = (delivered / effective_total * 100) if effective_total > 0 else 0
        # 87.5 = 70 / 80 * 100

        card_data = {
            'total' : total,
            'delivered': delivered,
            'delivery_attempt': delivery_attempt,
            'reject': reject,
            'pickup_done': data[3],
            'mfn': data[4],
            'volumetric_parcel': volumetric_parcel,
            'success_rate': round(success_rate, 2)  # Rounded to 2 decimal places
        }

        return render_template('user_dashboard.html', username=session['username'], card_data=card_data)
    
    return redirect(url_for('login'))


# Start and End Route Page
@app.route('/start-route', methods=['GET', 'POST'])
def start_route():
    if 'username' in session:
        if request.method == 'POST':
            delivered = request.form.get('delivered')
            delivery_attempt = request.form.get('delivery_attempt')
            pickup_done = request.form.get('pickup_done')
            reject = request.form.get('reject')
            mfn = request.form.get('mfn')
            mpos = request.form.get('mpos')
            c2d = request.form.get('c2d')
            volumetric_parcel = request.form.get('volumetric_parcel')
            oda_km = request.form.get('oda_km')
            odometer_kms = request.form.get('odometer_kms')
            odometer_image = request.files.get('odometer_image')

            # Cash notes
            cash_500 = request.form.get('cash_500', 0)
            cash_200 = request.form.get('cash_200', 0)
            cash_100 = request.form.get('cash_100', 0)
            cash_50 = request.form.get('cash_50', 0)
            cash_20 = request.form.get('cash_20', 0)
            cash_10 = request.form.get('cash_10', 0)
            cash_5 = request.form.get('cash_5', 0)
            cash_2 = request.form.get('cash_2', 0)
            cash_1 = request.form.get('cash_1', 0)

            total_cash_deposit = request.form.get('total_cash_deposit')

            routes = request.form.getlist('checkbox') 
            
           
            routes_str = ','.join(routes)

            # Save the odometer image to a directory
            if odometer_image:
                odometer_image_path = f'static/uploads/{odometer_image.filename}'
                odometer_image.save(odometer_image_path)

            # Save the form data to the database
            conn = get_db_connection()
            cursor = conn.cursor()

            cursor.execute("""
                INSERT INTO da_data (username, delivered, delivery_attempt, pickup_done, reject, mfn, mpos, c2d, volumetric_parcel, oda_km, odometer_kms, odometer_image, cash_500, cash_200, cash_100, cash_50, cash_20, cash_10, cash_5, cash_2, cash_1, total_cash_deposit, routes)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (session['username'], delivered, delivery_attempt, pickup_done, reject, mfn, mpos, c2d, volumetric_parcel, oda_km, odometer_kms, odometer_image_path, cash_500, cash_200, cash_100, cash_50, cash_20, cash_10, cash_5, cash_2, cash_1, total_cash_deposit, routes_str))

            conn.commit()
            cursor.close()
            conn.close()

            flash('Details submitted successfully!', 'success')
            return redirect(url_for('user_dashboard')) 
        else:
            return render_template('start-route.html', username=session['username'])
    return redirect(url_for('login'))

# Login Page
@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM employee WHERE BINARY username = %s AND BINARY password = %s", (username, password))
        user = cursor.fetchone()

        cursor.close()
        conn.close()

        if user:
            session['username'] = username  # Store username in session
            role = user[6]  
            if role == 'admin':
                return redirect(url_for('admin_dashboard'))
            else:
                return redirect(url_for('user_dashboard'))
        else:
            return "Invalid Credentials. Please try again."

    return render_template('login.html')

# Register Page
@app.route('/register', methods=['POST', 'GET'])
def register():
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        username = request.form.get('username')
        password = request.form.get('password')
        role = request.form.get('role', 'user')  # Default role is 'user'

        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM employee WHERE username = %s", (username,))
        if cursor.fetchone():
            cursor.close()
            conn.close()
            return "Username already exists. Please choose another one."

        cursor.execute("INSERT INTO employee (name, email, username, password, role) VALUES (%s, %s, %s, %s, %s)", (name, email, username, password, role))
        conn.commit()

        cursor.close()
        conn.close()

        return redirect(url_for('login'))

    return render_template('register.html')

# Logout
@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect(url_for('login'))

@app.route('/da_data')
def da_data():
    if 'username' in session:
        conn = get_db_connection()
        cursor = conn.cursor()

        
        cursor.execute("SELECT * FROM da_data WHERE username = %s", (session['username'],))
        all_data = cursor.fetchall()

        cursor.close()
        conn.close()

        return render_template('da_data.html',username=session['username'], all_data=all_data)
    return redirect(url_for('login'))

@app.route('/admin_dashboard')
def admin_dashboard():
    if 'username' in session:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Fetch summed data for the cards
        cursor.execute("""
            SELECT 
                IFNULL(SUM(delivered), 0),
                IFNULL(SUM(delivery_attempt), 0),
                IFNULL(SUM(pickup_done), 0),
                IFNULL(SUM(mfn), 0),
                IFNULL(SUM(reject), 0),
                IFNULL(SUM(volumetric_parcel), 0)
            FROM da_data
        """)
        data = cursor.fetchone()

        cursor.close()
        conn.close()

        # Extract values
        delivered = data[0]
        delivery_attempt = data[1]
        reject = data[2]
        volumetric_parcel = data[5]
        total = delivered + delivery_attempt + reject + volumetric_parcel
        #773

        # Acceptable reject and attempt limit (5% each)
        limit = Decimal('0.05') * total  # Convert 0.05 to Decimal
        # 38.65
        acceptable_attempts = max(0, delivery_attempt - limit)
        # 56
        acceptable_rejects = max(0, reject - limit)
        # 59

        # Adjusted total
        effective_total = delivered + acceptable_attempts + acceptable_rejects 
        # 596

        # Calculate success rate (avoid division by zero)
        success_rate = (delivered / effective_total * 100) if effective_total > 0 else 0
        # 

        card_data = {
            'total' : total,
            'delivered': delivered,
            'delivery_attempt': delivery_attempt,
            'reject': reject,
            'pickup_done': data[3],
            'mfn': data[4],
            'volumetric_parcel': volumetric_parcel,
            'success_rate': round(success_rate, 2)  # Rounded to 2 decimal places
        }

        return render_template('admin_dashboard.html', username=session['username'], card_data=card_data)
    return redirect(url_for('login'))

@app.route('/employee_data')
def employee_data():
    if 'username' in session:
        name = request.args.get('name')
        conn = get_db_connection()
        cursor = conn.cursor()

        if name:
            cursor.execute("SELECT * FROM da_data WHERE username = %s", (name,))
            content = name
        else:
            cursor.execute("SELECT * FROM da_data")
            content = "All Employees Data"

        employee_data = cursor.fetchall()

        cursor.close()
        conn.close()

        return render_template('employee_data.html', content=content, employee_data=employee_data, username=session['username'])
    return redirect(url_for('login'))

@app.route('/my_employee')
def my_employee():
    if 'username' in session:
        name = request.args.get('name')
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM employee WHERE role = 'user'")

        employee_data = cursor.fetchall()

        cursor.close()
        conn.close()

        return render_template('my_employee.html', employee_data=employee_data, username=session['username'])
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)
