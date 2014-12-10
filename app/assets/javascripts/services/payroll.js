(function(angular, app) {
    "use strict";
    app.service("payRollService",["$http", function($http) {
        var salaryBreakUps = function(ctc, basic){
            var url = "/salary_break_ups/break_up_report.json"
            return $http.get(url, {params: {ctc: ctc, basic: basic}});
        }
        
        return {
            salaryBreakUps : salaryBreakUps
        };
                    
    }]);
})(angular, payRollApp);

