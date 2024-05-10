from pipeline_relational_data.flow import RelationalDataFlow

# connection = RelationalDataFlow.create_connection()
# rdf = RelationalDataFlow("raw_data_source.xlsx")
# rdf.drop_tables(connection)

rdf = RelationalDataFlow("raw_data_source.xlsx")
rdf.execute()