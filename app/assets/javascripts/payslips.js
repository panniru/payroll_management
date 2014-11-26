$(function() {
    "userstrict"
    $("input[rel='earningInputField']").on("blur", function(event){
        var totalEarning = 0
        $("input[rel='earningInputField']").each(function(){
            if(!isNaN(parseInt($(this).val()))){
                totalEarning += parseInt($(this).val())
            }
        });
        $("#totalEarningsField").val(totalEarning)
        $("#netAmountField").val(totalEarning-$("#totalDeductionField").val())
    })

    $("input[rel='deductionInputField']").on("blur", function(event){
        var totalDeduction = 0
        $("input[rel='deductionInputField']").each(function(){
            if(!isNaN(parseInt($(this).val()))){
                totalDeduction += parseInt($(this).val())
            }
        });
        $("#totalDeductionField").val(totalDeduction)
        $("#netAmountField").val($("#totalEarningsField").val() - totalDeduction)
    })
});
