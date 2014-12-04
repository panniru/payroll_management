(function(angular, app) {
    "use strict";

    app.controller("PayslipsIndexController", ["$scope", "payslipService", function($scope, payslipService) {
        $scope.getPayslips = function(page){
            payslipService.Payslip.payslips({employee_master_id: $scope.employee_master_id, month: $scope.month, year: $scope.year, page: page, status: $scope.status}, function(data){
                $scope.payslips = []
                $scope.payslips = data.payslips
                $scope.total_entries = data.total_entries;
                $scope.current_page = parseInt(data.current_page)
                $scope.to_index = data.to_index 
                $scope.from_index = data.from_index
                $.each($scope.payslips, function(index, val){
                    
                    val["isChecked"] = false
                });

            })
        }

        $scope.checkAll = function(){
            $.each($scope.payslips, function(index, payslip){
                if(payslip.status == 'pending'){
                    payslip.isChecked = $scope.allChecked
                }
            });
        };

        $scope.approve = function(status){
            payslipService.Payslip.approvePayslips({payslips: $scope.payslips, status: status}, function(response){
                $scope.getPayslips(1)
            })
        }

        $scope.emailPayslips = function(){
            payslipService.Payslip.emailPayslips({employee_master_id: $scope.employee_master_id, month: $scope.month, year: $scope.year}, function(response){
                $scope.alertSuccess = true
                $scope.successMsg = response.msg
            })
        }
    }]);

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
                initializeHeaders()
            })
        }

        var initializeHeaders = function(){
            $scope.additional_allowance_1_label = null
            $scope.additional_allowance_2_label = null
            $scope.additional_allowance_3_label = null
            $scope.additional_deduction_1_label = null
            $scope.additional_deduction_2_label = null
            $scope.additional_deduction_3_label = null
            
            $scope.additional_allowance_1_label_edit = null
            $scope.additional_allowance_2_label_edit = null
            $scope.additional_allowance_3_label_edit = null
            $scope.additional_deduction_1_label_edit = null
            $scope.additional_deduction_2_label_edit = null
            $scope.additional_deduction_3_label_edit = null
        }

        $scope.toggleComponents = function(){
            $scope.isEarningsEdit = !$scope.isEarningsEdit
            return $scope.isEarningsEdit
        }
        
        $scope.savePayslips = function(){
            if($scope.payslipsForm.$valid){
                angular.forEach($scope.payslips, function(payslip, index){
                    payslip["additional_allowance_1_label"] = $scope.additional_allowance_1_label
                    payslip["additional_allowance_2_label"] = $scope.additional_allowance_2_label
                    payslip["additional_allowance_3_label"] = $scope.additional_allowance_3_label
                    payslip["additional_deduction_1_label"] = $scope.additional_deduction_1_label
                    payslip["additional_deduction_2_label"] = $scope.additional_deduction_2_label
                    payslip["additional_deduction_3_label"] = $scope.additional_deduction_3_label
                });
                

                payslipService.Payslip.savePayslips({payslips: $scope.payslips}, function(response){
                    $scope.newPayslips(1)
                })
            }else{
                alert("Form data is invalid please verify.")
            }
        }

        $scope.totalEarnings = function(payslip){
            return (payslip.basic + payslip.hra + payslip.city_compensatory_allowance + payslip.conveyance_allowance + 
             payslip.special_allowance + payslip.loyalty_allowance + payslip.medical_allowance + 
             payslip.incentive_payment + payslip.loyalty_deposit + payslip.arrears_of_salary +
             + payslip.grade_allowance + payslip.leave_settlement  + payslip.performance_bonus +
             payslip.additional_allowance_1 + payslip.additional_allowance_2 + payslip.additional_allowance_3)
        }

        $scope.totalDeductions = function(payslip){
            return (payslip.pf + payslip.club_contribution + payslip.professional_tax + payslip.tds_pm +
                    payslip.additional_deduction_1 + payslip.additional_deduction_2 + payslip.additional_deduction_3)
        }

        $scope.netTotal = function(payslip){
            return ($scope.totalEarnings(payslip) - $scope.totalDeductions(payslip))
        }
        
    }]);

})(angular, payRollApp);
