from . import tasks
from utils import get_tables, get_uuid
from custom_logging import setup_logger

class RelationalDataFlow:
    def __init__(self, raw_source_data_path):
        self.raw_source_data_path = raw_source_data_path
        self.execution_uuid = get_uuid()
        self.logger = setup_logger(self.execution_uuid, "relational", "logs")


    @staticmethod
    def create_connection():
        return tasks.connect_db_create_cursor()
    
    
    def create_database(self, cursor):
        tasks.create_database(cursor)   
        
        
    def create_tables(self, cursor):
        tasks.create_tables(cursor, 'Orders_RELATIONAL_DB', 'dbo', self.logger)  


    def insert_into_table(self, cursor):
        for tablename in get_tables("relational"):
            tasks.insert_into_table(cursor, tablename,'Orders_RELATIONAL_DB', 'dbo', self.raw_source_data_path, self.logger)
        
        
    def drop_tables(self, cursor):
        for tablename in get_tables("relational"):
            tasks.drop_table(cursor, tablename,'Orders_RELATIONAL_DB', 'dbo', self.logger)  


    def execute(self):
        # Create a connection
        connection = RelationalDataFlow.create_connection() 
        
        # Drop tables
        self.drop_tables(connection)
        
        # Create tables
        self.create_tables(connection)
        
        # Insert data into tables
        self.insert_into_table(connection)
        
        # Close the connection
        connection.close()