(function(angular, app) {
    "use strict";
    app.controller("PayslipsController", ["$scope", "payslipService", function($scope, payslipService) {
        $scope.isEarningsEdit = true
        $scope.newPayslips = function(page){
            payslipService.Payslip.newPayslips({designation_id: $scope.designationId, page: page}, function(data){
                $scope.isEarningsEdit = true
                $scope.needConfirmation = true
                $scope.payslips = data.payslips
                $scope.total_entries = data.total_entries;
                $scope.current_page = parseInt(data.current_page)
                $scope.to_index = data.to_index 
                $scope.from_index = data.from_index
            })
        }

        $scope.toggleComponents = function(){
            $scope.isEarningsEdit = !$scope.isEarningsEdit
            return $scope.isEarningsEdit
        }
        
        $scope.savePayslips = function(){
            payslipService.Payslip.savePayslips({payslips: $scope.payslips}, function(response){
            })
        }

        
    }]);

})(angular, payRollApp);
