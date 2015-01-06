$(function() {
    "usestrict";
    $("#employee_master_form a[rel=submitLink]").on("click", function(){
        var designation_id = $("#designation_id").val()
        var dept_id = $("#department_id").val()
        status = true;
        if(designation_id.length <= 0){
            var design = $("#designation_name").val()
            status = confirm("Designation: "+design+" is not exists. \n Would like to create a new Designation?")
        }
        if(status && dept_id.length <= 0){
            var dept = $("#department_name").val()
            status = confirm("Department: "+dept+" is not exists. \n Would like to create a new Department?")
        }
        if(status == true || status == 'true'){
            $("#employee_master_form").submit();
        }else{
            return false;
        }
    })
    $("a[rel='print-employee-report']").on("click", function(){
	$("form#employeeReportForm").attr('action', "get_reports.pdf")
	$("form#employeeReportForm").submit();
    })
    $("a[rel='print-annexure']").on("click", function(){
	$("form#annexureForm").attr('action', "/form24/annexure.pdf")
	$("form#annexureForm").submit();
    })
});
