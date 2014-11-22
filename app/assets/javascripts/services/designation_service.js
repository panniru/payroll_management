(function(angular, app) {
    "use strict";
    app.service("designationService",["$http", function($http) {
	var getDesignationServiceView = function(page){
	    var url = "/designation_masters/map.json?page="+page
	    return $http.get(url);
	};
	
	var saveDesignation = function(designation_details){
	    var url = "/designation_masters/save_designation.json"
	    return $http.post(url,{designation_details: designation_details});
	};


	return {
	    getDesignationServiceView : getDesignationServiceView,
	    saveDesignation :  saveDesignation
	};
    }]);
})(angular, payRollApp);
