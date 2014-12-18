(function(angular, app) {
    "use strict";
    app.controller("SalaryTaxController", ["$scope", "$window", "salaryTaxService", function($scope, $window, salaryTaxService) {
        
        $scope.taxLimits = null
        $scope.rentReceivedPerMonth = 0;

        var initSalaryTaxLimits = function(){
            salaryTaxService.salaryTaxLimits()
                .then(function(response){
                    $scope.taxLimits = response.data
                    $scope.calculateTax()
                })
        }

        $scope.initialize = function(employee_master_id){
            
            $scope.employeeMasterId = employee_master_id
            $scope.newSalaryTax()

        }

        $scope.newSalaryTax = function(){
            salaryTaxService.newSalaryTax($scope.employeeMasterId)
                .then(function(response){
                    $scope.salaryTax = response.data
                    initSalaryTaxLimits();
                })
        }

        $scope.broadCastRent = function(){
            $scope.salaryTax.rent_per_year = $scope.salaryTax.rent_per_month * 12
            var rent_excess_salary = $window.Math.abs($scope.salaryTax.rent_per_year - ($scope.salaryTax.basic * 0.1))
            $scope.salaryTax.rent_paid = $window.Math.min(rent_excess_salary, $scope.salaryTax.hra)
            $scope.calculateTax()
        }
        
        $scope.addMoreMedicalInsurance = function(){
            var lastInsurance = $scope.salaryTax.medical_insurances[0]
            var newInsurance = {}
            angular.forEach(lastInsurance, function(val, key){
                newInsurance[key] = null
            })
            $scope.salaryTax.medical_insurances.push(newInsurance)
        }
        
        $scope.broadcastInsuranceAmount = function(){
            var total = 0
            angular.forEach($scope.salaryTax.medical_insurances, function(val, index){
                var estimatedAmount = $scope.taxLimits.mediclaim_employee_limit
                if(val.parent_included){
                    estimatedAmount += $scope.taxLimits.mediclaim_parent_limit
                    if(val.parent_senior_citizen){
                        estimatedAmount += $scope.taxLimits.mediclaim_parent_senior_citizen_limit
                    }
                }
                if(parseInt(val.amount) <= estimatedAmount && (total + parseInt(val.amount)) <= estimatedAmount){
                    total += parseInt(val.amount)
                    
                }else{
                    alert("Insurance amount has been exceeded the limit "+ estimatedAmount)
                    val.amount = 0
                }
            })
            $scope.salaryTax.medical_insurances_total = total
            $scope.calculateTax()
        }

        $scope.addMoreMedicalBill = function(){
            var lastBill = $scope.salaryTax.medical_bills[0]
            var newBill = {}
            angular.forEach(lastBill, function(val, key){
                newBill[key] = null
            })
            $scope.salaryTax.medical_bills.push(newBill)
        }

        $scope.broadcastMedicalBillAmount = function(){
            var total = 0
            angular.forEach($scope.salaryTax.medical_bills, function(val, index){
                total += parseInt(val.amount)
            })
            if(total <= $scope.salaryTax.medical_allowance){
                $scope.salaryTax.claimed_medical_bill = total
                $scope.calculateTax()
            }else{
                alert("Savings amount has been exceeded the limit "+ $scope.salaryTax.medical_allowance)
            }
            
        }


        $scope.addMoreSaving = function(){
            var lastSaving = $scope.salaryTax.savings[0]
            var newSaving = {}
            angular.forEach(lastSaving, function(val, key){
                newSaving[key] = ""
            })
            $scope.salaryTax.savings.push(newSaving)
        }

        $scope.broadcastSavingsAmount = function(){
            var total = 0
            angular.forEach($scope.salaryTax.savings, function(val, index){
                var estimatedAmount = $scope.taxLimits.savings_up_to
                if(parseInt(val.amount) <= estimatedAmount && (total + parseInt(val.amount)) <= estimatedAmount){
                    total += parseInt(val.amount)
                    
                }else{
                    alert("Savings amount has been exceeded the limit "+ estimatedAmount)
                    val.amount = 0
                }
            })
            $scope.salaryTax.savings_total = total
            $scope.calculateTax()
        }
        
        $scope.broadCastRentRecieved = function(){
            $scope.salaryTax.rent_received_per_year =  ($scope.salaryTax.rent_received_per_month * 12)
            var maintainanceCutoff = $scope.taxLimits.maintanance_on_rent_received
            $scope.salaryTax.rent_received = ($scope.salaryTax.rent_received_per_year - ($scope.salaryTax.rent_received_per_year * (maintainanceCutoff/100)))
            $scope.calculateTax()
        }

        $scope.totalAmountForTax = function(){
            $scope.totalAmountFor = $scope.salaryTax.total_earnings
        }

        $scope.calculateTax = function(){
            var total_earnings = totalEarnings()
            var total_deductions = totalDeductions()
            var total_amount = (total_earnings - total_deductions)
            var total_tax_projection = calculateIncomeTax(total_amount)
            var educational_cess = $window.Math.round( total_tax_projection * ($scope.taxLimits.educational_cess/100))
            var surcharge = 0
            var net_tax = $window.Math.round( total_tax_projection + surcharge + educational_cess)            
            $scope.salaryTax.total_tax_projection = total_tax_projection
            $scope.total_earnings = total_earnings
            $scope.total_deductions = total_deductions
            $scope.total_amount = total_amount
            $scope.salaryTax.surcharge = surcharge
            $scope.salaryTax.educational_cess = educational_cess
            $scope.salaryTax.net_tax = net_tax
            if(!$scope.$$phase) {
                $scope.$digest()
            }
        }

        var totalEarnings = function(){
             return ($scope.salaryTax.basic+ $scope.salaryTax.hra+ $scope.salaryTax.conveyance_allowance+ $scope.salaryTax.city_compensatory_allowance+ $scope.salaryTax.special_allowance+ $scope.salaryTax.loyalty_allowance+ $scope.salaryTax.leave_settlement+ $scope.salaryTax.medical_allowance+ $scope.salaryTax.other_payment)
        }

        var totalDeductions = function(){
            return (parseInt($scope.salaryTax.rent_paid || 0) + parseInt($scope.salaryTax.home_loan_amount  || 0) + parseInt($scope.salaryTax.standard_deduction || 0) + parseInt($scope.salaryTax.medical_insurances_total || 0) + parseInt($scope.salaryTax.claimed_medical_bill || 0) + parseInt($scope.salaryTax.savings_total || 0) + parseInt($scope.salaryTax.professional_tax || 0) + parseInt($scope.salaryTax.conveyance_allowance || 0) + parseInt($scope.salaryTax.atg || 0 )- parseInt($scope.salaryTax.rent_received || 0))
        }

        var calculateIncomeTax = function(amount){
            var tax = 0
            angular.forEach($scope.taxLimits.income_tax, function(val, key){
                if(amount >= 0){
                    if( typeof val.to != 'undefined' ){
                        var range = val.to - val.from
                        if(amount >= range ){
                            tax += (range*(val.tax/100))
                        }else{
                            tax += (amount*(val.tax/100))
                        }
                        amount = amount - range
                    }else{
                        tax += (amount*(val.tax/100))
                        amount = amount - val.from
                    }
                }
            })
            return $window.Math.round(tax)
        }

        $scope.saveSalaryTax = function(){
            salaryTaxService.createSalaryTax($scope.employeeMasterId, $scope.salaryTax)
            .then(function(response){
                if(response.data.status){
                    $window.location.href = "/employee_masters/"+$scope.employeeMasterId+"/salary_taxes/"+response.data.id
                }else{
                    alert("Internel Error Occurred")
                }
            })
        }

        $scope.edit = function(employee_master_id, salary_tax_id){
            $scope.employeeMasterId = employee_master_id
            salaryTaxService.edit(employee_master_id, salary_tax_id)
                .then(function(response){
                    $scope.salaryTax = response.data
                    initSalaryTaxLimits();
                })

        }

        $scope.updateSalaryTax = function(){
            salaryTaxService.update($scope.employeeMasterId, $scope.salaryTax)
            .then(function(response){
                if(response.data.status){
                    $window.location.href = "/employee_masters/"+$scope.employeeMasterId+"/salary_taxes/"+$scope.salaryTax.id
                }else{
                    alert("Internel Error Occurred")
                }
            })
        }


        

        $scope.component_monthly_report = salaryTaxService.component_monthly_report;
        
    }]);
})(angular, payRollApp);
