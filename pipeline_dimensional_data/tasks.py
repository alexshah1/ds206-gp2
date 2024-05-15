from .config import SQL_SERVER_CONFIG_FILE
import pyodbc
from utils import load_query, get_sql_config
from custom_logging import dimensional_logger
import traceback


def connect_db_create_cursor():
    # Call to read the configuration file
    db_conf = get_sql_config(SQL_SERVER_CONFIG_FILE, "RelationalDatabase")
    
    # Create a connection string for SQL Server
    db_conn_str = "Driver={};Server={};Database={};Trusted_Connection={};".format(*db_conf)
    
    # Connect to the server and to the desired database
    db_conn = pyodbc.connect(db_conn_str)
    
    # Create a Cursor class instance for executing T-SQL statements
    db_cursor = db_conn.cursor()
    
    return db_cursor


def create_database(cursor, execution_uuid):
    # Load the SQL script to create a database
    create_database_script = load_query("infrastructure_initiation", "relational_db_creation.sql")
    
    # Execute the script
    cursor.execute(create_database_script)
    cursor.commit()
    
    # Log the creation of the database
    dimensional_logger.info(msg="The database has been created",
                           extra={"execution_uuid": execution_uuid})
    
    
def create_tables(cursor, db, schema, execution_uuid):
    # Load the SQL script to create the tables
    create_table_script = load_query("infrastructure_initiation", "relational_db_table_creation.sql").format(db=db, schema=schema)
    
    # Execute the script
    cursor.execute(create_table_script)
    cursor.commit()
    
    # Log the creation of the tables
    dimensional_logger.info(msg=f"The tables in the database {db} have been created.",
                           extra={"execution_uuid": execution_uuid})


def insert_into_table(cursor, table_name, db, schema, execution_uuid):
    # Load the SQL script to insert data into the tables
    insert_into_table_script = load_query("pipeline_dimensional_data/queries", f"update_{table_name}.sql") ##.format(db=db, schema=schema, table=table_name) TODO
    
    # Execute the script
    cursor.execute(insert_into_table_script)
    cursor.commit()
    
    # Log the insertion of data into the tables
    dimensional_logger.info(msg=f"Data has been inserted into/updated the {db}.{schema}.{table_name} table from the relational database.",
                           extra={"execution_uuid": execution_uuid})