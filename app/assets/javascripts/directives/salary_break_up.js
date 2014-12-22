(function(angular, app) {
    "use strict";
    app.directive("salaryBreakUp", function() {
        return {
            restrict: 'E',
            scope: {
                ctc: '=',
                basic: '=',
                probationDate: '='
            },
            controller: ["$scope", "payRollService", function($scope, payRollService){
                payRollService.salaryBreakUps($scope.ctc, $scope.basic, $scope.probationDate)
                    .then(function(response){
                        $scope.earningPerMonth = 0;
                        $scope.deductionPerMonth = 0;
                        $scope.components = response.data
                        angular.forEach($scope.components.earnings, function(data){
                            $scope.earningPerMonth = $scope.earningPerMonth + data.amount_per_month
                        })
                        angular.forEach($scope.components.deductions, function(data){
                            $scope.deductionPerMonth = $scope.deductionPerMonth + data.amount_per_month
                        })
                    })
            }],
            templateUrl: "salary_break_up_details.html"
        }
    });
})(angular, payRollApp);
