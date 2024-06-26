from . import tasks
from utils import get_uuid
from .config import TABLE_NAMES

class DimensionalDataFlow:
    def __init__(self, relational_db_name, relational_db_schema):
        self.relational_db_name = relational_db_name
        self.relational_db_schema = relational_db_schema
        self.execution_uuid = get_uuid()


    @staticmethod
    def create_connection():
        return tasks.connect_db_create_cursor()
    
    
    def create_database(self, cursor):
        tasks.create_database(cursor)   
        
        
    def create_tables(self, cursor):
        tasks.create_tables(cursor, "Orders_DIMENSIONAL_DB", "dbo", self.execution_uuid)  


    def insert_into_tables(self, cursor):
        for tablename in TABLE_NAMES:
            tasks.insert_into_table(cursor, tablename, self.relational_db_name, self.relational_db_schema, "Orders_DIMENSIONAL_DB", "dbo", self.execution_uuid)


    def execute(self):
        # Create a connection
        connection = DimensionalDataFlow.create_connection() 
        
        # Insert data into tables
        self.insert_into_tables(connection)
        
        # Close the connection
        connection.close()