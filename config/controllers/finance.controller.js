const FinanceRequest = require("../models/finance.model");
const { calculateValuation } = require("../utils/calculations");

exports.createRequest = async (req, res) => {
  try {
    const { mileage } = req.body;
    const filePath = req.file ? req.file.path : null;

    const valuation = calculateValuation(mileage);
    const requestData = {
      mileage,
      valuation_amount: valuation,
      loan_amount: valuation,
      file_path: filePath
    };

    const newRequest = await FinanceRequest.create(requestData);
    res.status(201).json(newRequest);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.calculateValuation = (req, res) => {
  try {
    const { mileage } = req.body;
    const result = calculateValuation(mileage);
    res.json({ valuation_amount: result });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
