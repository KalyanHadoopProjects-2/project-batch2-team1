hdfs dfs -put /home/orienit/Desktop/Narendra/nosql/ /user/orienit/nosql

CSV
-----------------------------
create 'employee1_csv', 'cf'
hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=HBASE_ROW_KEY,cf:name,cf:salary,cf:dept -Dimporttsv.separator=, 'employee1_csv' /user/orienit/nosql/employee1.csv
scan 'employee1_csv'
scan 'employee1_csv', {FILTER => "ValueFilter( =, 'substring:dev')"}


TSV
----------------------
create 'employee1_tsv', 'cf'
hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=HBASE_ROW_KEY,cf:name,cf:salary,cf:dept 'employee1_tsv' /user/orienit/nosql/employee1.tsv
scan 'employee1_tsv'
scan 'employee1_tsv', {FILTER => "ValueFilter( =, 'substring:dev')"}


Properties
---------------------------------------------------
-Dimporttsv.skip.bad.lines = false 				– fail if encountering an invalid line
-Dimporttsv.separator      = , 					– eg separate on , instead of tabs
-Dimporttsv.timestamp      = currentTimeAsLong 	– use the specified timestamp for the import
-Dimporttsv.mapper.class   = my.Mapper 			– A user-defined Mapper to use instead of org.apache.hadoop.hbase.mapreduce.TsvImporterMapper