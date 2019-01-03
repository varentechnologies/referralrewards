<%@ taglib prefix="v-on" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Varen Employee Referral Program | Login</title>
    <link href="/resources/css/fonts.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Titillium+Web" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            height: 100vh;
            background-color: #b71c1c;
            margin: 0;
        }

        #vue {
            height: 100%;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        #login-form, #register-form {
            height: 480px;
            width: 380px;
            background-color: #ECEFF1;
            border-radius: 5px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 20px;
        }

        #login-form {
            padding-top: 130px;
        }

        #register-form {
            padding-top: 60px;
        }

        div.underline-input {
            height: 3em;
            display: flex;
            flex-direction: column;
            width: 80%;
            color: dimgray;
            caret-color: dimgray;
            font-family: Courier, serif;
            position: relative;
        }

        div.underline-input input {
            background-color: transparent;
            border-top: 0;
            border-left: 0;
            border-right: 0;
            outline: none;
            /*border-bottom: 3px solid #4D207B;*/
            border-bottom: 3px solid dimgray;
            height: 2em;
            z-index: 1;
            padding-left: 5px;
            /*color: #4D207B;*/
            /*color:#00796B;*/
            color: dimgray;
            font-weight: bold;
        }

        div.underline-input label {
            position: absolute;
            bottom: calc(1em + 8px);
            padding-left: 5px;
            transition: bottom .1, font-size .2s, padding-left .1s;
            -webkit-transition: bottom .1s, font-size .2s, padding-left .1s;
        }

        div.underline-input input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0 30px #ECEFF1 inset;
            /* -webkit-text-fill-color: #4D207B !important;*/
            -webkit-text-fill-color: dimgray !important;
        }

        div.underline-input .error {
            height: 1em;
        }

        div.underline-input input:focus + label, div.underline-input input:valid + label {
            bottom: 100%;
            font-size: .7em;
            padding-left: 0;
        }

        #header {
            font-family: Courier, serif;
            color: white;
            font-size: 4em;
            margin-bottom: 30px;
            text-shadow: 0px 0px 6px rgba(255, 255, 255, 0.7);
            display: inline-block;
            margin-right: 50px;
            display: block;
        }

        #header-description {
            font-family: Courier, serif;
            color: white;
            text-shadow: 0px 0px 6px rgba(255, 255, 255, 0.7);
            font-size: 1.3em;
        }

        .standard-button {
            height: 35px;
            width: 100px;
            box-shadow: inset 0 1px 0 var(--box-shadow-color);
            border: 1px solid var(--border-color);
            border-radius: 2px;
        }

        .standard-button:hover {
            cursor: pointer;
        }

        .standard-button.orange {
            background-color: #FB8C00;
            --box-shadow-color: #FFCC80;
            --border-color: #EF6C00;
            color: #FFD180;
        }

        .standard-button.orange:hover {
            --box-shadow-color: #FFB74D;
            --border-color: #E65100;
            background-color: #F57C00;
        }

        .standard-button.green {
            background-color: #43A047;
            --box-shadow-color: #A5D6A7;
            --border-color: #2E7D32;
            color: #B9F6CA;
        }

        .standard-button.green:hover {
            --box-shadow-color: #81C784;
            --border-color: #1B5E20;
            background-color: #388E3C;
        }

        .standard-button.blue {
            background-color: #FF4545;
            --box-shadow-color: #EC7063;
            --border-color: red;
            color: white;
        }

        .standard-button.blue:hover {
            --box-shadow-color: #FF4545;
            --border-color: darkred;
            background-color: red;
        }

        .login-register-toggle {
            align-self: flex-end;
            margin-right: 10%;
            font-family: Verdana, Arial, sans-serif;
            color: dimgray;
            font-size: .8em;
        }

        .login-register-toggle:hover {
            cursor: pointer;
        }

        #header-container {
            display: flex;
            flex-direction: column;
            height: 480px;
            align-items: flex-start;
        }

        .underline-input .error {
            font-size: .7em;
            color: #d50000;
            font-family: Verdana, Arial, sans-serif;
        }

        #balloon-container {
            margin-top: 30px;
            height: 250px;
            width: 300px;
            position: relative;
        }

        #balloon-container svg {
            height: 200px;
            position: absolute;
            bottom: 0;
            animation: MoveUpDown 2s ease-in-out infinite;

        }

        @media only screen and (max-width: 1024px) {
            #vue{
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            #header-container{
                padding-top: 40px;
            }
            form{
                margin: 0 15px 50px 15px;
            }
            #login-form{
                width: 50%;
            }
            #balloon-container{
                width: 30%;
                margin-left: 35%;
                height: 100px;
                justify-content: center;
                margin-top: 100px;
            }
            #balloon-container svg{
                width: 100%;
                height: auto;
            }
            #header, #header-description{
                width: 100%;
                text-align: center;
            }
        }

        @media only screen and (max-width: 400px){
            #login-form{
                width: 90%;
                margin-left: 5%;
            }
        }

        @keyframes MoveUpDown {
            0%, 100% {
                bottom: 0;
            }
            50% {
                bottom: 20px;
            }
        }
    </style>
