hbase org.apache.hadoop.hbase.mapreduce.Export "employee1_csv" "/user/orienit/kalyan/hbase/employee1_csv" 

hbase org.apache.hadoop.hbase.mapreduce.Import 'employee1_csv' '/user/orienit/kalyan/hbase/employee1_csv'

Properties
---------------------------------------------------
-Dmapreduce.output.fileoutputformat.compress=true 
-Dmapreduce.output.fileoutputformat.compress.codec=org.apache.hadoop.io.compress.GzipCodec
-Dhbase.mapreduce.scan.row.start=0 
-Dhbase.mapreduce.scan.row.stop=6 