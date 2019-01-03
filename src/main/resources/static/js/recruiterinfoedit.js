//initial function
$(document).ready( function () {
    //set up
    var csrf_token = $('meta[name="_csrf"]').attr('content');
    $.ajaxSetup({
        headers: {"X-CSRF-Token": csrf_token},
    });

    //DataTable
    table = $('#table').DataTable({
        ajax: {
            url: "recruiterinfo",
            dataSrc: ''
        },
        scrollX: true,
        scrollY: '500px',
        scrollCollapse: true,
        columns: [
            {"data": 'id', className: 'idnumber'},
            {"data": 'lastName'},
            {"data": 'firstName'},
            {"data": 'clearanceLevel', className: 'clearance'},
            {"data": 'referralWasMadeOn', className: 'input date referral'},
            {"data": 'interviewed', className: 'input date min interview'},
            {"data": 'offer', className: 'input date min offer'},
            {"data": 'hired', className: 'input date min hired'},
            { "data": 'futureCon', className: 'futurecon'},
            {"data": 'inPersonReferral', className: 'checkbox'},
            {"data": 'notes', className: 'input notes'},
            {
                "data": 'delete',
                className: 'delete',
                defaultContent:  '<svg class="delete-icon"><use xlink:href="/images/icons.svg#trash"></use><svg>'
            }

        ],
        //Callback(all other js
        drawCallback: function(){

            //Future Considerations Functions
            $('td.futurecon').each(function () {
                if ($(this).text() == "") {
                    $(this).html('<select class="future"><option value="" selected></option><option value="yes">Yes</option></select>');
                }
                if ($(this).text() == "yes"){
                    $(this).html('<select class="future"><option value=""></option><option value="yes" selected>Yes</option></select>');
                }
            });

            //Clearance Level Functions
            $('td.clearance').each(function () {
                if ($(this).text() == "") {
                    $(this).html('<select class="clearance"><option value=""></option><option value="fullycleared">Yes</option><option value="notcleared">No</option></select>');
                    $(this).parent().css('background-color', '#ffed66');
                }
                if ($(this).text() == "fullycleared"){
                    $(this).html('<select class="clearance"><option value=""></option><option value="fullycleared" selected>Yes</option><option value="notcleared">No</option></select>');
                }
                if ($(this).text() == "notcleared"){
                    $(this).html('<select class="clearance"><option value=""></option><option value="fullycleared">Yes</option><option value="notcleared" selected>No</option></select>');
                }
            });

            //in-person referral functions
            $('td.checkbox').each(function(){
                if($(this).text() == 'true'){
                    $(this).html('<input type="checkbox" checked name="in-person-referral"/>');
                }
                else{
                    $(this).html('<input type="checkbox" name="in-person-referral"/>')
                }
            });

            $('td.delete').each(function(){

                if(vm.referral_view == 'default'){
                    $(this).html('<svg class="delete-icon"><use xlink:href="/images/icons.svg#trash"></use><svg>');
                }
                else{
                    $(this).html('<svg class="recover-icon"><use xlink:href="/images/icons.svg#undo"></use><svg>');
                }

            });

            $('td.checkbox').each(function () {
                $('input', this).change(function () {
                    var checked = $(this).is(':checked');
                    var id = this.closest('tr').querySelector('.idnumber').innerHTML;
                    var data = {"inPersonReferral": checked, "rowIdNo": id};
                    $.ajax({
                            type: 'POST',
                            url: 'inpersonreferralupdates',
                            contentType: 'application/json',
                            data: JSON.stringify(data)

                        }
                    )
                })
            });

            /*
            $('td.delete').each(function(){
                $(this).html('<svg class="delete-icon"><use xlink:href="/images/icons.svg#trash"></use><svg>');
            });*/

            $('.delete-icon').each(function () {
                this.onclick = function () {
                    var row = this.closest('tr').querySelector('.idnumber').innerHTML;

                    var data = {'rowIdNo': row};

                    $.ajax({
                        type: "POST",
                        url: "deleteupdates",
                        contentType: 'application/json',
                        data: JSON.stringify(data)
                    }).done(function () {
                        table.ajax.reload();
                    });


                }
            });

            $('.recover-icon').each(function(){
                this.onclick = function(){
                    var row = this.closest('tr').querySelector('.idnumber').innerHTML;
                    var data = {'rowIdNo':row};

                    $.ajax({
                        type:"POST",
                        url:"recoverupdates",
                        contentType:'application/json',
                        data: JSON.stringify(data)
                    }).done(function(){
                        table.ajax.reload();
                    })
                }
            });

            // Date Functions
            //Put input in cells with no data
            $('td.date').each(function () {
                if ($(this).text() == "") {
                    $(this).html('<input type="text" placeholder = "YYYY-MM-DD"/>')
                }
                //If cell has data, switch from text to input when clicked
                $(this).click(function () {
                    if ($(this).text() != "") {
                        var currentInfo = $(this).text();
                        $(this).html('<input class="new" type="text" placeholder = "YYYY-MM-DD"/>');
                            //reinsert new inputs in referral column with datepicker
                        $('td.referral input.new').each(function(){
                            $(this).datepicker({
                                dateFormat: "yy-mm-dd",
                                defaultDate: currentInfo
                            });
                        });
                            //reinsert new inputs in all other date columns with datepicker
                        $('td.min input.new').each(function () {
                            var prevDate = String($(this).parent().prev().text());
                            $(this).datepicker({
                                dateFormat: "yy-mm-dd",
                                minDate: prevDate,
                                defaultDate: currentInfo
                            });
                        });
                            //Send edited referral dates to db
                        $('td.referral input.new').each(function() {
                            $(this).change(function(){
                                var refDate = $(this).val();
                                var cell = $(this).parent();
                                var rowIdNo = $(cell).parent().children('td.idnumber').text();
                                var data = {"rowIdNo": rowIdNo, "refDate": refDate};
                                var dataSend = JSON.stringify(data);
                                $.ajax({
                                    type: 'POST',
                                    url: "referraldateupdates",
                                    contentType: 'application/json',
                                    data: dataSend
                                });
                            });
                        });
                            //Send edited interview dates to db
                        $('td.interview input.new').each(function () {
                            $(this).change(function () {
                                var intDate = $(this).val();
                                var cell = $(this).parent();
                                var rowIdNo = $(cell).parent().children('td.idnumber').text();
                                var data = {"rowIdNo": rowIdNo, "intDate": intDate};
                                var dataSend = JSON.stringify(data);
                                $.ajax({
                                    type: "POST",
                                    url: "interviewdateupdates",
                                    contentType: 'application/json',
                                    data: dataSend
                                });
                            });
                        });
                        //Send edited offer dates to db
                        $('td.offer input.new').each(function () {
                            $(this).change(function () {
                                var offDate = $(this).val();
                                var cell = $(this).parent();
                                var rowIdNo = $(cell).parent().children('td.idnumber').text();
                                var data = {"rowIdNo": rowIdNo, "offDate": offDate};
                                var dataSend = JSON.stringify(data);
                                $.ajax({
                                    type: "POST",
                                    url: "offerdateupdates",
                                    contentType: "application/json",
                                    data: dataSend
                                });
                            });
                        });
                            //Send edited hired dates to db
                        $('td.hired input.new').each(function () {
                            $(this).change(function () {
                                var hireDate = $(this).val();
                                var cell = $(this).parent();
                                var rowIdNo = $(cell).parent().children('td.idnumber').text();
                                var data = {"rowIdNo": rowIdNo, "hireDate": hireDate};
                                var dataSend = JSON.stringify(data);
                                $.ajax({
                                    type: "POST",
                                    url: "hiredateupdates",
                                    contentType: "application/json",
                                    data: dataSend
                                });
                            });
                        });
                    }
                });
            });

            //Notes Functions
                //Put input in cells with no data
            $('td.notes').each(function () {
                if ($(this).text() == "") {
                    $(this).html('<input type="text" placeholder="Enter Comment"/>')
                }
                //If cell has data, switch from text to input when clicked
                $(this).click(function() {
                    if ($(this).text() != ""){
                        var currentText = $(this).text();
                        $(this).html('<input class="new" type="text" placeholder = "Enter Comment"/>');
                            //reinsert new note inputs with existing text as value
                        $('td.notes input.new').each(function () {
                            $(this).attr('value', currentText);
                        });
                        $('td.notes input.new').each(function () {
                            $(this).change(function () {
                                var notes = $(this).val();
                                var cell = $(this).parent();
                                var rowIdNo = $(cell).parent().children('td.idnumber').text();
                                var data = {"rowIdNo": rowIdNo, "notes": notes};
                                var dataSend = JSON.stringify(data);
                                $.ajax({
                                    type: "POST",
                                    url: "notesupdates",
                                    contentType: "application/json",
                                    data: dataSend
                                });
                            });
                        });
                    }
                });
            });

            //Date Picker functions for input fields that are initially loaded
                //date picker for referral column, no minimum date
            $('td.referral input').each(function () {
                $(this).datepicker({
                    dateFormat: "yy-mm-dd"
                });
            });
                //date picker for all other date columns with minimum dates
            $('td.min input').each(function () {
                var prevDate = String($(this).parent().prev().text());
                $(this).datepicker({
                    dateFormat: "yy-mm-dd",
                    minDate: prevDate
                });
            });

            //Send clearance info to db
            $('select.clearance').each(function () {
                $(this).change(function () {
                    var clearanceLevel = $(this).val();
                    var cell = $(this).parent();
                    var rowIdNo = $(cell).parent().children('td.idnumber').text();
                    var data = {"rowIdNo": rowIdNo, "clearanceLevel": clearanceLevel};
                    var dataSend = JSON.stringify(data);
                    $.ajax({
                        type: 'POST',
                        url: 'clearanceupdates',
                        contentType: 'application/json',
                        data: dataSend
                    });
                });
            });

            //Send Future Considerations to db
            $('select.future').each(function () {
                $(this).change(function () {
                    var future = $(this).val();
                    var cell = $(this).parent();
                    var rowIdNo = $(cell).parent().children('td.idnumber').text();
                    var data = {"rowIdNo": rowIdNo, "futureCon": future};
                    var dataSend = JSON.stringify(data);
                    $.ajax({
                        type: 'POST',
                        url: 'futureupdates',
                        contentType: 'application/json',
                        data: dataSend
                    });
                });
            });


            //Send referral dates to db
            $('td.referral input').each(function() {
                $(this).change(function(){
                    var refDate = $(this).val();
                    var cell = $(this).parent();
                    var rowIdNo = $(cell).parent().children('td.idnumber').text();
                    var data = {"rowIdNo": rowIdNo, "refDate": refDate};
                    var dataSend = JSON.stringify(data);
                    $.ajax({
                        type: 'POST',
                        url: "referraldateupdates",
                        contentType: 'application/json',
                        data: dataSend
                    });
                });
            });

            //Send interview dates to db
            $('td.interview input').each(function () {
                $(this).change(function () {
                    var intDate = $(this).val();
                    var cell = $(this).parent();
                    var rowIdNo = $(cell).parent().children('td.idnumber').text();
                    var data = {"rowIdNo": rowIdNo, "intDate": intDate};
                    var dataSend = JSON.stringify(data);
                    $.ajax({
                        type: "POST",
                        url: "interviewdateupdates",
                        contentType: 'application/json',
                        data: dataSend
                    });
                });
            });

            //Send offer dates to db
            $('td.offer input').each(function () {
                $(this).change(function () {
                    var offDate = $(this).val();
                    var cell = $(this).parent();
                    var rowIdNo = $(cell).parent().children('td.idnumber').text();
                    var data = {"rowIdNo": rowIdNo, "offDate": offDate};
                    var dataSend = JSON.stringify(data);
                    $.ajax({
                        type: "POST",
                        url: "offerdateupdates",
                        contentType: "application/json",
                        data: dataSend
                    });
                });
            });

            //Send hired dates to db
            $('td.hired input').each(function () {
                $(this).change(function () {
                    var hireDate = $(this).val();
                    var cell = $(this).parent();
                    var rowIdNo = $(cell).parent().children('td.idnumber').text();
                    var data = {"rowIdNo": rowIdNo, "hireDate": hireDate};
                    var dataSend = JSON.stringify(data);
                    $.ajax({
                        type: "POST",
                        url: "hiredateupdates",
                        contentType: "application/json",
                        data: dataSend
                    });
                });
            });

            //Send notes to db
            $('td.notes input').each(function () {
                $(this).change(function () {
                    var notes = $(this).val();
                    var cell = $(this).parent();
                    var rowIdNo = $(cell).parent().children('td.idnumber').text();
                    var data = {"rowIdNo": rowIdNo, "notes": notes};
                    var dataSend = JSON.stringify(data);
                    $.ajax({
                        type: "POST",
                        url: "notesupdates",
                        contentType: "application/json",
                        data: dataSend
                    });
                });
            });

            //Save button to refresh page
            $('#tableupdate').click(function () {
                location.reload();
            });

        },

        //statesave to save current filtering and pagination changes if page is refreshed
        stateSave: true,

    }); //close datatables function



}); //close document onready
