(function(angular, app) {
    "use strict";
    app.service("payRollService",["$http", function($http) {
        var salaryBreakUps = function(ctc){
            var url = "/salary_break_ups/break_up_report.json"
            return $http.get(url, {params: {ctc: ctc}});
        }
        
        return {
            salaryBreakUps : salaryBreakUps
        };
                    
    }]);
})(angular, payRollApp);

