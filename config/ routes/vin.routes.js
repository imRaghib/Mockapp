const express = require("express");
const router = express.Router();
const vinController = require("../controllers/vin.controller");

// VIN routes
router.post("/vins", vinController.create);
router.get("/vins", vinController.findAll);

module.exports = router;
