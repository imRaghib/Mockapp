const VinEntry = require("../models/vin.model");

exports.create = async (req, res) => {
  try {
    const vinEntry = await VinEntry.create(req.body);
    res.status(201).json(vinEntry);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.findAll = async (req, res) => {
  try {
    const vinEntries = await VinEntry.getAll();
    res.json(vinEntries);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
