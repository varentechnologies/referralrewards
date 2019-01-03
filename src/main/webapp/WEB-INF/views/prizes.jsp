<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lead the Way | Prizes</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/prizegallerystyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script type="text/javascript" src ="js/menu.js"></script>
    <style>
        h3{
            clear: both;
        }
        .redeemed{
        opacity:0.3;
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
            <li>
                <a href="leaderboard">

                    <svg><use xlink:href="images/icons.svg#leaderboard"></use></svg>
                    Leaderboard

                </a>
            </li>
            <li id="current">
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

    <div id="popup">
        <img class="close" src="images/close.png" alt="red x in a circle">
        <div class="largerimg"><img id="largerimg" src="" alt=""></div>
        <div class="details">
            <h1>ITEM NAME</h1>
            <p>Item Description.</p>
            <!-- Decorate the three spans below to change the styling of the points message for the popup -->
            <span v-if="redeemed_popup_level" class="noteligible">You have already redeemed a prize in this level</span>
            <span v-else-if="needed_points <= 0" class="eligible">You are eligible for this prize!</span>
            <span v-else class="noteligible">You need {{needed_points}} more point(s) for this prize.</span>
            <button id="redeem">Redeem Prize</button>
        </div>
    </div>
    <div id="deliverypopup">
        <img class="close" src="images/close.png" alt="red x in a circle">
        <h1>How would you like to receive your prize?</h1>
        <input type="radio" name="delivery" id="pickup" value="pickup" required>
        <label for="pickup">Pick-Up at Varen Headquarters</label><br>
        <input type="radio" name="delivery" id="mailed" value="mailed" required>
        <label for="mailed">Home Delivery</label>
        <div id="pickupinfo">
            <h2>Pick-Up Information</h2>
            <form id="managerinfo">
                <label for="fname">First Name: *</label><br>
                <input type="text" name="fname" id="fname" required><br>
                <label for="lname">Last Name: *</label><br>
                <input type="text" name="lname" id="lname" required><br>
                <label for="manager">Direct Manager's Email: *</label><br>
                <input type="text" name="manager" id="manager" placeholder="@varentech.com" required><br>
                <input type="submit" value="Submit">
            </form>
        </div>
        <div id="mailinginfo">
            <h2>Mailing Information</h2>
            <form id="homedeliveryinfo">
                <label for="firstname">First Name: *</label><br>
                <input type="text" name="firstname" id="firstname" required><br>
                <label for="lastname">Last Name: *</label><br>
                <input type="text" name="lastname" id="lastname" required><br>
                <label for="manageremail">Direct Manager's Email: *</label><br>
                <input type="text" name="manageremail" id="manageremail" placeholder="@varentech.com" required><br>
                <label class='left' for="streetaddress">Street Address: *</label><br>
                <input class='left' type="text" name="streetaddress" id="streetaddress" required><br>
                <label class='left' for="city">City: *</label><br>
                <input class='left' type="text" name="city" id="city" required><br>
                <label class='left' for="state">State: *</label><br>
                <input class='left' type="text" name="state" id="state" required><br>
                <label class='left' for="zipcode">ZIP Code: *</label><br>
                <input class='left' type="text" name="zipcode" id="zipcode" required>
                <input type="submit" value="Submit">
            </form>
        </div>
    </div>


    <h2>PRIZES</h2>

    <p class="descriptions"><strong>Level 1</strong> = 8 pts.  |  <strong>Level 2</strong> = 18 pts.  |  <strong>Level 3</strong> = 26 pts.  |  <strong>Level 4</strong> = 36 pts.  |<br><strong>Level 5</strong> = 44 pts. | <strong>Level 6</strong> = 54 pts.
    </p>

    <h3>Level 1</h3>
    <div class="level" data-level="1">
        <c:choose>
            <c:when test="${pointsThisYear < 8}">
                <p class="noteligible">You need ${8 - pointsThisYear} more points to redeem a prize in this level!</p>
            </c:when>
            <c:otherwise>
                <p class="eligible" v-if="!redeemed_level(1)">You are eligible for a prize at this level!</p>
                <p class="noteligible" v-else>You have already redeemed a prize in this level</p>
            </c:otherwise>
        </c:choose>
        <div class="imgcontainer" v-bind:class="{'redeemed':redeemed_level(1)}">
            <div class="overlaycontainer" id="lev1prize1" :class="{'inactive':redeemed_level(1)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev1prize2" :class="{'inactive':redeemed_level(1)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev1prize3" :class="{'inactive':redeemed_level(1)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev1prize4" :class="{'inactive':redeemed_level(1)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
        </div>
        <div class="captions">
            <p>Netgear Universal Wi-Fi<br>Range Extender</p>
            <p>Amazon Echo Dot &amp; <br>Echo Buttons</p>
            <p>Lunch with Marty Leshin</p>
            <p>iHeart Radio Gift</p>
        </div>
    </div>

    <h3>Level 2</h3>
    <div class="level" data-level="2">
        <c:choose>
            <c:when test="${pointsThisYear < 18}">
                <p class="noteligible">You need ${18 - pointsThisYear} more points to redeem a prize in this level!</p>
            </c:when>
            <c:otherwise>
                <p class="eligible" v-if="!redeemed_level(2)">You are eligible for a prize at this level!</p>
                <p class="noteligible" v-else>You have already redeemed a prize in this level</p>
            </c:otherwise>
        </c:choose>
        <div class="imgcontainer">
            <div class="overlaycontainer" id="lev2prize1" :class="{'inactive':redeemed_level(2)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev2prize2"  :class="{'inactive':redeemed_level(2)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev2prize3"  :class="{'inactive':redeemed_level(2)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev2prize4"  :class="{'inactive':redeemed_level(2)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
        </div>
        <div class="captions">
            <p>Fitbit Charge 2</p>
            <p>HP Sprocket Plus Photo Printer</p>
            <p>Sonos Play1 Wireless Speaker</p>
            <p>Keurig K-Elite</p>

        </div>
    </div>

    <h3>Level 3</h3>
    <div class="level" data-level="3">
        <c:choose>
            <c:when test="${pointsThisYear < 26}">
                <p class="noteligible">You need ${26 - pointsThisYear} more points to redeem a prize in this level!</p>
            </c:when>
            <c:otherwise>
                <p class="eligible" v-if="!redeemed_level(3)">You are eligible for a prize at this level!</p>
                <p class="noteligible" v-else>You have already redeemed a prize in this level</p>
            </c:otherwise>
        </c:choose>
        <div class="imgcontainer">
            <div class="overlaycontainer" id="lev3prize1" :class="{'inactive':redeemed_level(3)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev3prize2" :class="{'inactive':redeemed_level(3)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev3prize3" :class="{'inactive':redeemed_level(3)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev3prize4" :class="{'inactive':redeemed_level(3)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
        </div>
        <div class="captions">
            <p>Dronium 3X Drone</p>
            <p>Yeti Roadie 20 Cooler</p>
            <p>PlayStation VR The Elder Scrolls V: Skyrim VR Bundle</p>
            <p>Sonos Play3 Wireless Speaker</p>
        </div>
    </div>

    <h3>Level 4</h3>
    <div class="level" data-level="4">
        <c:choose>
            <c:when test="${pointsThisYear < 36}">
                <p class="noteligible">You need ${36 - pointsThisYear} more points to redeem a prize in this level!</p>
            </c:when>
            <c:otherwise>
                <p class="eligible" v-if="!redeemed_level(4)">You are eligible for a prize at this level!</p>
                <p class="noteligible" v-else>You have already redeemed a prize in this level</p>
            </c:otherwise>
        </c:choose>
        <div class="imgcontainer">
            <div class="overlaycontainer" id="lev4prize1" :class="{'inactive':redeemed_level(4)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev4prize2" :class="{'inactive':redeemed_level(4)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev4prize3" :class="{'inactive':redeemed_level(4)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev4prize4" :class="{'inactive':redeemed_level(4)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
        </div>
        <div class="captions">
            <p>Beats Wireless Headphones</p>
            <p>Vitamix Explorian Series E310 Blender</p>
            <p>Nintendo Switch 32GB Console</p>
            <p>Insignia Beverage Cooler Kegerator</p>
        </div>
    </div>

    <h3>Level 5</h3>
    <div class="level" data-level="5">
        <c:choose>
            <c:when test="${pointsThisYear < 44}">
                <p class="noteligible">You need ${44 - pointsThisYear} more points to redeem a prize in this level!</p>
            </c:when>
            <c:otherwise>
                <p class="eligible" v-if="!redeemed_level(5)">You are eligible for a prize at this level!</p>
                <p class="noteligible" v-else>You have already redeemed a prize in this level</p>
            </c:otherwise>
        </c:choose>
        <div class="imgcontainer">
            <div class="overlaycontainer" id="lev5prize1" :class="{'inactive':redeemed_level(5)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev5prize2" :class="{'inactive':redeemed_level(5)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev5prize3" :class="{'inactive':redeemed_level(5)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev5prize4" :class="{'inactive':redeemed_level(5)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
        </div>
        <div class="captions">
            <p>Pelican Trailblazer<br>100 NXT Kayak</p>
            <p>KitchenAid Artisan Mixer</p>
            <p>Playstation 4 Console</p>
            <p>GoPro HERO6</p>
        </div>
    </div>

    <h3>Level 6</h3>
    <div class="level" data-level="6">
        <c:choose>
            <c:when test="${pointsThisYear < 54}">
                <p class="noteligible">You need ${54 - pointsThisYear} more points to redeem a prize in this level!</p>
            </c:when>
            <c:otherwise>
                <p class="eligible" v-if="!redeemed_level(6)">You are eligible for a prize at this level!</p>
                <p class="noteligible" v-else>You have already redeemed a prize in this level</p>
            </c:otherwise>
        </c:choose>
        <div class="imgcontainer">
            <div class="overlaycontainer" id="lev6prize1" :class="{'inactive':redeemed_level(6)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev6prize2" :class="{'inactive':redeemed_level(6)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev6prize3" :class="{'inactive':redeemed_level(6)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
            <div class="overlaycontainer" id="lev6prize4" :class="{'inactive':redeemed_level(6)}">
                <div class="overlay">
                    <div class="text">Click for<br>details<br>or to<br>redeem</div>
                </div>
            </div>
        </div>
        <div class="captions">
            <p>Apple Watch Series 3</p>
            <p>Sony 65" LED Smart TV</p>
            <p>Canon EOS Rebel T6 DSLR Camera</p>
            <p>Dawes Lightning 1500 Bicycle</p>
        </div>
    </div>

</div>

<script>
    vm = new Vue({

        el:'#container',
        data:{
            points_this_year:${pointsThisYear},
            popup_level:0,
            levels_redeemed:${levelsRedeemed}
        },
        computed:{
            points_requirement(){
                if(this.popup_level == 1){
                    return 8;
                }
                if(this.popup_level == 2){
                    return 18;
                }
                if(this.popup_level == 3){
                    return 26;
                }
                if(this.popup_level == 4){
                    return 36;
                }
                if(this.popup_level == 5){
                    return 44;
                }
                if(this.popup_level == 6){
                    return 54;
                }
            },
            needed_points(){
                return this.points_requirement - this.points_this_year;
            },
            redeemed_popup_level(){
                return this.levels_redeemed.includes(Number(this.popup_level));
            }

        },
        methods:{
            redeemed_level(level){
                return this.levels_redeemed.includes(level);
            }
        }
    });
</script>

<script src="js/prizepopup.js"></script>

</body>

</html>