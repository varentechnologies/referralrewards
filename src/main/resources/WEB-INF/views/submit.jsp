<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<sec:authentication var="user" property="principal" />

<!doctype html>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}">
    <title>Submit a Lead/Referral</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script type="text/javascript" src ="js/menu.js"></script>
    <style>

        .descriptions{
            text-align:left !important;
        }


        a#recruiting{
            position:absolute;
            right:10px;
            top:40px;
            font-family:Verdana, Arial, sans-serif;
            font-size:.7em;
        }
        a#recruiting:hover{
            cursor:pointer;
            font-weight:bold;

        }
        #comment{
            display:block;
        }
        textarea{
            resize:none;
            width:500px;
            height:200px;
        }
    </style>
    <t:question_style/>

</head>

<body>


<header id="question-vue">
    <img id="logo" src="https://i.imgur.com/waTcQEo.jpg"/>
    <p id="menuopen">MENU</p>
    <div id="title">
        <h1>LEAD THE WAY - <span id="subtitle">Employee Referral Program</span></h1>
    </div>

    <nav>
        <ul>
            <p id="menuclose">X</p>
            <li>
                <a href="home">
                    <svg><use xlink:href="images/icons.svg#home"></use></svg>
                    Home
                </a>
            </li>
            <li>
                <a href="info">
                    <svg><use xlink:href="images/icons.svg#info"></use></svg>
                    Info
                </a>
            </li>
            <li>
                <a href="leaderboard">
                    <svg><use xlink:href="images/icons.svg#leaderboard"></use></svg>
                    Leader -<br>Board
                </a>
            </li>
            <li>
                <a href="prizes">
                    <svg><use xlink:href="images/icons.svg#present"></use></svg>
                    Prizes
                </a>
            </li>
            <li id="current">
                <a href="submit">
                    <svg><use xlink:href="images/icons.svg#referral"></use></svg>
                    Submit A<br>Lead/Referral
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
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
    <a id="recruiting" @click="question_active=true">SEND A QUESTION</a>
    <t:question/>

</header>

<div id="container">

    <h2>LEAD/REFERRAL FORM</h2>


    <p class="descriptions">Please enter as much information as you can. You can submit either a lead (with no resume) or a referral (with a resume).
        If you are submitting a lead, you must provide at
        least a full name and either a phone number OR email address. If you are submitting a referral, you must include at least the candidate's
        full name, email OR phone number, and a resume. In addition, please enter your own full name and Varen employee email,
        and indicate whether or not you wish to remain anonymous throughout the recruiting process. You will be contacted by the
        Recruiting Department throughout the recruiting process, but please reach out with questions!</p>


<div class="form" id="vue" >
           <form action="refer"  id="referral_form" method="post" v-show="form_mode == 'submit'" modelAttribute="refform" enctype="multipart/form-data">
            <fieldset>
               <legend><strong>Candidate Information</strong></legend>
                Is this a lead or referral?
                <input type="radio" name="type" id="type1" value="lead" required>
                <label for="type1">Lead</label> &nbsp;
                <input type="radio" name="type" id="type2" value="referral" required>
                <label for="type2">Referral</label><br>
                   <br>
                <div class="underline-input"><label for="lastName">Last Name:</label><br>
                    <input type="text" id="lastName" name="lastName" required v-on:change="lastName_change">
                    <span class="error" v-show="has_lastName_error">{{lastName_error_msg}}</span></div>
                <br><div class="underline-input">
                <label for="firstName">First Name:</label><br>
                <input type="text" id="firstName" name="firstName" required v-on:change="firstName_change">
                <span class="error" v-show="has_firstName_error">{{firstName_error_msg}}</span></div>
                <br><div class="underline-input">
                <label for="candidateEmail">Email:</label><br>
                <input type="text" id="candidateEmail" name="candidateEmail" required="required" v-on:change="candidateEmail_change">
                <span class="error" v-show="has_candidateEmail_error">{{candidateEmail_error_msg}}</span></div>

                <br><div class="underline-input">
                <label for="candidatePhone">Phone Number:</label><br>
                <input type="text" id="candidatePhone" name="candidatePhone" required="required" v-on:change="candidatePhone_change">
                <span class="error" v-show="has_candidatePhone_error">{{candidatePhone_error_msg}}</span></div>
                <br>
                <div>
                <label>Clearance Level:</label><br>

                <input type="radio" name="clearanceLevel" id="cleared" value="1">
                <label for="cleared">SC SCI with polygraph</label> &nbsp;
                <input type="radio" name="clearanceLevel" id="notcleared" value="0">

                <label for="notcleared">Other / No clearance</label><br>
                    <br></div>
                <br><div class="underline-input">
                <label for="possiblePosition">Position Referred For:</label><br>
                <input type="text" id="possiblePosition" name="possiblePosition" v-on:change="possiblePosition_change">
                <span class="error" v-show="has_possiblePosition_error">{{possiblePosition_error_msg}}</span></div>

                <br><div class="underline-input">
                <label for="knownBy">How do you know this candidate?</label><br>
                <input type="text" id="knownBy" name="knownBy" v-on:change="knownBy_change">
                <span class="error" v-show="has_knownBy_error">{{knownBy_error_msg}}</span></div>

                <br><div class="underline-input">
                <label for="qualifications">Why is this candidate qualified for this position?</label><br>
                <input type="text" id="qualifications" name="qualifications" v-on:change="qualifications_change">
                <span class="error" v-show="has_qualifications_error">{{qualifications_error_msg}}</span></div>

                <br><div class="underline-input">
                <label for="resume">Attach Resume</label><br>
                <input type="file" tabindex="5" name="file" id="resume" v-on:change="resume_change">
                <span class="error" v-show="has_resume_error">{{resume_error_msg}}</span></div>

            </fieldset>
            <fieldset>
                <legend><strong>Employee Information (Your Info)</strong></legend>

                <div class="underline-input">
                <label for="empln">Last Name:</label><br>
                <input type="text" id="empln" name="emplastname" required v-on:change="empln_change">
                <span class="error" v-show="has_empln_error">{{empln_error_msg}}</span></div>

                <br><div class="underline-input">
                <label for="empfn">First Name:</label><br>
                <input type="text" id="empfn" name="empfirstname" required v-on:change="empfn_change">
                    <span class="error" v-show="has_empfn_error">{{empfn_error_msg}}</span></div>

                <br><div class="underline-input">
                <label for="empemail">Employee Email:</label><br>
                <input type="text" id="empemail" name="empemail" required v-on:change="empemail_change">
                    <span class="error" v-show="has_empemail_error">{{empemail_error_msg}}</span></div>

                <br>
                Do you wish to remain anonymous during the recruitment process?<br>
                <input type="radio" name="anon" id="anon1" value="1" required>
                <label for="anon1">Yes</label> &nbsp;
                <input type="radio" name="anon" id="anon2" value="0" required>
                <label for="anon2">No</label>
                <br><br>
                <span id="comment">Comments:</span>
                <textarea name="comment"></textarea>
            </fieldset>
            <input type="submit" value="Submit">

            <input id="csrf-input" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>
