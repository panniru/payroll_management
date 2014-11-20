(function(angular, app) {
    "use strict";
    app.service("payslipService",["$resource", function($resource) {
        var Payslip = $resource('payslips/:id', {employee_master_id: '@employee_master_id', id: '@id'},
                               {
                                   "newPayslips": {url: "/payslips/new_payslips.json?designation_id=:designation_id", method: "GET", isArray: false},
                                   "savePayslips": {url: "/payslips/create_payslips.json", method: "POST"}
                               }
                               );
        return {
            Payslip : Payslip
        };
    }]);
})(angular, payRollApp);
