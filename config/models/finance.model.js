const sql = require("../config/db.config");

const FinanceRequest = function(financeRequest) {
  this.mileage = financeRequest.mileage;
  this.valuation_amount = financeRequest.valuation_amount;
  this.loan_amount = financeRequest.loan_amount;
  this.file_path = financeRequest.file_path;
};

FinanceRequest.create = (newRequest) => {
  return new Promise((resolve, reject) => {
    sql.query("INSERT INTO finance_requests SET ?", newRequest, (err, res) => {
      err ? reject(err) : resolve({ id: res.insertId, ...newRequest });
    });
  });
};

module.exports = FinanceRequest;
