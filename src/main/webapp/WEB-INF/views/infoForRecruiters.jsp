<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lead the Way | Info</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <link href="https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.18/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.js"></script>
    <link href="https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet">
    <script src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
    <link rel="stylesheet" href="css/tables.css">
    <script src="js/recruiterinfoedit.js"></script>
    <script type="text/javascript" src ="js/menu.js"></script>
</head>
<style>
    #container{
        margin-bottom: 0;
    }
    #viewdeleted{
        font-family: Verdana, Arial, sans-serif;
        color: white;
        width: 130px;
        --box-shadow-color: darkgray;
        --border-color: darkgray;
        background-color: dimgray;
        position: relative;
        top: 50px;
    }
    #viewdeleted:hover{
        background-color: black;
        --box-shadow-color: black;
        --border-color: black;
    }
    #back{
        width: 130px;
        font-family: Verdana, Arial, sans-serif;
        background-color: #FF4545;
        --box-shadow-color: red;
        --border-color: red;
        color: white;
        position: relative;
        top: 50px;
    }
    #back:hover{
        background-color: red;
        --box-shadow-color: darkred;
        --border-color: darkred;
    }
</style>

<body>

<header id="question-vue">
    <div id="header-banner">
        <img id="logo" src="https://i.imgur.com/waTcQEo.jpg"/>

        <div id="title">
            <h1>LEAD THE WAY - <span id="subtitle">Employee Referral Program</span></h1>
        </div>
    </div>
    <p id="menuopen">MENU</p>


    <nav>
        <ul>
            <li> <p id="menuclose">X</p></li>
            <li >
                <a href="home">

                    <svg><use xlink:href="images/icons.svg#home"></use></svg>
                    Home</a></li>
            <li id="current">
                <a href="info">
                    <svg><use xlink:href="images/icons.svg#info"></use></svg>
                    Info
                </a>
            </li>
            <li>
                <a href="leaderboard">

                    <svg><use xlink:href="images/icons.svg#leaderboard"></use></svg>
                    Leaderboard

                </a>
            </li>
            <li>
                <a href="history">
                    <svg>
                        <use xlink:href="images/icons.svg#info"></use>
                    </svg>
                    History
                </a>
            </li>
            <li>
                <a href="prizes">

                    <svg><use xlink:href="images/icons.svg#present"></use></svg>
                    Prizes

                </a>
            </li>
            <li>
                <a href="submit">

                    <svg><use xlink:href="images/icons.svg#referral"></use></svg>
                    Submit a Lead/Referral

                </a>
            </li>

            <sec:authorize access="hasAnyAuthority('admin', 'superadmin')">
                <li>
                    <a href="admin">
                        <svg><use xlink:href="images/icons.svg#saw"></use></svg>
                        Admin Panel
                    </a>
                </li>
            </sec:authorize>
        </ul>
    </nav>
    <form  id ="logout" action="/logout" method="post" >
        <input type="submit"  value="LOG-OUT"/>
        <input id="csrf-input" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
    <a id="recruiting" @click="question_active=true">SEND A QUESTION</a>
    <t:question/>
</header>

<div id="container">

    <h2>CANDIDATE<br>INFO</h2>

    <h3>All Past Leads/Referrals</h3>

    <p class="descriptions">Click a cell to edit, then click 'Save'.<br>Note: Dates will be displayed in the format "YYYY/MM/DD".</p>

</div>

<div id="recruitertables">

    <table id="table" class="display tablestyle tr" style="width: 100%;">

        <sec:authorize access="hasAnyAuthority('admin', 'superadmin')">
            <button id="viewdeleted" class="standard-button orange" @click="deleted_referrals" v-if="referral_view == 'default'">View Deleted Referrals</button>
            <button id="back" class="standard-button green" @click="referrals" v-if="referral_view == 'deleted'">Back to Referrals</button>
        </sec:authorize>


        <thead>
        <tr>
            <th>ID No.</th>
            <th>Last<br>Name</th>
            <th>First<br>Name</th>
            <th>Double Points?<br>(Fully Cleared)</th>
            <th>Referral<br>Date</th>
            <th>Interview<br>Date</th>
            <th>Offer<br>Date</th>
            <th>Hire<br>Date</th>
            <th>Future<br>Considerations?</th>
            <th>In<br>Person<br>Referral</th>
            <th>Notes/<br>Comments</th>
            <th>Delete/<br>Recover</th>
        </tr>
        </thead>
    </table>

    <button id="tableupdate"><p>Save</p></button>

  <br><br><br>
    <h4 style="object-position: center">Enter A New Candidate:</h4>
    <form:form action="referral" id="manualreferralform" method="post">
    <fieldset>
    <table id="manualcandidate" class="display tablestyle tr" style="width: 100%; align-items: center; align-content: center;object-position: center ;">
        <thead>
        <tr>
            <th>Candidate<br>Last Name</th>
            <th>Candidate<br>First Name</th>
            <th>Employee Email</th>
            <th>Should Employee Be<br>Kept Anonymous?</th>
        </tr>
        </thead>
        <tr>
            <td>
                <label for="lastName">
                    <input type="text" id="lastName" name="lastName" required/>
                </label>
            </td>
            <td>
                <label for="firstName">
                    <input type="text" id="firstName" name="firstName" required/>
                </label>
            </td>
            <td>
                <label for="empemail">
                    <input type="text" id="empemail" name="empemail" required/>
                </label>
            </td>
            <td>
                <input type="radio" name="anon" id="anon1" value="1" required>
                <label for="anon1">Yes</label> &nbsp;
                <input type="radio" name="anon" id="anon2" value="0" required>
                <label for="anon2">No</label>
            </td>
        </tr>
    </table>
    </fieldset>
        <input type="submit" id="candidatesubmit" value="Submit">
    </form:form>

    <br>

    <br><br><br>
    <div id="successmessages"> </div>
</div>

        <script type="text/javascript">
        $(function() {

            var csrf_token = $('meta[name="_csrf"]').attr('content');
            $.ajaxSetup({
                headers: {"X-CSRF-Token": csrf_token},
            });
            var form = $('#manualreferralform');
            $(form).submit(function (event) {
                event.preventDefault();

                var formData = new FormData(this);
                $.ajax({
                    type: 'POST',
                    url: $(form).attr('action'),
                    data: formData,
                    dataType:'json',
                    processData:false,
                    contentType:false

                })
                    .done(function (data) {
                        if(data['success'] == true) {
                            alert('Thank you! Your submission was received.');
                            $('input[type="text"]').val('');
                            $('input[type="radio"]').prop('checked', false);
                        }
                        else{
                            alert('This employee is not registered');
                        }


                    })
                    .fail(function () {
                        alert('Oops! An error occurred and your referral could not be submitted.');
                    })
            });

        });

        vm = new Vue({
            el: '#recruitertables',
            data: {
                referral_view: 'default'
            },
            methods: {
                deleted_referrals() {
                    table.ajax.url('deletedrecruiterinfo').load();
                    this.referral_view = 'deleted';
                },
                referrals() {
                    table.ajax.url('recruiterinfo').load();
                    this.referral_view = 'default';
                }
            }
        })

</script>
</body>

</html>