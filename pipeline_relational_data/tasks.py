import config
import os
import pandas as pd
import pyodbc
import utils
from utils import load_query, get_sql_config, spread

def connect_db_create_cursor(database_conf_name):
    # Call to read the configuration file
    db_conf = get_sql_config(config.sql_server_config, database_conf_name)
    # Create a connection string for SQL Server
    db_conn_str = 'Driver={};Server={};Database={};Trusted_Connection={};'.format(*db_conf)
    # Connect to the server and to the desired database
    db_conn = pyodbc.connect(db_conn_str)
    # Create a Cursor class instance for executing T-SQL statements
    db_cursor = db_conn.cursor()
    return db_cursor


def create_database(cursor):
    create_database_script = load_query('relational_db_creation.sql')
    print(create_database_script)
    # Execute a SQL command to create a database
    cursor.execute(create_database_script)
    cursor.commit()
    print("The database has been created")

def drop_table(cursor, table_name, db, schema):
    drop_table_script = load_query('queries','drop_table').format(db=db, schema=schema, table=table_name)
    cursor.execute(drop_table_script)
    cursor.commit()
    print("The {schema}.{table_name} table from the database {db} has been dropped".format(db=db, schema=schema,
                                                                                       table_name=table_name))
def create_tables(cursor, db, schema):
    create_table_script = load_query('../infrastucture_initiation','create_table').format(db=db, schema=schema)
    cursor.execute(create_table_script)
    cursor.commit()
    print("The {schema}.{table_name} table from the database {db} has been created".format(db=db, schema=schema, table_name=table_name))

def insert_into_table(cursor, table_name, db, schema, source_data):
    # Read the excel table
    df = pd.read_excel(source_data, sheet_name = table_name)

    insert_into_table_script = load_query('insert_into_{}'.format(table_name)).format(db=db, schema=schema)

    # Populate a table in sql server
    for index, row in df.iterrows():
        cursor.execute(insert_into_table_script, *utils.spread(row))
        cursor.commit()

    print(f"{len(df)} rows have been inserted into the {db}.{schema}.{table_name} table")

