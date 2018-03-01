db = db.getSiblingDB('admin');
db.createUser({ user: 'Welfinity2017!', pwd: 'sAt5a&rU@aT2', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] });
