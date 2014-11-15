$(function() {
    $('.datepicker').datepicker({
        showOn: "both",
        buttonText: "<i class='fa fa-calendar fa-2x'></i>"
    });
    var iconTopPadding = 0-($('.datepicker').first().height()+7)
    $("button.ui-datepicker-trigger").css({'background-color': 'none', 'border': 'none', 'background' : 'none', 'position': 'inline', 'top': iconTopPadding, 'left': '100%', 'position': 'relative'})
});
