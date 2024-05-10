from pipeline_relational_data.flow import RelationalDataFlow

rdf = RelationalDataFlow("raw_data_source.xlsx")
rdf.execute()