
db = db.getSiblingDB('admin');
db.auth('Welfinity2017!','sAt5a&rU@aT2');

db.createUser({user: "WelfinitySuperUser",pwd: "fEcUc8a*ur?h", roles: [ "root" ]   });
db.grantRolesToUser("Welfinity2017!", [ { role: "readWrite", db: "admin" } ]);
db.grantRolesToUser("Welfinity2017!", [ { role: "readWrite", db: "Pharmacies_list" } ]);
db.grantRolesToUser("Welfinity2017!", [ { role: "readWrite", db: "Product_Dictionaries_Italy" } ]);
db.grantRolesToUser("Welfinity2017!", [ { role: "readWrite", db: "markets" } ]);


db = db.getSiblingDB('Pharmacies_list');
db.createUser(  {    user: "talendUser",    pwd: "ba+Req6@agu6",    roles: [{ role: "readWrite", db: "Pharmacies_list" }    ]  });



db = db.getSiblingDB('Product_Dictionaries_Italy');
db.createUser(  {    user: "talendUser",    pwd: "ba+Req6@agu6",    roles: [{ role: "readWrite", db: "Product_Dictionaries_Italy" }    ]  });
db.createUser(  {    user: "webuser",       pwd: "3ZNnw5T6pWAgeUXx",    roles: [ { role: "readWrite", db: "Product_Dictionaries_Italy" } ]});

db = db.getSiblingDB('markets');
db.createUser(  {    user: "talendUser",    pwd: "ba+Req6@agu6",    roles: [ { role: "readWrite", db: "markets" }    ]  });
db.createUser(  {    user: "webuser",       pwd: "3ZNnw5T6pWAgeUXx",    roles: [ { role: "readWrite", db: "markets" }    ]  });