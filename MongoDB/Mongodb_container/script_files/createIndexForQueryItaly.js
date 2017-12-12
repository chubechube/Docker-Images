db = db.getSiblingDB('admin');
db.auth('Welfinity2017!','sAt5a&rU@aT2');

db = db.getSiblingDB('Pharmacies_list');
db.Italy.createIndex( { CODICEIDENTIFICATIVOFARMACIA : 1 } )