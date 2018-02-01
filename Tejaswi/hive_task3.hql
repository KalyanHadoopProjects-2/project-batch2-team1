task 3:
loading json data:
------------------
create external table kalyan.employee3_json(empid int,name string,salary string,dept string,details struct<address:string,pincode:int>)
row format serde 'org.apache.hive.hcatalog.data.JsonSerDe' stored as textfile
feilds terminated by ','
collection items terminated by ','
map keys terminated by ':';

hdfs dfs -mkdir -p /home/orienit/hive_json
download employee3_json file and paste into work folder
hdfs dfs -put /home/orienit/work/employee3_json /home/orienit/hive_json/employee3_json

load data inpath '/home/orienit/hive_json/employee3_json' into table kalyan.employee3_json;

insert overwrite local directory '/home/orienit/store_result_json/json_result'
select * from kalyan.employee1_json where empid>2 and address='hyderabad';

loading xml data:
------------------

---------------------
hdfs dfs -mkdir -p /home/orienit/hive_xml
hdfs dfs -put /home/orienit/work/employee3_xml /home/orienit/hive_xml/employee3_xml

create external table if not exist kalyan.employee3_xml(empid int,name string,salary string,dept string,address string,pincode bigint,address1 string,pincode1 bigint)
ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
WITH SERDEPROPERTIES (
"column.xpath.empid"="/employee/empid/text()",
"column.xpath.name"="/employee/name/text()",
"column.xpath.salary"="/employee/salary/text()",
"column.xpath.dept"="/employee/dept/text()",
"column.xpath.address"="/employee/details[1]/address[1]/text()",
"column.xpath.pincode"="/employee/details[1]/pincode[1]/text()",
"column.xpath.address1"="employee/details[2]/address[1]/text()",
"column.xpath.pincode1"="employee/details[2]/pincode[1]/text()"
)
STORED AS
INPUTFORMAT 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
TBLPROPERTIES (
"xmlinput.start"="<employee>",
"xmlinput.end"="</employee>"
);


