(function(angular, app) {
    "use strict";
    app.directive("myPagination", function() {
	return {
	    restrict: 'E',
	    scope: {
		from: '=',
		to: '=',
		total: '=',
                currentPage: '=',
		action: '&'
	    },
	    controller: ["$scope", function($scope){
		$scope.currentPage = 1;
		$scope.previousPage = function(){
                    if(typeof $scope.$parent.payslipsForm != 'undefined' && $scope.$parent.payslipsForm.$dirty && window.confirm("Entries are not Saved.! \nStill you would like to continue?")){
                        $scope.currentPage -= 1
		        $scope.action({page: $scope.currentPage})
                    }else if(typeof $scope.$parent.payslipsForm == 'undefined' || (typeof $scope.$parent.payslipsForm != 'undefined' && !$scope.$parent.payslipsForm.$dirty)){
                        $scope.currentPage -= 1
		        $scope.action({page: $scope.currentPage})
                    }
		}
		$scope.nextPage = function(){
                    if(typeof $scope.$parent.payslipsForm != 'undefined' && $scope.$parent.payslipsForm.$dirty && window.confirm("Entries are not Saved.!\nStill You would like to discard?")){
		        $scope.currentPage += 1
		        $scope.action({page: $scope.currentPage})
                    }else if(typeof $scope.$parent.payslipsForm == 'undefined' || (typeof $scope.$parent.payslipsForm != 'undefined' && !$scope.$parent.payslipsForm.$dirty)){
                        $scope.currentPage += 1
		        $scope.action({page: $scope.currentPage})
                    }
		}
	    }],
	    templateUrl: "paginationElements.html"
	}
    });
})(angular, payRollApp);

   
