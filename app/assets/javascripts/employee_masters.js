$(function() {
    "usestrict";
    $("#employee_master_form a[rel=submitLink]").on("click", function(){
        var designation_id = $("#designation_id").val()
        var dept_id = $("#department_id").val()
        status = false;
        if(designation_id.length <= 0){
            var design = $("#designation_name").val()
            status = confirm("Designation: "+design+" is not exists. \n Would like to create a new Designation?")
        }
        if(status && dept_id.length <= 0){
            var dept = $("#department_name").val()
            status = confirm("Department: "+dept+" is not exists. \n Would like to create a new Department?")
        }
        if(status){
            $("#employee_master_form").submit();
        }else{
            return false;
        }
    })
});
