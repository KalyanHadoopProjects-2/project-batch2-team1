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
mongoexport --db kalyan --collection employee1_json --query '{ "dept": "dev"}' --out /home/orienit/Desktop/Narendra/nosql/employee1_op.json