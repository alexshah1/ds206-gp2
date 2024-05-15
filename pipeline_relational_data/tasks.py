from .config import SQL_SERVER_CONFIG_FILE
import pandas as pd
import numpy as np
import pyodbc
from utils import load_query, get_sql_config
from custom_logging import relational_logger
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
    relational_logger.info(msg="The database has been created",
                           extra={"execution_uuid": execution_uuid})


def drop_table(cursor, table_name, db, schema, execution_uuid):
    # Load the SQL script to drop a table
    drop_table_script = load_query("pipeline_relational_data/queries", "drop_table").format(db=db, schema=schema, table=table_name)
    
    # Execute the script
    cursor.execute(drop_table_script)
    cursor.commit()
    
    # Log the drop of the table
    relational_logger.info(msg=f"The {schema}.{table_name} table from the database {db} has been dropped.",
                           extra={"execution_uuid": execution_uuid})
    
    
def truncate_table(cursor, table_name, db, schema, execution_uuid):
    # Load the SQL script to create the tables
    create_table_script = load_query("pipeline_relational_data/queries", "truncate_table.sql").format(db=db, schema=schema, table=table_name)
    
    # Execute the script
    cursor.execute(create_table_script)
    cursor.commit()
    
    # Log the creation of the tables
    relational_logger.info(msg=f"The {schema}.{table_name} table from the database {db} has been truncated.",
                           extra={"execution_uuid": execution_uuid})
    
    
def create_tables(cursor, db, schema, execution_uuid):
    # Load the SQL script to create the tables
    create_table_script = load_query("infrastructure_initiation", "relational_db_table_creation.sql").format(db=db, schema=schema)
    
    # Execute the script
    cursor.execute(create_table_script)
    cursor.commit()
    
    # Log the creation of the tables
    relational_logger.info(msg=f"The tables in the database {db}.{schema} have been created.",
                           extra={"execution_uuid": execution_uuid})


def insert_into_table(cursor, table_name, db, schema, raw_source_data_path, execution_uuid):
    # Read the excel table
    df = pd.read_excel(raw_source_data_path, sheet_name=table_name, header=0)

    # Load the SQL script to insert into a table
    insert_into_table_script = load_query("pipeline_relational_data/queries", f"insert_into_{table_name}").format(db=db, schema=schema)

    if table_name == "Employees":
        df.sort_values(by='ReportsTo', ascending=True, na_position='first', inplace=True)
        df['ReportsTo'] = df['ReportsTo'].astype("Int64")
        
    df.replace({np.nan: None, np.inf: None, -np.inf: None}, inplace=True)
        
    # Populate a table in SQL server
    for _, row in df.iterrows():
        # Execute the script
        try:
            cursor.execute(insert_into_table_script, *row)
            cursor.commit()
        except:
            print("Table name:, table_name")
            print("data", *row)
            print(traceback.format_exc())
            raise Exception("Please come and fix me, my lord! Watch Shōgun.")
        

    relational_logger.info(msg=f"{len(df)} rows have been inserted into the {db}.{schema}.{table_name} table.",
                           extra={"execution_uuid": execution_uuid})    
