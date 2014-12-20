(function(angular, app) {
    "use strict";
    app.controller("FormTaxController",["$scope", "formService" , '$window'  , function($scope,formService ,$window) {
	
	$scope.get_tds = function(){
	    formService.getFormServiceView()
		.then(function(result) {
		    $scope.forms = result.data;
		    $scope.form_details = [];
		    for(var i=0; i<result.data.length; i++){
			$scope.form_details.push({
			    id: null,
			    payment_type: null,
			    challan_serial_no: null,
			    deposited_date: null,
			    status: null,
			    month: null,
			    year: null,
			    bsr_code: null,
			    cheque_no: null,
			    total_tax_deposited: null,
			    
			});
		    }
		    
		});
	}

	$scope.saveForm = function(){
	    
	    
	    
	    for(var i=0; i<$scope.form_details.length; i++){
		
		$scope.form_details[i]['id'] = $scope.forms[i]['id'];
		$scope.form_details[i]['status'] = $scope.forms[i]['status'];
		$scope.form_details[i]['generated_date'] = $scope.forms[i]['generated_date'];
		$scope.form_details[i]['month'] = $scope.forms[i]['month'];
		$scope.form_details[i]['bsr_code'] = $scope.forms[i]['bsr_code'];
		$scope.form_details[i]['year'] = $scope.forms[i]['year'];
		$scope.form_details[i]['payment_type'] = $scope.forms[i]['payment_type'];
		$scope.form_details[i]['challan_serial_no'] = $scope.forms[i]['challan_serial_no'];
		$scope.form_details[i]['edu_cess'] = $scope.forms[i]['education_cess'];
		$scope.form_details[i]['tds'] = $scope.forms[i]['tds_calculation'];
		$scope.form_details[i]['cheque_no'] = $scope.forms[i]['cheque_no'];
		$scope.form_details[i]['total_tax_deposited'] = $scope.forms[i]['tds_paid'];
		
	    }
	    
	    formService.saveForm($scope.form_details)
		.then(function(result) {
		    $window.location.href = '/form24';
		});
	}
	
 
    }]);
    })(angular, payRollApp);
