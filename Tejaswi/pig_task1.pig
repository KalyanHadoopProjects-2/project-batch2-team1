task 1:
json data:
hdfs dfs -mkdir -p /home/orienit/pig
hdfs dfs -put /home/orienit/pig/employee1.json /user/orienit/pig/employee1.json
employee1_json = LOAD '/user/orienit/pig/employee1.json' using JsonLoader ('empid:int, name:chararray, salary:int, dept:chararray');
employee1_op = filter A BY empid > 2 AND dept == 'dev';
dump employee1_op;
store employee1_op into '/user/orienit/pig/employee1_op' using PigStorage(':');



xml data:
hdfs dfs -put /home/orienit/pig/employee1.xml /user/orienit/pig/employee1.xml
Register the piggybank.jar by:
register /usr/lib/pig/piggybank.jar
employee1_xml = load '/user/orienit/pig/employee1_xml' USING org.apache.pig.piggybank.storage.XMLLoader('employee') as(doc:chararray);

employee1_op = foreach A GENERATE FLATTEN(REGEX_EXTRACT_ALL(doc,'<employee>\\s*<empid>(.*)</empid>\\s*<name>(.*)</name>\\s*<salary>(.*)</salary>\\s*<dept>(.*)</dept>\\s*</employee>')) AS (empid:int, name:chararray, salary:float, dept:chararray);

grunt> dump employee1_op;





