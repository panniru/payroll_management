(function(angular, app) {
    "use strict";
    app.directive("myDatepicker", ['$timeout', function($timeout){
        return {
            restrict: 'A',      
            link: function(scope, elem, attrs){
                // timeout internals are called once directive rendering is complete
                $timeout(function(){                    
                    $(elem).datepicker();
                });
            }
        };
    }]);
})(angular, payRollApp);
