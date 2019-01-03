<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}"/>
    <title>Lead the Way | Info</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.18/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" href="css/tables.css">
    <script type="text/javascript" src ="js/menu.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <t:question_style/>
    <script type="text/javascript">
        function getValue(){
            var returnValue = prompt ("Submit a question to recruiting here:", "What would you like to know?");
            return returnValue.toString();
        }

        $(document).ready( function () {
            $('#usertable').DataTable({
                ajax: {
                    url: "userinfo",
                    dataSrc: ''
                },


                columns: [
                    {"data": 'id'},
                    {"data": 'lastName'},
                    {"data": 'firstName'},
                    {"data": 'submitDate'},
                    {"data": 'status', className: 'status'}
                ],
                drawCallback: function () {
                    $('td.status').each(function () {
                        if ($(this).text() == "1"){
                            $(this).html('    <div class="status-symbol distort"><svg><use xlink:href="images/icons.svg#receive"></use></svg><span class="description">Referral Received</span></div>')
                        }
                        if ($(this).text() == "2"){
                            $(this).html('    <div class="status-symbol distort"><svg><use xlink:href="images/icons.svg#interview"></use></svg><span class="description">Interviewed</span></div>')
                        }
                        if ($(this).text() == "3"){
                            $(this).html('    <div class="status-symbol futuredistort"><svg><use xlink:href="images/icons.svg#offer"></use></svg><span class="description">Offer Made</span></div>')
                        }
                        if ($(this).text() == "4"){
                            $(this).html('    <div class="status-symbol futuredistort"><svg><use xlink:href="images/icons.svg#hire2"></use></svg><span class="description">Hired</span></div>')
                        }
                        if ($(this).text() == "5"){
                            $(this).html('    <div class="status-symbol larger futuredistort"><svg><use xlink:href="images/icons.svg#future2"></use></svg><span class="description">Under Future Consideration</span></div>')
                        }
                    });
                },
            });
        });
    </script>
    <style>

        /*Table*/
        p.descriptions svg{
            display:inline-block;
            height:1.2em;
            width:1.2em;
            margin-left:3px;
            margin-right:3px;
        }

        td.status{
            display:flex;
            align-items:center;
            justify-content:center;
            z-index:10;
        }
        .status-symbol{
            height:1.2em;
            width:1.2em;
            position:relative;
            z-index:10;
        }
        .status-symbol svg{
            height:100%;
            width:100%;
            z-index:10;
        }
        .description{
            position:absolute;
            background-color:#212121;
            color:white;
            padding:5px 5px;

            width:140px;
            bottom:calc(100% + 5px);
            left:50%;
            margin-left:-70px;
            visibility: hidden;
            opacity: 0;
            transition: opacity .5s;
            display:flex;
            align-items:center;
            justify-content:center;
            z-index:10;

        }
        .description::after{
            content: "";
            position: absolute;
            top: 100%;
            left: 50%;
            margin-left: -5px;
            border-width: 5px;
            border-style: solid;
            border-color: #212121 transparent transparent transparent;
        }
        .status-symbol:hover .description{
            visibility: visible;
            opacity: 1;
        }
        div.distort .description{
            transform:translateX(-6.5px);
        }
        .futuredistort .description{
            transform:translateX(-5px);
        }
        div.larger{
            height:1.3em;
            width:1.3em;
        }

        @media only screen and (max-width: 1150px){

        }
        #usertable{
            overflow-x:scroll !important;
        }

    </style>


</head>

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
            <li>
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

    <h2>LEAD/REFERRAL<br>INFO</h2>

    <h3>My Leads/Referrals</h3>

    <p class="descriptions">Key: <svg><use xlink:href="images/icons.svg#receive"></use></svg> = Referral Received | <svg><use xlink:href="images/icons.svg#interview"></use></svg> = Interviewed | <svg><use xlink:href="images/icons.svg#offer"></use></svg> = Offer made |<br><svg><use xlink:href="images/icons.svg#hire2"></use></svg> = Hired | <svg><use xlink:href="images/icons.svg#future2"></use></svg> = Under future consideration</p>

    <table id="usertable" class="display tablestyle tr" style="width: 100%">
        <thead>
            <tr>
                <th>ID<br>Number</th>
                <th>Last<br>Name</th>
                <th>First<br>Name</th>
                <th>Date<br>Submitted</th>
                <th>Status</th>
            </tr>
        </thead>
    </table>



</div>

</body>
</html>