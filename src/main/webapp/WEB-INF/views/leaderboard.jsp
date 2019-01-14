<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}"/>
    <title>Lead the Way | Leader-Board</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" href="css/tables.css">
    <script type="text/javascript" src ="js/menu.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script type="text/javascript">
        $(document).ready( function () {

          var table = $('#table1').DataTable({

                "fnRowCallback": function (nRow, aData, iDisplayIndex) {
                    var info = $(this).DataTable().page.info();
                    $("td:nth-child(1)", nRow).html(info.start + iDisplayIndex + 1);
                    return nRow;
                },
                ajax: {
                    url: "leaderboarddata",
                    dataSrc: ''
                },
              scrollX: true,
              paging: false,
                columnDefs:[{
                   "target":0,
                    "bsortable":false,
                    "ordering":false},
                    {"target":1,
                        "bsortable":false,
                    "ordering":false},
                    {"target":2,
                        "bsortable":false,
                    "ordering":false},
                    {"target":3,
                        "bsortable":true,
                    "ordering":true,
                    "order":'desc'},
                    {"target":4,
                        "bsortable":false,
                    "ordering":false}],

                columns: [
                    {"data":'', "defaultContent":""},
                    {"data": 'lastName'},
                    {"data": 'firstName'},
                    {"data": 'pointsThisYear'},
                    {"data": 'pointsThisMonth'}

                ],
              stateSave: true,
            });table.order([3,'desc']).draw();
        });

    </script>
    <style>
        p{
            font-family:Courier, Serif;
            font-size:1.2em;
        }
        .descriptions{
            text-align: left;
        }
    </style>
    <t:question_style/>

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
            <li>
                <a href="info">
                    <svg><use xlink:href="images/icons.svg#info"></use></svg>
                    Info
                </a>
            </li>
            <li id="current">
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

    <h2>LEADERBOARD</h2>
<p class="descriptions">
    <b>Monthly participation drawings:</b> - Each month, Varen will have a drawing ($500 cash/Amazon card) for all employees who have accumulated rewards points within the given month. Rewards points earned
    within the month will be tallied and the winner will be announced from a random rewards drawing. Each point earned within the month will correlate to the number of chances / tickets placed into the monthly drawing.<br><br>
    <b>2018 Employee Referrer of the Year:</b> - Employee with the most points accumulated over the duration of the rewards promotion earns a 5K bonus.<br></p>
<div id="table1_wrapper" class="dataTables-wrapper no-footer">
<table id="table1" class="display tablestyle tr dataTable" align="left" >
    <thead>
    <tr>
       <th ROWSPAN=".5" data-sortable="false">Rank</th>
        <th data-sortable="false">Last Name</th>
        <th data-sortable="false">First Name</th>
        <th data-sortable="false">Points in <div><script type="text/javascript">var year = new Date();document.write(year.getFullYear());</script></div></th>
        <th data-sortable="false">Points in <div><script type="text/javascript">var thismonth = new Date();var month = ["January", "February", "March", "April", "May","June","July","August","September", "October", "November", "December"];document.write(month[thismonth.getMonth()]);</script></div></th>
    </tr>
    </thead>

</table>
</div>
</div>
</body>

</html>