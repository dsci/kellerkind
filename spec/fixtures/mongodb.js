var databaseName  = "kellerkindTest";
var kellerkindDb  = db.getSiblingDB(databaseName);
var data          = {
                      "title" : "10 Uhr zwanzig"
                    }

kellerkindDb.tests.insert(obj);

