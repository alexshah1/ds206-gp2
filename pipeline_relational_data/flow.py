from . import tasks
from utils import get_uuid
from .config import TABLE_NAMES

class RelationalDataFlow:
    def __init__(self, raw_source_data_path):
        self.raw_source_data_path = raw_source_data_path
        self.execution_uuid = get_uuid()


    @staticmethod
    def create_connection():
        return tasks.connect_db_create_cursor()
    
    
    def create_database(self, cursor):
        tasks.create_database(cursor)   
        
        
    def create_tables(self, cursor):
        tasks.create_tables(cursor, "Orders_RELATIONAL_DB", "dbo", self.execution_uuid)  


    def insert_into_table(self, cursor):
        for tablename in TABLE_NAMES:
            tasks.insert_into_table(cursor, tablename, "Orders_RELATIONAL_DB", "dbo", self.raw_source_data_path, self.execution_uuid)
        
        
    def drop_tables(self, cursor):
        for tablename in TABLE_NAMES[::-1]:
            tasks.drop_table(cursor, tablename, "Orders_RELATIONAL_DB", "dbo", self.execution_uuid)  
        
        
    def truncate_tables(self, cursor):
        for tablename in TABLE_NAMES[::-1]:
            tasks.truncate_table(cursor, tablename, "Orders_RELATIONAL_DB", "dbo", self.execution_uuid)  


    def execute(self):
        # Create a connection
        connection = RelationalDataFlow.create_connection() 
        
        # Task 7 changed, no need to drop/create tables
        # # Drop tables
        # self.drop_tables(connection)
        
        # # Create tables
        # self.create_tables(connection)
        
        # Insert data into tables
        self.insert_into_table(connection)
        
        # Close the connection
        connection.close()