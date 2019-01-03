$(document).ready(function () {

    //ajax set up
    var csrf_token = $('meta[name="_csrf"]').attr('content');
    $.ajaxSetup({
        headers: {"X-CSRF-Token": csrf_token}
    });

    //opening pop-up
    $('div.overlay').each(function () {
        $(this).click(function () {
            if(this.closest('.overlaycontainer').classList.contains('inactive')) return;
            var level = $(this).closest('.level');
            vm.popup_level = level.attr('data-level');

            var pointcomment = $(level).children('p');
            $('#popup').fadeIn();
            //gray out redeem button if ineligible for level
            if ($(pointcomment).attr('class') == "noteligible"){
                $('#popup .details button').attr('id', 'noclick');
            }
            //show delivery popup when redeem button is clicked if eligible
            if ($(pointcomment).attr("class") == "eligible") {
                $('#popup .details button').attr('id', 'redeem');
            }

            $('.details button').each(function () {
                if ($(this).attr('id') == "noclick"){
                    $(this).unbind().bind('click', function () {
                        alert("Sorry, you do not have enough points to redeem from this prize level!");
                    });
                }
                if ($(this).attr('id') == "redeem"){
                    $(this).unbind().bind('click', function () {
                        $('#popup').hide();
                        $('#deliverypopup').show();
                    })
                }
            });


                    //Forms appear for pickup or home delivery
                        //pickup
                    $('#pickup').click(function () {
                        var pickup = $('#deliverypopup #pickup');
                        if ($(pickup).prop("checked") == true){
                            $('#pickupinfo').show();
                            $('#mailinginfo').hide();
                            $('#homedeliveryinfo input[type="text"]').val('');
                        }
                    });
                        //delivery
                    $('#mailed').click(function () {
                        var mailed = $('#deliverypopup #mailed');
                        if ($(mailed).prop("checked") == true){
                            $('#mailinginfo').show();
                            $('#pickupinfo').hide();
                            $('#managerinfo input[type="text"]').val('');
                        }
                    });

                    //send data when pickup form is submitted
                    $('#managerinfo input[type="submit"]').unbind().bind('click', (function (event) {
                        event.preventDefault();
                        var prizeLevel = vm.popup_level;

                        var prizeData = {"prizeLevel": prizeLevel, "prizeName":document.querySelector('#popup').querySelector('.details h1').innerHTML};
                        var data = $('#managerinfo').serializeArray().reduce(function(a, x) { a[x.name] = x.value; return a; }, {});
                        Object.assign(data, prizeData);
                        var dataSend = JSON.stringify(data);
                        $.ajax({
                            type: "POST",
                            url: "prizeredeemed",
                            contentType: "application/json",
                            data: dataSend
                        })
                            .done(function(){
                                alert('Thank you! Your prize was redeemed. You will be notified by HR when your prize is available for pickup at Varen HQ.');
                                $('#popup #largerimg').attr('src', '');
                                $('.details h1').html('');
                                $('.details p').html('');
                                $('#deliverypopup input[type=radio]').prop("checked", false);
                                $('#managerinfo input[type=text]').val('');
                                $('#pickupinfo').hide();
                                $('#deliverypopup').hide();
                            })
                            .fail(function(){
                                alert('Oops! An error occurred and your prize could not be redeemed.');
                            })
                    })
                    );
                    //send data when delivery form is submitted
                    $('#homedeliveryinfo input[type="submit"]').unbind().bind('click', (function (event) {
                        event.preventDefault();
                        var prizeLevel = vm.popup_level;
                        var prizedata = {"prizeLevel": prizeLevel, "prizeName":document.querySelector('#popup').querySelector('.details h1').innerHTML};
                            var data = $('#homedeliveryinfo').serializeArray().reduce(function(a, x) { a[x.name] = x.value; return a; }, {});
                            Object.assign(data,prizedata);
                        var dataSend = JSON.stringify(data);
                        $.ajax({
                            type: "POST",
                            url: "prizeredeemed",
                            contentType: "application/json",
                            data: dataSend
                        })
                            .done(function(){
                                $('#popup #largerimg').attr('src', '');
                                $('.details h1').html('');
                                $('.details p').html('');
                                $('#homedeliveryinfo input[type=text]').val('');
                                $('#deliverypopup input[type=radio]').prop("checked", false);
                                $('#mailinginfo').hide();
                                $('#deliverypopup').hide();
                                alert('Thank you! Your prize was redeemed. You will be notified by HR when your prize has been shipped.');
                            })
                            .fail(function(){
                                alert('Oops! An error occurred and your prize could not be redeemed.');
                            })
                    })
                    );
                });
    });


    //closing the pop-up
    $('.close').click(function () {
        $('#popup').hide();
        $('#popup #largerimg').attr('src', '');
        $('.details h1').html('');
        $('.details p').html('');
        $('#popup .details button').attr('id', 'empty');
        $('#managerinfo input[type=text]').val('');
        $('#homedeliveryinfo input[type=text]').val('');
        $('#deliverypopup input[type=radio]').prop("checked", false);
        $('input[type=text]').val('');
        $('input[type=radio]').val('');
        $('#pickupinfo').hide();
        $('#mailinginfo').hide();
        $('#deliverypopup').hide();


    });


    //LEVEL 1 PRIZES
        //wifi extender
    $('#lev1prize1').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev1prize1.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('Netgear Universal Wi-Fi<br>Range Extender');
        $('.details p').html('Broaden your network connection with a range extender that gives you ' +
            'extra Wi-Fi coverage in your home. Smart LED indicators will direct you to the optimal ' +
            'location to plug the extender into the wall, so you can easily enjoy improved range and ' +
            'speed on your mobile and wired devices. Save on data usage by connecting your smartphone or ' +
            'tablet to your home network.');
    });
        //echo dot
    $('#lev1prize2').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev1prize2.jpg');
        $('#largerimg').css({'width':'100%', 'height':'auto'});
        $('.details h1').html('Amazon Echo Dot<br>& Echo Buttons');
        $('.details p').html('Deliver your favorite playlist anywhere in your home with the Amazon Echo Dot ' +
            'voice-controlled device. Control most electronic devices through voice activation, or schedule a ride ' +
            'with Uber and order a pizza. The Amazon Echo Dot voice-controlled device turns any home into a smart home ' +
            'with the Alexa app on a smartphone or tablet.');
    });
    //Marty
    $('#lev1prize3').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev1prize3.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('Lunch with<br>Marty Leshin');
        $('.details p').html("Marty Leshin is the President/CEO of Varen Technologies. Have the opportunity to talk " +
            "one-on-one with him during lunch at the restaurant of your choosing.");
    });
    //iHeart Radio
    $('#lev1prize4').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev1prize4.png');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('iHeart Radio Gift');
        $('.details p').html('Choose from concert tickets, meet-n-greet passes, event tickets, and more. Ask HR for details on currently available options, ' +
            'as they are subject to change. Limited availability.');
    });

    //LEVEL 2 PRIZES
    //Fitbit
    $('#lev2prize1').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev2prize1.jpg');
        $('.details h1').html('Fitbit Charge 2');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details p').html('Fitbit Charge 2 Heart Rate + Fitness Wristband: Put your daily exercise motivation on your' +
            ' wrist with the Fitbit Charge 2. This heart rate & fitness wristband automatically tracks all-day activity, ' +
            'sleep and exercise. It also features personalized exercise modes to view real-time stats on display, a way to ' +
            'track your cardio fitness level, and guided breathing sessions to help you find moments of calm in your day. ' +
            'Packed with the smartphone notifications you need most and a new sleek design with an interactive OLED display, ' +
            'Charge 2 is your perfect companion for all-day and workouts.');
    });
    //Photo Printer
    $('#lev2prize2').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev2prize2.jpg');
        $('#largerimg').css({'width':'100%', 'height':'auto'});
        $('.details h1').html('HP Sprocket Plus Photo Printer');
        $('.details p').html('Produce physical copies of smartphone image files with this Bluetooth-enabled HP Sprocket ' +
            'Plus photo printer. Its compact form fits 10 sheets of 2.3 x 3.4-inch photo paper, and it lets you edit photos ' +
            'creatively via the HP Sprocket app. This portable HP Sprocket Plus photo printer also scans its printed images ' +
            'to quickly locate their digital sources.');
    });
    //Play1 Speaker
    $('#lev2prize3').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev2prize3.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('Sonos Play1 Wireless Speaker');
        $('.details p').html("Enjoy big audio from a compact system with the Sonos PLAY:1. This speaker's custom-tuned " +
            "drivers and software deliver rich, powerful sound, while wireless streaming lets you enjoy your music in any" +
            " room of your home.");
    });
    //Keurig
    $('#lev2prize4').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev2prize4.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('Keurig K-Elite');
        $('.details p').html("The newest Keurig® single serve coffee maker, the K-Elite™ coffee maker features Strong " +
            "Brew and Iced settings for bolder coffee and delicious iced beverages. This coffee maker also features a " +
            "12oz brew size for travel mugs, a 75oz removable water reservoir, simple button controls and programmable " +
            "features.");
    });

    //LEVEL 3 PRIZES
        //Drone
    $('#lev3prize1').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev3prize1.jpg');
        $('#largerimg').css({'width':'100%', 'height':'auto'});
        $('.details h1').html('Dronium 3X Drone');
        $('.details p').html('Document an adventure from different angles with this Protocol Dronium drone. Its camera ' +
            'produces images in 720p resolution to capture every detail of a scene, and three selectable speeds let you ' +
            'cover distances in adequate time. This Protocol Dronium drone includes a USB card reader, so you can expand ' +
            'its storage.');
    });
        //Yeti Cooler
    $('#lev3prize2').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev3prize2.jpg');
        $('#largerimg').css({'width':'100%', 'height':'auto'});
        $('.details h1').html('Yeti Roadie 20 Cooler');
        $('.details p').html('If it is a day trip or an extended stay the YETI® Roadie 20 is made to last no matter how ' +
            'rugged you work or play. The compact and sleek design of this cooler makes it the ideal companion to take on ' +
            'the boat or to the jobsite. The T-Rex™ latches and InterLock™ lid system provide a solid seal and twice the ' +
            'insulation so your lunch and drinks stay colder longer. Expect nothing but quality and performance from your ' +
            'YETI Roadie 20 Cooler.');
    });
        //PlayStation VR Game
    $('#lev3prize3').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev3prize3.jpg');
        $('#largerimg').css({'width':'100%', 'height':'auto'});
        $('.details h1').html('PlayStation VR The Elder Scrolls<br>V: Skyrim VR Bundle');
        $('.details p').html('Surround yourself with the sights and sounds of a favorite gaming franchise with this ' +
            'PlayStation VR Skyrim bundle. Including everything from VR goggles and a camera to two move controllers, ' +
            'this setup offers plug-and-play compatibility with all PlayStation 4 consoles. This PlayStation VR Skyrim ' +
            'bundle includes a copy of The Elder Scrolls V: Skyrim VR, so you can walk the world of Dragonborn.');
    });
        //Play3 Speaker
    $('#lev3prize4').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev3prize4.jpg');
        $('#largerimg').css({'width':'100%', 'height':'auto'});
        $('.details h1').html('Sonos Play3 Wireless Speaker');
        $('.details p').html("Fill your home with rich, dynamic sound with Sonos Play:3, a speaker that's versatile " +
            "enough to put just about anywhere. Position it horizontally or vertically for a perfect fit in tight spots " +
            "around your home like on bookshelves or a nightstand.");
    });


    //LEVEL 4 PRIZES
        //Beats Headphones
    $('#lev4prize1').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev4prize1.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('Beats Wireless Headphones');
        $('.details p').html("Beats Studio3 Wireless headphones deliver a premium listening experience with Pure Adaptive " +
            "Noise Canceling (Pure ANC) to actively block external noise, and real-time audio calibration to preserve " +
            "clarity, range, and emotion. It continuously pinpoints sounds to block while automatically responding to " +
            "individual fit and music playback. The efficiency of the Apple W1 chip supports up to 22 hours of battery " +
            "life with Pure ANC on, and Pure ANC off for low-power mode provides up to 40 hours of playback.");
    });
    //Blender
    $('#lev4prize2').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev4prize2.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('Vitamix Explorian Series<br>E310 Blender');
        $('.details p').html("The Vitamix Explorian Series Blender boasts high-performance with powerful variable speed " +
            "and pulse functions to create a wide variety of blended drinks. Features 2 peak output horsepower and laser-cut " +
            "stainless steel blades for optimal blending results. ");
    });
    //Nintendo
    $('#lev4prize3').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev4prize3.jpg');
        $('#largerimg').css({'width':'100%', 'height':'auto'});
        $('.details h1').html('Nintendo Switch 32GB Console');
        $('.details p').html("Show off your personality when playing favorite Switch video games with this neon Nintendo " +
            "Joy-Con controller. The small size lets you cradle it in your hand for maximum control, and the ergonomically " +
            "designed buttons and analog stick reduce fatigue. This Nintendo Joy-Con controller contains a 525 mAh " +
            "rechargeable battery for hours of play.");
    });
    //Kegerator
    $('#lev4prize4').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev4prize4.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('Insignia Beverage Cooler<br>Kegerator');
        $('.details p').html("This Insignia™ NS-BK1TSS6 kegerator/beverage cooler holds either a 1/2 keg or a 1/4 slim keg " +
            "and features an adjustable thermostat, so you can easily keep your favorite drinks cold. Two wire shelves help " +
            "you maintain organization.");
    });

    //LEVEL 5 PRIZES
        //kayak
    $('#lev5prize1').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev5prize1.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('Pelican Trailblazer 100 NXT Kayak');
        $('.details p').html("With an update on an old favorite, the Pelican® Trailblazer NXT Kayak boasts plenty of new features! " +
            "Much like the original Trailblazer, the NXT is easy to paddle and very stable, making it perfect for beginners. This " +
            "Next Gen boat features padded, comfortable seat and back, plus molded footrests for those long trips. You’ll enjoy the " +
            "cockpit table with bottle and accessory storage options. ");
    });

        //KitchenAid Mixers
    $('#lev5prize2').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev5prize2.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('KitchenAid Artisan Mixer');
        $('.details p').html("This attractively styled KitchenAid Artisan Stand Mixer is reason enough for you to get " +
            "busy in the kitchen. With a 5 qt. mixing bowl, powerful 325 watt motor, and 10 speed settings, this " +
            "tilt-back-head all-metal mixer is a kitchen essential. ");
    });
        //PlayStation Console
    $('#lev5prize3').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev5prize3.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('PlayStation 4 Console');
        $('.details p').html("Conquer virtual enemies with this Sony PlayStation 4. It's compatible with the latest game " +
            "titles to provide hours of entertainment, and it lets you access PlayStation Vue so you can enjoy your favorite " +
            "shows. This Sony PlayStation 4 has a 1TB hard drive, so you can store plenty of gaming files.");
    });
        //GoPro
    $('#lev5prize4').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev5prize4.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('GoPro HERO6 Black Action Camera');
        $('.details p').html("Includes:<br>Sony 32gb microSDHC Memory Card<br>Memory Card Wallet<br>Microfiber Cleaning Cloth<br>" +
            "Medium Hard Case for GoPro");
    });


    //LEVEL 6 PRIZES
    //Apple Watch
    $('#lev6prize1').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev6prize1.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('Apple Watch Series 3');
        $('.details p').html("Answer a call from your surfboard. Ask Siri to send a message. Stream your favorite songs on " +
            "your run. And do it all while leaving your phone behind. Introducing Apple Watch Series 3 with cellular. " +
            "Now you have the freedom to go with just your watch.");
    });
        //Sony TV
    $('#lev6prize2').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev6prize2.jpg');
        $('#largerimg').css({'width':'100%', 'height':'auto'});
        $('.details h1').html('Sony 65" LED Smart TV');
        $('.details p').html("Enjoy UHD movies and improve your gaming experience with this Sony 4K smart television, which " +
            "comes with an extra-vibrant Triluminos display. Connect this TV to your network wirelessly or via ethernet " +
            "cable and stream content on demand. Two responsive bass speakers and various surround sound options make the " +
            "built-in audio on this 65-inch Sony 4K smart television an acoustic delight.");
    });
        //Canon Camera
    $('#lev6prize3').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev6prize3.jpg');
        $('#largerimg').css({'width':'80%', 'margin-left': '10%', 'height':'auto'});
        $('.details h1').html('Canon EOS Rebel T6 DSLR Camera');
        $('.details p').html("Comprising a versatile set of imaging capabilities along with support for a connected " +
            "workflow, the EOS Rebel T6 from Canon is a compact, sleek DSLR featuring an 18MP APS-C CMOS sensor and a " +
            "DIGIC 4+ image processor. Combined, these two technologies avail rich image quality with reduced noise, " +
            "along with a native sensitivity range of ISO 100-6400 that can be further expanded to ISO 12800 to suit " +
            "working in low and difficult lighting conditions. The sensor and processor also enable the ability to shoot " +
            "continuously at 3 fps for photographing moving subjects, as well as recording Full HD 1080p/30 video. The rear " +
            "3.0-inch 920k-dot LCD offers a bright, clear image and built-in Wi-Fi with NFC also offers the ability to " +
            "wirelessly share imagery from your camera to a linked mobile device for instant online sharing.");
    });
        //Bicycle
    $('#lev6prize4').click(function () {
        $('#popup #largerimg').attr('src', '../images/lev6prize4.jpg');
        $('#largerimg').css({'width':'100%', 'height':'auto'});
        $('.details h1').html('Dawes Lightning 1500 Bicycle');
        $('.details p').html("**or comparable bike from BikesDirect.com – call HR for details**<br>Handbuilt advanced engineered and lightweight Altair 1 aluminum compact frame. Shimano 105/4600 " +
            "has 30 speeds, gives you most of the cutting edge tech of the top of the line Ultegra and Dura Ace without the " +
            "budget biting price. Also has carbon forks and Shimano wheelsets.");
    });


}); //end