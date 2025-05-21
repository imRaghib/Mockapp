const VinEntry = require('../models/vin.model');

exports.createVin = async (req, res) => {
  try {
    const { vin } = req.body;
    if (!vin) return res.status(400).json({ message: 'VIN is required' });

    const newVin = await VinEntry.create(vin);
    res.status(201).json(newVin);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
};

exports.getVins = async (req, res) => {
  try {
    const vins = await VinEntry.getAll();
    res.json(vins);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
};
