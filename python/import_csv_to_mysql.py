import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
import os

# ============================================
# MySQL Connection Details
# ============================================

username = "your_username"   # Replace these placeholders with your local MySQL credentials before running.
password = "your_password"   # Replace these placeholders with your local MySQL credentials before running.
host = "localhost"
port = 3306
database = "sales_analysis"

# ============================================
# CSV File Path
# ============================================

current_dir = os.path.dirname(os.path.abspath(__file__))

csv_path = os.path.join(
    current_dir,
    "..",
    "Dataset",
    "sales_data.csv"
)

# ============================================
# Create SQLAlchemy Connection URL
# ============================================

connection_url = URL.create(
    drivername="mysql+pymysql",
    username=username,
    password=password,
    host=host,
    port=port,
    database=database
)

engine = create_engine(connection_url)

# ============================================
# Read CSV
# ============================================

print("Reading CSV...")

df = pd.read_csv(csv_path)

print(f"Rows found: {len(df)}")
print(f"Columns found: {len(df.columns)}")

# ============================================
# Import into MySQL
# ============================================

print("Importing into MySQL...")

df.to_sql(
    name="orders",
    con=engine,
    if_exists="replace",
    index=False
)

print("Import completed successfully!")
print(f"Imported {len(df)} rows into table 'orders'.")
