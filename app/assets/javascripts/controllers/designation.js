(function(angular, app) {
    "use strict";
    app.controller("DesignationMasterController",["$scope", "designationService", function($scope, designationService) {
	$scope.getDesignation = function(page){
	    designationService.getDesignationServiceView(page)
		.then(function(result) {
		    $scope.designations =result.data;
		    $scope.total_entries = result.data.total_entries;
		    $scope.current_page = parseInt(result.data.current_page)
		    $scope.to_index = result.data.to_index
		    $scope.from_index = result.data.from_index
		    $scope.designation_details = [];
		    for(var i=0; i<result.data.designations.length; i++){
			$scope.designation_details.push({
			    id: null,
			    name: null,
			    managed_by: null,
			});
			
		    }
		    
		    
		});
	}
	$scope.saveDesignation = function(){
	    
	    
	    for(var i=0; i<$scope.designation_details.length; i++){
		$scope.designation_details['id'] = $scope.designations['id'];
		$scope.designation_details['name'] = $scope.designations['name'];
		$scope.designation_details['managed_by'] = $scope.designations['managed_by'];
	    }
	   alert(JSON.stringify($scope.designation_details))
	    designationService.saveDesignation($scope.designation_details)
		.then(function(result) {
		    alert('')
		});
	}
	
 				  

    }]);
})(angular, payRollApp);
