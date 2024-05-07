import configparser
import os

def get_sql_config(filename, database):
    # Read the configuration file
    cf = configparser.ConfigParser ()
    cf.read (filename)
    
    # Read corresponding file parameters
    _driver = cf.get(database,"DRIVER")
    _server = cf.get(database,"Server")
    _database = cf.get(database,"Database")
    _trusted_connection = cf.get(database,"Trusted_Connection")
    
    return _driver, _server, _database, _trusted_connection

def load_query(query_dir, query_name):
    for file in os.listdir(query_dir):
        if query_name in file:
            with open(query_dir + '\\' + file, 'r') as script_file:
                return script_file.read()