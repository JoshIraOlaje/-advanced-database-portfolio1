// Recovered from the embedded-grade update commands used in the project.
// Paste into the Compass MongoDB shell, not into the filter box.
// If Chidi already has grade 72, modifiedCount=0 is expected on repetition.
var campusflowDb = db.getSiblingDB("campusflow_nosql");
printjson(campusflowDb.student_term_records.findOne({
  _id: "CF/2026/004:2026/2027:1"
}));
printjson(campusflowDb.student_term_records.updateOne(
  {_id: "CF/2026/004:2026/2027:1", "courses.course_code": "CSC101"},
  {$set: {"courses.$.grade": 72}}
));
printjson(campusflowDb.student_term_records.findOne({
  _id: "CF/2026/004:2026/2027:1"
}));
