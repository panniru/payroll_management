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
                needConfirmation: '=',
		action: '&'
	    },
	    controller: ["$scope", function($scope){
		$scope.currentPage = 1;
		$scope.previousPage = function(){
                    if($scope.needConfirmation && window.confirm("Entries are not Saved.! \nStill you would like to continue?")){
                        $scope.currentPage -= 1
		        $scope.action({page: $scope.currentPage})
                    }
		}
		$scope.nextPage = function(){
                    if($scope.needConfirmation && window.confirm("Entries are not Saved.!\nStill You would like to discard?")){
		        $scope.currentPage += 1
		        $scope.action({page: $scope.currentPage})
                    }
		}
	    }],
	    templateUrl: "paginationElements.html"
	}
    });
})(angular, payRollApp);

   
