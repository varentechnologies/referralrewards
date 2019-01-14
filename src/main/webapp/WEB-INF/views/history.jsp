<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}"/>
    <title>Lead the Way | Home</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script type="text/javascript" src="js/menu.js"></script>
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
            <li><p id="menuclose">X</p></li>
            <li id="current">
                <a href="home">

                    <svg>
                        <use xlink:href="images/icons.svg#home"></use>
                    </svg>
                    Home</a></li>
            <li>
                <a href="info">
                    <svg>
                        <use xlink:href="images/icons.svg#info"></use>
                    </svg>
                    Info
                </a>
            </li>
            <li>
                <a href="leaderboard">

                    <svg>
                        <use xlink:href="images/icons.svg#leaderboard"></use>
                    </svg>
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

                    <svg>
                        <use xlink:href="images/icons.svg#present"></use>
                    </svg>
                    Prizes

                </a>
            </li>
            <li>
                <a href="submit">

                    <svg>
                        <use xlink:href="images/icons.svg#referral"></use>
                    </svg>
                    Submit a Lead/Referral

                </a>
            </li>

            <sec:authorize access="hasAnyAuthority('admin', 'superadmin')">
                <li>
                    <a href="admin">
                        <svg>
                            <use xlink:href="images/icons.svg#saw"></use>
                        </svg>
                        Admin Panel
                    </a>
                </li>
            </sec:authorize>
        </ul>
    </nav>
    <form id="logout" action="/logout" method="post">
        <input type="submit" value="LOG-OUT"/>
        <input id="csrf-input" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
    <a id="recruiting" @click="question_active=true">SEND A QUESTION</a>
    <t:question/>
</header>