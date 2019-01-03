$(document).ready(function () {

    $('#menuopen').click(function () {
        $('nav').slideDown();
        $('ul').css("flex-direction", "column");
        $('#menuclose').show();
    });

    $('#menuclose').click(function () {
        $('nav').slideUp();
        $('#menuclose').hide();
    })

    $('#recruiting').click(function () {
        console.log('clicked');
    })

    $(window).resize(function () {

        if ($('#menuopen').css("display") != "none") {
            $('ul').css("flex-direction", "column");
            $('nav').css("display", "none");
            $('#menuopen').show();

        }
        else {
            $('nav').css("display", "block");
            $('ul').css("flex-direction", "row");
            $('#menuclose').hide();
        }

    });
});