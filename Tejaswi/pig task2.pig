task2:

loading json file:
----------------------
hdfs dfs -mkdir -p /home/orienit/pig
hadoop fs -put /home/orienit/pig/employee2.json /user/orienit/pig/employee2_json

in hive 
create table if not exists kalyan.employee2_json(empid int,name string,salary int,dept string) 
row format serde 'org.apache.hive.hcatalog.data.JsonSerDe' stored as textfile;

LOAD DATA  INPATH '/user/orienit/pig/employee2.json' INTO TABLE kalyan.employee2_json;


 
 loading xml:
 ----------------
 hdfs dfs -mkdir -p /home/orienit/pig
hdfs dfs -put /home/orienit/pig/employee2_xml /user/orienit/pig/employee2_xml

create table if not exist kalyan.employee2_xml(empid int,name string,salary string,dept string)
ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
WITH SERDEPROPERTIES (
"column.xpath.empid"="/employee/empid/text()",
"column.xpath.name"="/employee/name/text()",
"column.xpath.salary"="/employee/salary/text()",
"column.xpath.dept"="/employee/dept/text()",
)
STORED AS
INPUTFORMAT 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
TBLPROPERTIES (
"xmlinput.start"="<employee>",
"xmlinput.end"="</employee>"
);

load data inpath '/home/orienit/hive_xml/employee2_xml' into table table kalyan.employee2_xml;
 



store the results into pig:
----------------------------
 
 employee2 = LOAD ‘kalyan.employee2_xml’ USING org.apache.hive.hcatalog.pig.HCatLoader();
 
 employee2_op = filter kalyan.employee2_xml by empid>2 and dept='dev';
 
 store employee2_op into '/user/orienit/pig/employee2_xml' using PigStorage(',')
 
 