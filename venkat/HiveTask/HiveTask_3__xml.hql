CREATE TABLE employee3_xml(empid int, name string, salary float, dept string,address string,pincode bigint )
ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
WITH SERDEPROPERTIES (
"column.xpath.empid"="/employee/empid/text()",
"column.xpath.name"="/employee/name/text()",
"column.xpath.salary"="/employee/salary/text()",
"column.xpath.dept"="/employee/dept/text()",
"column.xpath.address"="/employee/details/address/text()",
"column.xpath.pincode"="/employee/details/pincode/text()"
)
STORED AS
INPUTFORMAT 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
TBLPROPERTIES (
"xmlinput.start"="<employee>",
"xmlinput.end"="</employee>"
);

add jar /home/orienit/other/hivexmlserde-1.0.5.3.jar;
LOAD DATA LOCAL INPATH '/home/orienit/other/employee3.xml'OVERWRITE INTO TABLE employee3_xml;

select *  from employee3_xml where empid>2 AND dept='dev';

<employee><empid>1</empid><name>kalyan</name><salary>10000</salary><dept>dev</dept><details><address>hyderabad</address><pincode>500001</pincode></details></employee>
<employee><empid>2</empid><name>anvith</name><salary>15000</salary><dept>testing</dept></employee>
<employee><empid>3</empid><name>raj</name><salary>5000</salary><dept>testing</dept><details><address>hyderabad</address><pincode>500001</pincode></details><details><address>banglore</address><pincode>600001</pincode></details></employee>
<employee><empid>4</empid><name>venkat</name><salary>20000</salary><dept>dev</dept></employee>
<employee><empid>5</empid><name>soni</name><salary>5000</salary><dept>testing</dept></employee>
<employee><empid>6</empid><name>rajesh</name><salary>25000</salary><dept>dev</dept></employee>