(function(angular, app) {
    "use strict";
    app.controller("SalaryBreakUpsController",["$scope", "$http", function($scope, $http) {
        $scope.initialize = function(){
            $scope.editable = false;
            $http.get("/salary_break_ups.json")
                .then(function(response){
                    $scope.salary_break_ups = response.data
                })
        };

        $scope.update = function(){
            $http.put("/salary_break_ups/update_all.json", {salary_break_ups: $scope.salary_break_ups})
                .then(function(response){
                    if(response.status){
                        $scope.editable = false
                    }
                })
        };
        
        
    }]);
})(angular, payRollApp);
