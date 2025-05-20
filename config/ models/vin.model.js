const sql = require("../config/db.config");

const VinEntry = function(vinEntry) {
  this.vin = vinEntry.vin;
};

VinEntry.create = (newVinEntry) => {
  return new Promise((resolve, reject) => {
    sql.query("INSERT INTO vin_entries SET ?", newVinEntry, (err, res) => {
      err ? reject(err) : resolve({ id: res.insertId, ...newVinEntry });
    });
  });
};

VinEntry.getAll = () => {
  return new Promise((resolve, reject) => {
    sql.query("SELECT * FROM vin_entries", (err, res) => {
      err ? reject(err) : resolve(res);
    });
  });
};

module.exports = VinEntry;
