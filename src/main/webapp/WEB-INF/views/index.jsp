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
    <script type="text/javascript" src ="js/menu.js"></script>
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
            <li id="current">
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

    <h2>HOME</h2>
    <h3>Varen Technologies' <script type="text/javascript">var year = new Date();document.write(year.getFullYear());</script><br>Rewards Program: LEAD THE WAY</h3>
    <h4>Rules:</h4>

    <div class="instruction-card-container">


        <div class="flip-container" ontouchstart="this.classList.toggle('hover');">
            <div class="flipper">
                <div class="front">
                    <div class="instruction-card red-orange">
                        <span>1.</span>
                        <svg><use xlink:href="/images/icons.svg#mail"></use></svg>
                        <p>Please forward your referral here.</p>
                    </div>
                </div>
                <div class="back">
                    <div class="instruction-card blue-green">
                        <p class="instruction-card-description">Leads are welcome too, simply forward the name of the candidate along with any contact information you may have. <br><br>No contact information? Just provide clues that may help us seek out their info (e.g. previous employer(s), tech group member, etc)</p>

                    </div>
                </div>
            </div>
        </div>
        <div class="flip-container" ontouchstart="this.classList.toggle('hover');">
            <div class="flipper">
                <div class="front">
                    <div class="instruction-card teal-green">
                        <span>2.</span>
                        <svg><use xlink:href="/images/icons.svg#anonymous"></use></svg>
                        <p>Tell us if we can use your name</p>
                    </div>
                </div>
                <div class="back">
                    <div class="instruction-card purple-pink">
                        <p class="instruction-card-description">Tell us whether or not we can use your name during the recruiting process. <br><br>Keep in mind that a familiar name can help turn a referral or lead into an actual candidate.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="flip-container" ontouchstart="this.classList.toggle('hover');">
            <div class="flipper">
                <div class="front">
                    <div class="instruction-card blue-green">
                        <span>3.</span>
                        <svg><use xlink:href="/images/icons.svg#feedback"></use></svg>
                        <p>We'll be in touch</p>

                    </div>
                </div>
                <div class="back">
                    <div class="instruction-card red-orange">
                        <p class="instruction-card-description">The recruiter working with your candidate will update you directly as mutual interest progresses. <br><br>You can also check the "Info" tab for status overviews.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="flip-container" ontouchstart="this.classList.toggle('hover');">
            <div class="flipper">
                <div class="front">
                    <div class="instruction-card purple-pink">
                        <span>4.</span>
                        <svg><use xlink:href="/images/icons.svg#present"></use></svg>
                        <p>Collect fabulous prizes!</p>
                    </div>
                </div>
                <div class="back">
                    <div class="instruction-card teal-green">
                        <p class="instruction-card-description">Earn points towards prizes with your employee referrals. <br><br>**Leads will turn into "official" employee referrals, eligible for points, once the lead replies to recruiting (reply can be with or without interest in immediate consideration).</p>

                    </div>
                </div>
            </div>
        </div>

    </div>

    <div id="addinfo" class="question-container">
        <svg>
            <use xlink:href="/images/icons.svg#down"></use>
        </svg>
        <div class="qa-block"> <span class="question">Additional details about this game & Varen's viewpoint on the referral process:</span>
            <div class="answer"><p>
                <b>The new referral philosophy at Varen Technologies - </b><b style="color: red;">Leads</b>. <br>In an effort to make our employee referral program an easier one in which to participate,
                we have decided to break the mold for traditional concept of an employee referral. In short, we want to expand our thinking of referrals to include<i> referral </i><i style="color:red;">leads</i>.
                In doing so, we should experience a threefold effect: 1.) the employee referral pool should increase 2.) the potential degree of effort involved for our employees should decrease, & 3.) there should be an increase in comfort level for those who wish to participate.  Here are some of the concepts that are part of this expanded way of viewing employee referrals: <br>
                The employee can simply <i>know of</i> the person they would like to refer. Examples:<br><br>
                -   Perhaps there is someone from a previous employer who you heard good things about, but never met or worked with in the past.<br>
                -   Perhaps someone at a conference or tech event spoke or asked good questions of a speaker that you felt would make a good addition to the company.<br>
                -   Perhaps there's been someone at a social event that you did not personally meet but you had heard worked in the tech field and in our customer space.<br>
                -   This referral/lead is not one in which you must have had a relationship with or even have met or been introduced to the potential referral.<br>
                <br>The employee does not have to produce a resume, just a name and any additional information that may help the recruiting team search for contact information if contact information is not readily known by the referring employee (any past employer(s) and or any technical group associations.)
                <br>There is no need for the employee to speak with the referred candidate to affirm interest in being considered for employment at Varen.
                <br><br><b>Here is how it works:</b>
                <br>1. Forward to recruiting the name of an individual that you know, or know of, along with contact information or information about that person that could help us locate contact information (ie - current and/or former employers or technical group associations).
                <br>2. Indicate if we can use your name when reaching out to the referral or if you prefer to remain anonymous. (Recruiting can operate with or without using your name. Take into consideration, however, that if your name can be mentioned, the chances increase that the call turns the referral into an actual candidate. A simple conversation with one of the recruiters can formulate a way in which your name is interjected into the conversation.)
                <br>3. Recruiting returns an update on the efforts to reach out within a week of the referral/lead.
                <br>4. Any referral/lead that engages a recruiter upon reaching out becomes an official employee referral eligible for any referral program benefits.
                <br><br><i><b>That's it!!! Simple! Easy!! Effective!!!</b></i>
                <br><br>    </p></div>
        </div>
    </div>

  <h4>Points and Rewards:</h4>
    <div class="paragraph" style="text-align: left">
        <span class="red">Participation and referral progress are tracked, and activity levels are assigned rewards points to referrer as follows:</span>
        <p class="indent"><b>1 point**</b> for any referral made <br>
            <b>2 points**</b> for any referral which procures an in-person interview<br>
            <b>2 points**</b> for any referral which receives an offer, contingent or firm <br>
            <b>4 points**</b> for any referral who accepts an offer and starts (awarded on start date)<br>
            <br><b>**</b> = Points double if candidate has an active TS/SCI with Polygraph clearance.</p>

          <br><p class="red">Rewards:</p>
        <p class="indent">
            <strong>Prize Levels</strong> - As you earn points you will reach higher prize levels, making you eligible for different prizes.<br><br>
            <strong>Level 1:</strong> 8 points | <strong>Level 2:</strong> 18 points | <strong>Level 3:</strong>
            26 points | <strong>Level 4:</strong> 36 points | <strong>Level 5:</strong> 44 points | <strong>Level 6:</strong> 54 points<br><br>
            <strong>Monthly participation drawings</strong> - Each month, Varen will have a drawing ($500 cash/Amazon card) for all employees who have accumulated rewards points within the given month. Rewards points earned within the month will be tallied and the winner will be announced from a random rewards drawing. Each point reward earning within the month will correlate to the number of chances / tickets placed into the monthly drawing.<br><br>
            <strong>2018 Employee Referrer of the Year</strong> - Employee with the most points accumulated over the duration of the rewards promotion earns a 5K bonus.<br>
        </p>


    </div>

    <h4>FAQs</h4>
    <br>
    <div class="question-container">
        <svg>
            <use xlink:href="/images/icons.svg#down"></use>
        </svg>
        <div class="qa-block"> <span class="question">Do I need to have a personal relationship with the candidate I am referring?</span>
            <p class="answer">Not necessarily! Varen's new Employee Referral Program allows you to submit LEADS. You can think of a lead as a mere employee suggestion. Maybe there is someone that you heard good things about, or someone that impressed you at a conference. You do not need to be familiar with their employment circumstances to recommend them for Varen! </p>
        </div>
    </div>
    <div class="question-container">
        <svg>
            <use xlink:href="/images/icons.svg#down"></use>
        </svg>
        <div class="qa-block"> <span class="question">Does my referral need to be actively looking for new employment?</span>
            <p class="answer">Not necessarily! Any referral that produces meaningful engagement will contribute towards Employee Referral Program benefits. You do not need to speak to the candidate beforehand to affirm their interest in Varen.</p>
        </div>
    </div>
    <div class="question-container">
        <svg>
            <use xlink:href="/images/icons.svg#down"></use>
        </svg>
        <div class="qa-block"> <span class="question">Do I need to submit a resume when referring a candidate?</span>
            <p class="answer">No. A referral without a resume is a lead. A lead becomes a full referral once contact with the candidate has been established.</p>
        </div>
    </div>
    <div class="question-container">
        <svg>
            <use xlink:href="/images/icons.svg#down"></use>
        </svg>
        <div class="qa-block"> <span class="question">What happens in an instance where an employee referral is presented after a lead is forwarded for the same person?</span>
            <p class="answer">If an employee referral is forwarded before any given "lead" turns into a "candidate," then the latter referral will take precedence over the lead.</p>
        </div>
    </div>


        <br>
        <div><a id="button" href="submit">
        <button class="button">
            SUBMIT A<br>LEAD/REFERRAL
            <div class="button__horizontal"></div>
            <div class="button__vertical"></div>
        </button>
        </a>
        </div>
</div>

<script>
    Array.from(document.querySelectorAll('.question-container svg')).forEach(function(element){
        element.addEventListener('click',function(event){
            var clicked_svg = event.target.closest('svg');
            var href = clicked_svg.querySelector('use').getAttribute('xlink:href');
            var hashLoc = href.indexOf('#');
            var prefix = href.substring(0,hashLoc);
            var icon_name = href.substring(hashLoc+1);

            if(icon_name == 'up'){
                clicked_svg.querySelector('use').setAttributeNS('http://www.w3.org/1999/xlink','xlink:href',prefix+"#down");
                var answer = clicked_svg.closest('.question-container').querySelector('.answer');

                answer.style.maxHeight = '0px';

            }
            else{
                clicked_svg.querySelector('use').setAttributeNS('http://www.w3.org/1999/xlink','xlink:href',prefix+"#up");
                var answer = clicked_svg.closest('.question-container').querySelector('.answer');

                answer.style.maxHeight = '600px';
            }

        });
    });


</script>

</div>


</body>

</html>
