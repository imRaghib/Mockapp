const db = require('../config/db.config');

class VinEntry {
  static async create(vin) {
    const [result] = await db.query('INSERT INTO vin_entries (vin) VALUES (?)', [vin]);
    return { id: result.insertId, vin };
  }

  static async getAll() {
    const [rows] = await db.query('SELECT * FROM vin_entries ORDER BY created_at DESC');
    return rows;
  }
}

module.exports = VinEntry;
