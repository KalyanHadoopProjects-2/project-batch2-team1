Run in normal command prompt
----------------------------------------
mongoimport --db kalyan --collection employee1_json --file /home/orienit/Desktop/Narendra/nosql/employee1.json
mongoimport --db kalyan --collection employee2_json --file /home/orienit/Desktop/Narendra/nosql/employee2.json
mongoimport --db kalyan --collection employee3_json --file /home/orienit/Desktop/Narendra/nosql/employee3.json


mongo prompt
----------------------
db.employee1_json.find({
    "dept": "dev"
});

Run in normal command prompt
----------------------------------------
1) Export `kalyan.employee1_json` mongodb collection data into `json format` in '/user/orienit/kalyan/mongodb/employee1_json_op1' directory in LocalFS

mongoexport --db kalyan --collection employee1_json  --out /home/orienit/Desktop/Narendra/nosql/employee1_json_op1.json

2) Export `kalyan.employee1_json` mongodb collection data into `csv format` in '/user/orienit/kalyan/mongodb/employee1_csv_op1' directory in LocalFS
mongoexport --db kalyan --collection employee1_json  --type=csv --fields empid,name,salary,dept --out /home/orienit/Desktop/Narendra/nosql/employee1_csv_op1.csv

3) Export `kalyan.employee1_json` mongodb collection data with specific fields “name,id” into `json format` in '/user/orienit/kalyan/mongodb/employee1_json_op2'
directory in LocalFS.

mongoexport --db kalyan --collection employee1_json  --fields empid,name, --out /home/orienit/Desktop/Narendra/nosql/employee1_json_op2.json

4) Export `kalyan.employee1_json` mongodb collection data with specific fields “name,id” into `csv format` in '/user/orienit/kalyan/mongodb/employee1_csv_op2'
directory in LocalFS.
mongoexport --db kalyan --collection employee1_json  --type=csv --fields empid,name --out /home/orienit/Desktop/Narendra/nosql/employee1_csv_op2.csv