(function(angular, app) {
    "use strict";
    app.directive("salaryTaxComponent", function() {
        var link =  function(scope, element, attr) {
            element.on("blur", function(event){
                scope.calculateTax()
            })
        }
        return{
            link: link,
            require: 'ngModel',
            restrict: 'A'
        }
    });
})(angular, payRollApp);
