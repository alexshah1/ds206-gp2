import tasks
from utils import extract_tables_db, get_uuid
from logging import logger

class RelationalDataFlow:
    def __init__(self, config, raw_source_data_path):
        self.config = config
        self.raw_source_data_path = raw_source_data_path
        self.execution_uuid = get_uuid()


    @staticmethod
    def create_connection():
        return tasks.connect_db_create_cursor("Orders_RELATIONAL_DB")
    
    
    def create_database(self, cursor):
        tasks.create_database(cursor)   
        
        
    def create_tables(self, cursor):
        tasks.create_tables(cursor, 'Orders_RELATIONAL_DB', 'dbo')  


    def insert_into_table(self, cursor):
        for tablename in extract_tables_db(cursor):
            tasks.insert_into_table(cursor, tablename,'Orders_RELATIONAL_DB', 'dbo', self.raw_source_data_path)
        
        
    def drop_tables(self, cursor):
        for tablename in extract_tables_db(cursor):
            tasks.drop_table(cursor, tablename,'Orders_RELATIONAL_DB', 'dbo')  


    def execute(self):
        # Create a connection
        connection = RelationalDataFlow.create_connection() 
        
        # Get the cursor
        cursor = connection.cursor() 
        
        # Drop tables
        self.drop_tables(cursor)
        
        # Create tables
        self.create_tables(cursor)
        
        # Insert data into tables
        self.insert_into_table(cursor)
        
        # Close the connection
        connection.close()