</div>

    <div id="success_messages"></div>

</div>

<script>

    $('#type2').click(function() {
        $("#resume").prop("required", true);
        $("#type1").click(function() {
            $('#resume').prop("required", false);
        })
    });

    $('#candemail').change(function() {
        $('#phone').prop("required", false);
    });
    $('#phone').change(function() {
        $('#candemail').prop("required", false);
    });

   /* $(function() {
        var form = $('#referral_form');
        $(form).submit(function(event){
            event.preventDefault();
            var formData = $(form).serialize();
            $.ajax( {
                type: 'POST',
                url: $(form).attr('action'),
                data: formData
            })
                .done(function(){
                    alert('Thank you! Your submission was received.');
                    $('input[type="text"]').val('');
                    $('input[type="radio"]').prop('checked', false);
                })
                .fail(function(){
                    alert('Oops! An error occurred and your referral could not be submitted.');
                })
        });
    });*/


    var vm = new Vue({
        el: "#vue",
        data: {
            form_mode: 'submit',
            has_firstName_error: false,
            has_lastName_error: false,
            has_candidateEmail_error: false,
            has_candidatePhone_error: false,
            has_clearanceLevel_error: false,
            has_possiblePosition_error: false,
            has_knownBy_error: false,
            has_qualifications_error: false,
            has_resume_error: false,
            has_empln_error: false,
            has_empfn_error:false,
            has_empemail_error:false,
            firstName_error_msg: '',
            lastName_error_msg: '',
            candidateEmail_error_msg: '',
            candidatePhone_error_msg: '',
            clearanceLevel_error_msg: '',
            possiblePosition_error_msg: '',
            knownBy_error_msg:'',
            qualifications_error_msg:'',
            resume_error_msg:'',
            empln_error_msg:'',
            empfn_error_msg:'',
            empemail_error_msg:'',

        },
        methods: {
            firstName_change: function (event) {

                var alphanumericRegex = new RegExp("^[A-Za-z]"); //Firstname is not alphanumeric
                if (!alphanumericRegex.test(event.target.value)) {
                    this.has_firstName_error = true;
                    this.firstName_error_msg = "First name must be alphabetical";
                    return;
                }

                if (event.target.value.length < 1 || event.target.value.length > 45) {
                    this.has_firstName_error = true;
                    this.firstName_error_msg = 'First name must be between 1 and 45 characters';
                    return;
                }
                this.has_firstName_error = false;
                this.firstName_error_msg = '';
            },
            lastName_change: function (event) {
                var alphanumericRegex = new RegExp("^[A-Za-z]"); //Lastname is not alphanumeric
                if (!alphanumericRegex.test(event.target.value)) {
                    this.has_lastName_error = true;
                    this.lastName_error_msg = "Last name must be alphabetical";
                    return;
                }

                if (event.target.value.length < 1 || event.target.value.length > 45) {
                    this.has_lastName_error = true;
                    this.lastName_error_msg = 'Last name must be between 1 and 45 characters';
                    return;
                }

                this.has_lastName_error = false;
                this.lastName_error_msg = '';
            },
            candidateEmail_change: function (event) {
                if (event.target.value.length < 3 || event.target.value.length > 254) {
                    this.has_candidateEmail_error = true;
                    this.candidateEmail_error_msg = "Email must be between 3 and 254 characters";
                    return;
                }

                this.has_candidateEmail_error = false;
                this.candidateEmail_error_msg = '';
            },
            candidatePhone_change: function (event) {

                if (event.target.value.length < 10 || event.target.value.length > 12) {
                    this.has_candidatePhone_error = true;
                    this.candidatePhone_error_msg = "Phone number (without country code) must be 10 digits";
                    return;
                }

                this.has_candidatePhone_error = false;
                this.candidatePhone_error_msg = '';

            },

            clearanceLevel_change: function (event) {

                if (event.target.value.length <1 || event.target.value.length > 45) {
                    this.has_clearanceLevel_error = true;
                    this.clearanceLevel_error_msg = "Clearance Level must be between 1 and 45 characters.";
                    return;
                }

                this.has_clearanceLevel_error = false;
                this.clearanceLevel_error_msg = '';
            },
            possiblePosition_change: function (event) {

                if (event.target.value.length < 1 || event.target.value.length > 45) {
                    this.has_possiblePosition_error = true;
                    this.possiblePosition_error_msg = "Position must be between 1 and 45 characters";
                    return;
                }

                this.has_possiblePosition_error = false;
                this.possiblePosition_error_msg = '';

            },
            knownBy_change: function (event) {

                if (event.target.value.length < 1 || event.target.value.length > 256) {
                    this.has_knownBy_error = true;
                    this.knownBy_error_msg = "Relationship must be between 1 and 256 characters";
                    return;
                }

                this.has_knownBy_error = false;
                this.knownBy_error_msg = '';

            },
            qualifications_change: function (event) {

                if (event.target.value.length < 1 || event.target.value.length > 256) {
                    this.has_qualifications_error = true;
                    this.qualifications_error_msg = "Qualifications must be between 1 and 256 characters.";
                    return;
                }

                this.has_qualifications_error = false;
                this.qualifications_error_msg = '';

            },
            resume_change: function (event) {
                var extension = resume.substr((resume.lastIndexOf('.') +1));
                if (!/(pdf|zip|doc|txt|docx|rtf)$/ig.test(extension)) {
                    this.has_resume_error = true;
                    this.resume_error_msg = "Please use DOC, DOCX, PDF, TXT, RTF or Zip.";}
                this.has_resume_error = false;
                this.resume_error_msg = '';
                },




            empln_change: function (event) {
                this.has_empln_error = false;
                this.empln_error_msg = '';
                var alphanumericRegex = new RegExp("^[A-Za-z]"); //Firstname is not alphanumeric
                if (!alphanumericRegex.test(event.target.value)) {
                    this.has_empln_error = true;
                    this.empln_error_msg = "Last name must be alphanumeric";
                    return;
                }

                if (event.target.value.length < 1 || event.target.value.length > 45) {
                    this.has_empln_error = true;
                    this.empln_error_msg = "Your last name must be between 1 and 45 characters";
                    return;
                }

                this.has_empln_error = false;
                this.empln_error_msg = '';

            },
            empfn_change: function (event) {
                this.has_empfn_error = false;
                this.empfn_error_msg = '';
                var alphanumericRegex = new RegExp("^[A-Za-z]"); //Firstname is not alphanumeric
                if (!alphanumericRegex.test(event.target.value)) {
                    this.has_empfn_error = true;
                    this.empfn_error_msg = "First name must be alphanumeric";
                    return;
                }

                if (event.target.value.length < 1 || event.target.value.length > 45) {
                    this.has_empfn_error = true;
                    this.empfn_error_msg = "Your first name must be between 1 and 45 characters";
                    return;
                }

                this.has_empfn_error = false;
                this.empfn_error_msg = '';

            },
            empemail_change: function (event) {
                this.has_empemail_error = false;
                this.empemail_error_msg = '';

                if (event.target.value.length < 3 || event.target.value.length > 254) {
                    this.has_empemail_error = true;
                    this.empemail_error_msg = "Your email must be between 3 and 254 characters";
                    return;
                }

                this.has_empemail_error = false;
                this.empemail_error_msg = '';

            },
            register:function(e){

                if(this.has_firstName_error || this.has_lastName_error || this.has_candidateEmail_error || this.has_candidatePhone_error || this.has_clearanceLevel_error || this.has_possiblePosition_error|| this.has_knownBy_error||this.has_qualifications_error||this.has_resume_error||this.has_empfn_error||this.has_empln_error||this.has_empemail_error){

                    e.preventDefault();
                }
            }
        }
    });


</script>

</body>

</html>