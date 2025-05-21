const express = require('express');
const router = express.Router();
const financeController = require('../controllers/finance.controller');

router.post('/requests', financeController.createFinanceRequest);

module.exports = router;
