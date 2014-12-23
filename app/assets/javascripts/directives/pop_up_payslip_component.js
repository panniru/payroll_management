(function(angular, app) {
    "use strict";
    app.directive("popUpPayslipComponent", function() {
        var link =  function(scope, element, attrs) {
            
            element.on("click", function(event){
                event.preventDefault();
                if(attrs.popOverAttached){
                    element.popover("toggle")
                }else{
                    scope.$apply(attrs.action).then(function(response){
                        var content = "<table class='table table-bordered'>"
                        content += "<thead><th>Month</th><th>Amount</th><th>Month</th><th>Amount</th></thead><tbody>"
                        var mid = parseInt(response.data.length/2) // length should be even and both parts are equal
                        for(var i =0 ; i< mid ; i++){
                            content += "<tr>"
                            content += "<td>"+response.data[i].month+"</td>"
                            content += "<td>"+response.data[i].amount+"</td>"
                            content += "<td>"+response.data[mid+i].month+"</td>"
                            content += "<td>"+response.data[mid+i].amount+"</td>"
                            content += "</tr>"
                        }
                        content += "</tbody>"
                        content += "</table>"
                        var placement = 'right';
                        if(typeof attrs.placement != 'undefined'){
                            placement = attrs.placement
                        }
                        element.popover({
                            html: true,
                            placement: placement,
                            trigger:'manual',
                            content: content,
                            template: '<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"> Month Wise Details</h3><div class="popover-content"></div></div>'
                        })
                        attrs.popOverAttached = true
                        element.popover("show")
                    })
                }
                
                
            });


        }
        return{
            link: link,
            restrict: 'A'
        }
    });
})(angular, payRollApp);
