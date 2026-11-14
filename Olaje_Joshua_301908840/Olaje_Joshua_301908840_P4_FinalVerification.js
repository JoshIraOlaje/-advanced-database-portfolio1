// READ ONLY final checks in the Compass embedded MongoDB shell.
var finalDb = db.getSiblingDB("campusflow_nosql");
print("Server version: " + db.version());
print("Document count: " + finalDb.student_term_records.countDocuments({}));
print("BIO101 student count: " + finalDb.student_term_records.countDocuments({"courses.course_code":"BIO101"}));
print("BIO101 grade >=70 count: " + finalDb.student_term_records.countDocuments({courses:{$elemMatch:{course_code:"BIO101",grade:{$gte:70}}}}));
printjson(finalDb.student_term_records.findOne({_id:"CF/2026/004:2026/2027:1"}));