</head>

<body>
<div id="vue">
    <div id="header-container"><span id="header">LEAD THE WAY</span> <span id="header-description">Varen's Employee Referral Program</span>

        <div id="balloon-container">
            <svg>
                <use xlink:href="/resources/images/icons.svg#hot-air-balloon"></use>
            </svg>
        </div>


    </div>

    <form id="login-form" action="login" method="post" v-show="form_mode == 'login'">
        <div class="underline-input">
            <input id="login-username" type="text" name="username" required>
            <label for="login-username">Email</label>
            <span class="error"></span></div>
        <div class="underline-input">
            <input id="login-password" type="password" name="password" required>
            <label for="login-password">Password</label>
            <span class="error"></span></div>
        <button class="standard-button blue" type="submit">log in</button>
        <input id="csrf-input-login" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
    <script>
        /*  document.querySelectorAll('.login-register-toggle').forEach(function (element) {
              element.addEventListener('click', function (event) {
                  var form = event.target.closest('form'); //form that current user is on
                  var otherForm = form.getAttribute('id') == 'login-form' ? form.nextElementSibling : form.previousElementSibling; //finds the other form (to make visible)
                  form.style.display = "none"; //swaps visibility settings
                  otherForm.style.display = null;
              });
          });*/

        var vm = new Vue({
            el: "#vue",
            data: {
                form_mode: 'login',
                has_firstname_error: false,
                has_lastname_error: false,
                has_username_error: false,
                has_email_error: false,
                has_password_error: false,
                has_retype_password_error: false,
                firstname_error_msg: '',
                lastname_error_msg: '',
                username_error_msg: '',
                email_error_msg: '',
                password_error_msg: '',
                retype_password_error_msg: '',
                password: '',
                retype_password:''
            },
            methods: {
                firstname_change: function (event) {

                    var alphanumericRegex = new RegExp("^[A-Za-z0-9]*$"); //Firstname is not alphanumeric
                    if (!alphanumericRegex.test(event.target.value)) {
                        this.has_firstname_error = true;
                        this.firstname_error_msg = "First name must be alphanumeric";
                        return;
                    }

                    if (event.target.value.length < 1 || event.target.value.length > 45) {
                        this.has_firstname_error = true;
                        this.firstname_error_msg = 'First name must be between 1 and 45 characters';
                        return;
                    }
                    this.has_firstname_error = false;
                    this.firstname_error_msg = '';
                },
                lastname_change: function (event) {
                    var alphanumericRegex = new RegExp("^[A-Za-z0-9]*$"); //Lastname is not alphanumeric
                    if (!alphanumericRegex.test(event.target.value)) {
                        this.has_lastname_error = true;
                        this.lastname_error_msg = "Last name must be alphanumeric";
                        return;
                    }

                    if (event.target.value.length < 1 || event.target.value.length > 45) {
                        this.has_lastname_error = true;
                        this.lastname_error_msg = 'Last name must be between 1 and 45 characters';
                        return;
                    }

                    this.has_lastname_error = false;
                    this.lastname_error_msg = '';
                },
                email_change: function (event) {
                    if (event.target.value.length < 3 || event.target.value.length > 254) {
                        this.has_email_error = true;
                        this.email_error_msg = "Email must be between 3 and 254 characters";
                        return;
                    }

                    fetch('/user/email/available?q=' + event.target.value, {credentials: 'include'})
                        .then(function (response) {
                            if (!response.ok) throw new Error(response.statusText);
                            return response.json();
                        }).then(function (json) {
                        if (!json['available']) {
                            vm.has_email_error = true;
                            vm.email_error_msg = "Email is already registered";
                            return;
                        }
                    }).catch(function (error) {
                        console.log('Looks like there was a problem: \n', error);
                    })

                    this.has_email_error = false;
                    this.email_error_msg = '';
                },
                password_change: function (event) {
                    this.has_retype_password_error = false;
                    this.retype_password_error_msg = '';
                    if (event.target.value.length < 8 || event.target.value.length > 72) {
                        this.has_password_error = true;
                        this.password_error_msg = "Password must be between 8 and 72 characters";
                        return;
                    }

                    this.has_password_error = false;
                    this.password_error_msg = '';

                    if (this.retype_password != '' && event.target.value != this.retype_password) {
                        this.has_retype_password_error = true;
                        this.retype_password_error_msg = "Passwords must match";
                        return;
                    }
                },
                retype_password_change: function (event) {
                    this.has_retype_password_error = false;
                    this.retype_password_error_msg = '';

                    if (event.target.value != this.password) {
                        this.has_retype_password_error = true;
                        this.retype_password_error_msg = "Passwords must match";

                    }
                },

                register:function(e){

                    if(this.has_firstname_error || this.has_lastname_error || this.has_username_error || this.has_email_error || this.has_password_error || this.has_retype_password_error){
                        e.preventDefault();
                    }
                }
            }


        })
    </script>
</div>
</body>
</html>