import tasks

class RelationalDataFlow:
    def __init__(self, config, sourcedatafile):
        self.config = config
        self.sourcedatafile = sourcedatafile

    @staticmethod
    def create_connection():
        return tasks.connect_db_create_cursor("Orders_RELATIONAL_DB")

    def drop_tables(self, conn):
        for tablename in self.config.relational_table_list[::-1]:
            tasks.drop_table(conn, tablename,'Orders_RELATIONAL_DB', 'dbo')     

    def create_tables(self, conn):
        for tablename in self.config.relational_table_list:
            tasks.create_table(conn, tablename, 'Orders_RELATIONAL_DB', 'dbo')  

    def insert_into_table(self, conn):
        for tablename in self.config.relational_table_list:
            tasks.insert_into_table(conn, tablename,'Orders_RELATIONAL_DB', 'dbo', self.sourcedatafile)    

   
    def create_database(self,conn):
        tasks.create_database(conn)


    def execute(self):
        conn_Rel = RelationalDataFlow.create_connection() 
        self.drop_tables(conn_Rel)
        self.create_tables(conn_Rel)
        self.insert_into_table(conn_Rel)
        conn_Rel.close()
      
