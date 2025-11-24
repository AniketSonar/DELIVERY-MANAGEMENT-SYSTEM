# Delivery Management System

A Flask-based web application designed to streamline delivery operations. It allows Delivery Associates (DA) to log their daily routes, parcels, and cash collections, while providing Admins with a dashboard to monitor performance and employee data.

## 📋 Features

### User (Delivery Associate) Features

  * **Secure Login:** Individual accounts for delivery personnel.
  * **User Dashboard:** View personal statistics including:
      * Total parcels delivered, attempted, and rejected.
      * **Success Rate Calculation:** automatically calculates performance percentage with a logic that accounts for acceptable reject/attempt limits (5% buffer).
  * **Start/End Route Reporting:**
      * Form to input daily data (Delivered, Delivery Attempt, Pickup, Reject, etc.).
      * **Cash Denomination Calculator:** Input count of specific currency notes (500, 200, 100, etc.) to auto-calculate total cash deposit.
      * **Odometer Tracking:** Input kilometer readings and upload an image of the odometer.
  * **Performance History:** View past data records.

### Admin Features

  * **Admin Dashboard:** Aggregated view of all delivery statistics across the company.
  * **Employee Management:** View a list of all registered employees ("My Employee").
  * **Data Monitoring:** Access detailed logs of daily data submitted by all users ("Employee Data").

## 🛠️ Tech Stack

  * **Backend:** Python, Flask
  * **Database:** MySQL (using `mysql.connector`)
  * **Frontend:** HTML, CSS (Bootstrap), JavaScript
  * **Deployment/Server:** Gunicorn (optional for production)

## 📂 Project Structure

```text
DELIVERY-MANAGEMENT-SYSTEM/
├── app.py                  # Main Flask application logic
├── amazon.sql              # Database schema and dump
├── requirements.txt        # Python dependencies
├── templates/              # HTML templates (Login, Dashboard, etc.)
│   ├── admin_dashboard.html
│   ├── user_dashboard.html
│   ├── start-route.html
│   └── ...
└── static/                 # Static assets
    ├── assets/css/         # Stylesheets
    ├── assets/js/          # Scripts (Cash calc, Toggle password)
    └── uploads/            # Folder for uploaded odometer images
```

## ⚙️ Installation & Setup

### 1\. Prerequisites

  * Python 3.x
  * MySQL Server (e.g., XAMPP or local MySQL installation)

### 2\. Clone the Repository

Download the project files to your local machine.

### 3\. Install Dependencies

Navigate to the project directory and install the required Python packages:

```bash
pip install flask mysql-connector-python gunicorn
```

### 4\. Database Setup

**Important Note on Table Names:**
The Python code (`app.py`) expects a table named `da_data` to store route information, but the provided SQL file (`amazon.sql`) creates a table named `end_route`. You must ensure the table name matches the code.

1.  Open your MySQL tool (e.g., phpMyAdmin).
2.  Create a new database named `amazon_30cp` (or update `app.py` to match your preferred name).
3.  Import the `amazon.sql` file provided in the root directory.
4.  **Rename the table:** inside your database, rename the table `end_route` to `da_data` so the application can read/write data correctly.

### 5\. Configure Database Connection

Open `app.py` and locate the `get_db_connection` function. Update the credentials to match your local MySQL setup (the current code points to a remote Render database):

```python
# app.py

def get_db_connection():
    return mysql.connector.connect(
        host='localhost',          # Change to localhost for local testing
        user='root',               # Your MySQL username
        password='',               # Your MySQL password
        database='amazon_30cp'     # Your database name
    )
```

## 🚀 Usage

1.  **Run the Application:**
    ```bash
    python app.py
    ```
2.  **Access the App:**
    Open your web browser and go to `http://127.0.0.1:5000`.

### 🔑 Default Credentials

You can use the following pre-configured credentials found in `setup.txt` to test the system:

**Admin Login:**

  * **Username:** `Aniket`
  * **Password:** `Aniket@23`

**User (DA) Logins:**

  * **Username:** `SonarAniket` | **Password:** `Aniket@23`
  * **Username:** `Karan`       | **Password:** `Karan@23`
  * **Username:** `Chandrakant` | **Password:** `Chandu@23`

## 📝 Success Rate Logic

The system calculates a "Success Rate" for drivers using the following logic found in `app.py`:

1.  Calculates `Total` workload (Delivered + Attempts + Rejects + Volumetric).
2.  Sets a **5% Limit** buffer for acceptable Attempts and Rejects.
3.  Adjusts the total based on whether the driver stayed within the 5% buffer.
4.  Result: `(Delivered / Effective Total) * 100`.
