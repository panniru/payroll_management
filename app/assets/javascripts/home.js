$(function() {
    $('.datepickerIcon').datepicker({
        showOn: "both",
        dateFormat: 'dd-mm-yy',
        buttonText: "<i class='fa fa-calendar fa-lg'></i>"
    });
    var iconTopPadding = 0-($('.datepicker').first().height()+7)
    $("button.ui-datepicker-trigger").css({'background-color': 'none', 'border': 'none', 'background' : 'none', 'position': 'inline', 'top': iconTopPadding, 'left': '100%', 'position': 'relative'})
    $('.datepicker').datepicker({
        dateFormat: 'dd-mm-yy'
    })

    var iconTopPadding1 = 0-($('.input-icon1').first().height()+10)
    $(".input-icon").css({'background-color': 'none', 'border': 'none', 'background' : 'none', 'position': 'inline', 'position': 'relative', 'padding-top':'30%', 'left':'-30%'})
    $(".input-icon1").css({'background-color': 'none', 'border': 'none', 'background' : 'none', 'position': 'inline', 'top': iconTopPadding1, 'left': '100%', 'position': 'relative'})

    $('html').on('click', function(e) {
        $('.popover').each( function() {
            if( $(e.target).get(0) !== $(this).prev().get(0) ) {
                $(this).popover('toggle');
            }
        });
    });


});

