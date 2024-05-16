from pipeline_relational_data.flow import RelationalDataFlow
from pipeline_dimensional_data.flow import DimensionalDataFlow

rdf = RelationalDataFlow("raw_data_source.xlsx")
rdf.execute()

rdf = DimensionalDataFlow(relational_db_name="Orders_RELATIONAL_DB", relational_db_schema="dbo")
rdf.execute()