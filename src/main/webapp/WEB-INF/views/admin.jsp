
<html>
<head>
    <meta charset="utf-8">
    <meta name="_csrf" content="${_csrf.token}"/>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <link rel="stylesheet" href="resources/css/fonts.css">

    <title>Admin Panel</title>
    <style>
        *{
            box-sizing: border-box;
        }
        body {
            margin: 0;
            height: 100vh;
            width:100vw;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        #employee-table {
            display: grid;
            grid-template-columns: 175px 175px 375px auto;
            grid-template-rows: auto repeat(10,32px);
            border-left: 2px solid #00695C;
            border-right: 2px solid #00695C;
            border-bottom: 2px solid #00695C;
            width: 1000px;
            min-height:354px;
            max-height:354px;
            box-sizing:content-box !important;


        }
        #container {
            display: flex;
            align-items: center;

            font-family: "AvenirNextLTW01-Regular";
            width: 100%;
            height: 100%;


        }


        #employee-table .header {
            padding: 5px 10px;
            display: flex;
            justify-content: center;
            background-color: #00695C;
            color: white;

        }
        #employee-table .header svg {
            height: 1.2em;
            width: 1.2em;
            margin-right: 5px;
        }
        #employee-table div.entry, .role-edit-button {

            word-break: break-all;
            padding: 5px;
            display: flex;
            align-items: center;
            border-right: 2px solid #00695C;
            border-bottom: 2px solid #00695C;
            background-color: #F5F5F5;
            position:relative;

        }

        #employee-table .entry.active {
            background-color: lemonchiffon;
        }
        #employee-table .entry.active .ring-container{
            display:block;

        }
        #employee-table .role-edit-button {
            border-right: none;
        }
        #employee-table div:nth-last-child(-n+4) {

        }
        #employee-table.full{
            /*border-bottom:none !important;*/
        }
        #employee-table.full .entry:nth-last-child(-n+4){
            border-bottom:none !important;
        }
        nav button {
            margin-right: 15px;
            margin-top: 20px;
            border: none;
            padding: 4px 8px;
            color: #9E9E9E;
            border: 1px solid #E0E0E0;
            background-color: transparent;
        }
        nav button:hover {
            background-color: #00796B;
            color: white;
            cursor: pointer;
        }
        .role-edit-button {
            position: relative;
            display: flex;
            justify-content: center;
            border-right:none !important;
        }
        #employee-table .role-edit-button:hover:not(.active) {
            background-color: #E0E0E0 !important;
            cursor: pointer;
        }
        .role-edit-button.active {
            background-color: lemonchiffon !important;
        }
        .role-edit-button ul {
            list-style-type: none;
            margin: 0;
            width: 100%;
            position: absolute;
            background-color: #424242;
            top: -2px;
            left: calc(100% + 2px);
            z-index: 1;
            padding: 0;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }
        .role-edit-button ul li {
            padding: 10px 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #80D8FF;
        }
        .role-edit-button svg {
            height: 1em;
            width: 1em;
            margin-right: 10px;
        }
        .role-edit-button span {
            font-family: "Century Gothic W01 Bold";
        }
        button.standard-button {
            height: 35px;
            width: 100px;
            box-shadow: inset 0 1px 0 var(--box-shadow-color);
            border: 1px solid var(--border-color);
            border-radius: 2px;
        }
        button.standard-button:hover {
            cursor: pointer;
        }
        button.standard-button.green {
            background-color: #43A047;
            --box-shadow-color:#A5D6A7;
            --border-color:#2E7D32;
            color: #B9F6CA;
        }
        button.standard-button.green:hover {
            --box-shadow-color:#81C784;
            --border-color:#1B5E20;
            background-color: #388E3C;
        }
        button.standard-button.red {
            background-color: #e53935;
            --box-shadow-color:#ef9a9a;
            --border-color:#c62828;
            color: #ff8a80;
        }
        button.standard-button.red:hover {
            background-color: #d32f2f;
            --box-shadow-color:#e57373;
            --border-color:#b71c1c;
        }
        #search-input-container {
            width: 1000px;
            margin-bottom: 20px;
            display: flex;
        }
        #search-input-container input {
            border: 1.5px solid #00695C;
            height: 35px;
            width: 250px;
            outline: none;
            padding: 5px 10px;
            border-radius: 5px;
            margin-right: 15px;
            box-shadow: 0 1px 2px rgba(12,13,14,0.1) inset;
        }
        #search-input-container label {
            position: relative;
            display: inline-block;
        }
        #search-input-container label span {
            position: absolute;
            bottom: calc(100% + 2px);
            font-size: .8em;
            color: #004D40;
            left: 5px;
        }
        #role-search-button {
            background-color: transparent;
            border: none;
            height: 35px;
            width: 250px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;

            background-color: #CB2B5E;
            margin-left: auto;
            position: relative;
            outline: none;
            color:white;
        }
        #role-search-button span{
            text-shadow:0px 0px 6px rgba(255,255,255,0.5);
        }
        #search-input-container button svg {
            height: 1.5em;
            width: 1.5em;
            margin-right: 3px;
        }
        #role-search-button ul {
            list-style-type: none;
            position: absolute;
            width: 100%;
            background-color: #424242;
            z-index: 1;
            padding: 0;
            top: 100%;
            margin: 0;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            font-weight: normal;
            color: #80D8FF;
            font-family: "AvenirNextLTW01-Regular";
        }
        #role-search-button.active {
            background-color: #A72A53;
        }
        #role-search-button ul li {
            padding: 10px 15px;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            width: 100%;
        }
        #role-search-button input[type="checkbox"] {
            height: 1.5em;
            width: 1.5em;
        }
        #role-search-button input[type="checkbox"]:hover {
            cursor: pointer;
        }
        #search-input-container button:hover {
            background-color: #A72A53;
            cursor: pointer;
        }
        #search-header-container {
            width: 1000px;
            height: auto;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            font-weight: bold;
            color:#753A88;
        }
        #search-header-container svg {
            height: 1em;
            width: 1em;
            margin-right: 3px;
        }
        #active-search-filters {
            width: 1000px;
            height: auto;
            /*   display: grid;
               grid-gap: 15px;
               grid-template-columns: repeat(10, auto);*/
            display:flex;
            margin-bottom: 20px;
            min-height: 35px;
            margin-top: 10px;

        }
        #active-search-filters div {
            padding: 5px 8px;
            background-color: #212121;
            display: flex;
            align-items: center;
            border-radius: 2px;
            height: 35px;
            color: #FAFAFA;
            position: relative;
            margin-right:25px;
        }
        #active-search-filters div span {
            max-width: 235px;
            overflow: hidden;
            word-wrap: nowrap;
            display: flex;
        }
        #active-search-filters span label {
            color: #80D8FF;
            margin-right: 5px;
            word-wrap: nowrap;
            white-space: nowrap;
        }
        #active-search-filters div svg {
            position: absolute;
            height: 1.2em;
            width: 1.2em;
            right: -.5em;
            top: -.5em;
        }
        #active-search-filters div svg:hover {
            cursor: pointer;
        }
        #page-nav button.active {
            background-color: #00796B;
            color: white;
        }
        #page-nav {
            width: 1000px;
        }
        #page-nav button{
            outline:none;

        }
        #active-search-filters-header {
            width: 1000px;
            text-align: left;
            font-size: .8em;
            color: purple;
            min-height: 15px !important;
            height:15px !important;
            display:inline-block;


        }
        .ring-container {
            display:none;
        }
        .circle {
            width: 15px;
            height: 15px;
            background-color: #62bd19;
            border-radius: 50%;
            position:absolute;

            right:calc(100% + 9.5px);
            bottom:calc(50% - 8px);


        }
        .ringring {
            border: 3px solid #62bd19;
            -webkit-border-radius: 30px;
            height: 25px;
            width: 25px;
            position:absolute;
            right:calc(100% + 4.5px);
            bottom:calc(50% - 13px);


            -webkit-animation: pulsate 1s ease-out;
            -webkit-animation-iteration-count: infinite;
            opacity: 0.0
        }
        @-webkit-keyframes pulsate {
            0% {
                -webkit-transform: scale(0.1, 0.1);
                opacity: 0.0;
            }
            50% {
                opacity: 1.0;
            }
            100% {
                -webkit-transform: scale(1.2, 1.2);
                opacity: 0.0;
            }
        }

        #admin-panel-container{

            padding-bottom:50px;
            background-color:#F5F5F5;
            border-image-width: 100% 0 0 0;

            border-left:10px solid #753A88;
            border-right:10px solid #CB2B5E;


            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            display:flex;
            flex-direction:column;
            min-height:765px;
            position:relative;
            align-items:center;
            min-width:1124px;
            margin:0 auto;
        }
        #admin-panel-container:after{
            content:'';
            width:100%;
            background:linear-gradient(to right, #753A88,#CB2B5E );
            height:10px;
            position:absolute;
            bottom:0;
        }

        #panel-header{
            width:100%;
            background:linear-gradient(to right, #753A88,#CB2B5E);
            height:60px;
            display:flex;
            align-items:center;
            justify-content:center;
        }
        #panel-content{
            padding-top:50px;
            padding-left:50px;
            padding-right:50px;
            min-height:631px;

        }
        #empty-table-placeholder{
            grid-column: 1 / 5;
            grid-template-rows:auto;
            grid-row:2 / 12;
            background-color:#F5F5F5;
            display:flex;
            align-items:center;
            justify-content:center;

        }
        .header{

            display:flex;
            align-items:center;
        }
        #panel-header span{

            text-shadow: 0px 0px 6px rgba(255,255,255,0.7);
            color:white;
            font-size:1.2em;
        }
        span.highlight{
            background-color:pink;
        }
        .loader{
            height:1em;
            width:1em;
            animation: spin .5s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .loader-container{
            height:35px;
            width:100px;
            display:flex;
            align-items:center;
            justify-content:center;
        }
        #notification label{
            padding:10px 20px;
            background-color:#424242;
            color:#80D8FF;
            margin-bottom:20px;
            display:block;
            text-align:center;
        }
        #notification{
            display:block;
            height:40px;
            width:100%;

        }
    </style>
</head>

<body>

<div id="container" v-on:mouseup="page_click">

    <div id="admin-panel-container">
        <div id="panel-header">
            <span>Administrator Panel</span>

        </div>
        <div id="panel-content">
            <div id="search-header-container">
                <svg>
                    <use xlink:href="resources/images/icons.svg#search"></use>
                </svg>
                <span>Search</span> </div>
            <div id="search-input-container">
                <label> <span>Name</span>
                    <input id="firstname" type="text" v-model ="name" v-on:input="current_page=1; query_change();"/>
                </label>
                <label> <span>Email</span>
                    <input id="email" type="text" v-model ="email" v-on:input="current_page=1; query_change();"/>
                </label>
                <button id="role-search-button" v-on:click="role_search_expanded = true" v-bind:class="{active:role_search_expanded}">
                    <svg>
                        <use xlink:href="resources/images/icons.svg#rolesearch"></use>
                    </svg>
                    <span>Search by Role</span>
                    <ul v-show="role_search_expanded">
                        <li v-for="role in all_roles">
                            <input type="checkbox" v-bind:value="role" v-model="role_search" v-on:change="current_page=1; query_change();"/>
                            <span>{{role}}</span>
                        </li>
                    </ul>
                </button>
            </div>
            <span id="active-search-filters-header">
  <label v-show="name != '' || email != '' || role_search.length > 0">Active Filters</label>
  </span>
            <div id="active-search-filters">
                <div v-if="name != ''">
                    <svg v-on:click="remove_filter('name')">
                        <use xlink:href="resources/images/icons.svg#delete"></use>
                    </svg>
                    <span>
      <label>name </label>
      {{name}}</span></div>
                <div v-if="email != ''"><span>
      <svg v-on:click="remove_filter('email')">
        <use xlink:href="resources/images/icons.svg#delete"></use>
      </svg>
      <label>email </label>
      {{email}}</span></div>
                <div v-for="role in role_search"><span>
      <svg v-on:click="remove_filter(role)">
        <use xlink:href="resources/images/icons.svg#delete"></use>
      </svg>
      <label>has role </label>
      {{role}}</span></div>
            </div>

            <span id="notification"><label  v-show='last_action.length > 0'>Successfully {{last_action == 'Grant' ? 'granted' : 'revoked'}} role {{last_action_role}} {{last_action==='Grant' ? 'to' : 'from'}} user {{last_action_target_name}}</label></span>
            <div id="employee-table" v-bind:class="{full:(employees.length == 10)}">
                <div class="header"><span>First Name</span></div>
                <div class="header"><span>Last Name</span></div>
                <div class="header">
                    <svg>
                        <use xlink:href="resources/images/icons.svg#email"></use>
                    </svg>
                    <span>Email</span> </div>
                <div class="header">
                    <svg>
                        <use xlink:href="resources/images/icons.svg#role"></use>
                    </svg>
                    <span>Edit Roles</span> </div>
                <div id="empty-table-placeholder" v-if="employees.length == 0"></div>
                <template v-for="employee in employees" :key="employee.id">
                    <div v-html="highlight(employee.firstName,search_query.firstname,'firstname')" class="entry">
                        <div class="ring-container">
                            <div class="ringring"></div>
                            <div class="circle"></div>
                        </div>

                        <slot></slot>
                    </div>
                    <div class="entry" v-html="highlight(employee.lastName,search_query.lastname,'lastname')">{{employee.lastName}}</div>
                    <div class="entry" v-html="highlight(employee.varenEmail,search_query.email),'email'">{{employee.varenEmail}}</div>
                    <drop-down class="entry" v-bind:grantable_roles="grantable_roles" v-bind:employee="employee" ref="employee_drop_down" v-on:role_update="role_update"></drop-down>
                </template>
            </div>
            <nav id="page-nav">
                <button v-show="current_page != first_page" v-on:click="current_page = current_page - 1; query_change();">prev</button>
                <template v-if="page_lower_bound != first_page">
                    <button v-on:click="current_page = first_page; query_change();">{{first_page}}</button>
                    <span v-bind:style="{marginRight:'15px'}">...</span> </template>
                <button v-for="n in range(page_lower_bound,page_upper_bound)" v-on:click="current_page = n; query_change();" v-bind:class="{active:(n == current_page)}">{{n}}</button>
                <template v-if="page_upper_bound != total_pages"> <span v-bind:style="{marginRight:'15px'}">...</span>
                    <button v-on:click="current_page = total_pages; query_change();">{{total_pages}}</button>
                </template>
                <button v-if="current_page != total_pages" v-on:click="current_page = current_page + 1; query_change();">next</button>
            </nav>
        </div>
    </div>
</div>

<script>

    String.prototype.highlight = function(search) {


        var target = this;
        /*
        return target.split(new RegExp(search,"i")).join(replacement);*/

        var split = target.split(new RegExp("("+search+")","i"));
        var to_return = "";
        for(var i in split){
            if(split[i].toUpperCase() === search.toUpperCase()){
                to_return+="<span class=\"highlight\">"+split[i]+"</span>";
            }
            else{
                to_return+=split[i];
            }
        }
        return to_return;


    };

    Vue.component('togglebutton',{
        name:'togglebutton',
        props:['action', 'role','employee'],
        template:"<li><label>{{role}}</label><button v-bind:class='buttonType' @click='toggle' v-show='!loading'>{{action}}</button><div class='loader-container' v-show='loading'><svg class='loader'><use xlink:href='/resources/images/icons.svg#loading'></use></svg></div></li>",
        computed:{
            buttonType:function(){
                let vm = this;
                return{
                    'standard-button':true,
                    'green':(vm.action === 'Grant'),
                    'red':(vm.action === 'Revoke')
                }
            }
        },
        methods:{
            toggle:function(){

                let vm = this;
                vm.loading = true;

                fetch('/admin/role/'+vm.role+'/'+vm.action+'/'+vm.employee.id, {
                    credentials: 'include',
                    method:'POST',
                    headers:{
                        "Content-type":"application/json",
                        "X-CSRF-TOKEN":document.querySelector('meta[name=_csrf]').content
                    }
                })
                    .then(function (response) {
                        if (!response.ok) throw new Error(response.statusText);
                        return response.json();
                    }).then(function (json) {
                        vm.loading = false;
                    if(json){
                        vm.$emit('rolechange',vm.employee,vm.role,vm.action);
                    }

                }).catch(function (error) {
                    console.log('Looks like there was a problem: \n', error);
                })

            }
        },
        data:function(){
            return{
                loading:false
            }
        }
    });

    Vue.component('drop-down',{
        props:['grantable_roles','employee'],
        template:"<div class='role-edit-button' v-on:click='expanded = true; highlight();' v-bind:class='{active:expanded}'>\n" +
        "    <svg>\n" +
        "        <use xlink:href='resources/images/icons.svg#expand'></use>\n" +
        "    </svg>\n" +
        "    <span>Change Permissions</span>\n" +
        "    <ul v-show='expanded'>\n" +
        "\n" +
        "        <togglebutton v-for='role in grantable_roles' v-if='employee_has_role(employee,role)' action='Revoke' v-bind:role='role' v-bind:employee='employee' v-bind:key='role' @rolechange='update_role'></togglebutton>\n" +
        "        <togglebutton v-else action='Grant' v-bind:role='role' v-bind:key='role' v-bind:employee='employee' @rolechange='update_role'></togglebutton>\n" +
        "    \n" +
        "        \n" +
        "    </ul>\n" +
        "</div>",
        methods:{
            employee_has_role(employee,role){

                for(var r of employee.authorities){


                    if(r == role){
                        return true;
                    }
                }
                return false;
            },
            highlight:function(){
                this.$el;
               this.$el.previousElementSibling.classList.add('active');
               this.$el.previousElementSibling.previousElementSibling.classList.add('active');
               this.$el.previousElementSibling.previousElementSibling.previousElementSibling.classList.add('active');
            },
            update_role(employee,role,action){
                this.$emit('role_update', employee, role, action);
            },
            toggle:function(role,action){
                console.log(role,action);
            }
        },
        data:function(){
            return {
                expanded:false,
                authorities:[]
            }
        }


    });


    var vm = new Vue({
        el:"#container",
        data:{
            employees:[],
            grantable_roles:['admin','recruiter'],
            all_roles:['superadmin','admin','recruiter'],
            current_page:1,
            total_pages:0,
            first_page:1,
            role_search_expanded:false,
            name:'',
            email:'',
            role_search:[],
            last_action:'',
            last_action_target_name:'',
            last_action_target_id:'',
            last_action_role:''
        },
        computed:{
            search_query:function(){
                var spaceLoc = this.name.indexOf(' ');
                var firstname = spaceLoc > -1 ? this.name.substring(0,spaceLoc).trim() : this.name.trim();
                var lastname = this.name.substring(spaceLoc+1).trim();
                return{
                    firstname,
                    lastname,
                    email:vm.email,
                    roles:vm.role_search,
                    page:vm.current_page
                }
            },
            page_left_extended:function(){
                return this.current_page - 4 >= this.first_page;
            },
            page_right_extended:function(){
                return this.current_page + 4 <= this.total_pages;
            },
            page_lower_bound:function(){
                if(this.page_left_extended && this.page_right_extended){
                    return this.current_page - 2;
                }
                if(this.page_left_extended && !this.page_right_extended){
                    return this.current_page - (4 - (this.total_pages - this.current_page));
                }
                else{
                    return this.first_page;
                }
            },
            page_upper_bound:function(){
                if(this.page_left_extended && this.page_right_extended){
                    return this.current_page + 2;
                }
                if(!this.page_left_extended && this.page_right_extended){
                    return this.current_page + (4 - (this.current_page - this.first_page));
                }
                else{
                    return this.total_pages;
                }

            }

        },
        methods:{
            page_click:function(e){

                for(var index in vm.$refs.employee_drop_down){
                    if(!vm.$refs.employee_drop_down[index].$el.contains(e.target)){

                        vm.$refs.employee_drop_down[index].expanded = false;
                        vm.$refs.employee_drop_down[index].$el.previousElementSibling.classList.remove('active');
                        vm.$refs.employee_drop_down[index].$el.previousElementSibling.previousElementSibling.classList.remove('active');
                        vm.$refs.employee_drop_down[index].$el.previousElementSibling.previousElementSibling.previousElementSibling.classList.remove('active');
                    }
                }
                if(!document.getElementById('role-search-button').contains(e.target)){
                    this.role_search_expanded = false;
                }

            },
            query_change:function(){

                fetch('/admin/employee/search', {
                    credentials: 'include',
                    body:JSON.stringify(vm.search_query),
                    method:'POST',
                    headers:{
                        "Content-type":"application/json",
                        "X-CSRF-TOKEN":document.querySelector('meta[name=_csrf]').content
                    }

                })
                    .then(function (response) {
                        if (!response.ok) throw new Error(response.statusText);


                        return response.json();
                    }).then(function (json) {


                    vm.all_roles = json.allRoles;
                    vm.grantable_roles = json.grantableRoles;
                    vm.current_page = json.currentPage;

                    vm.employees = json.employees;
                    vm.total_pages = json.totalPages;
                }).catch(function (error) {
                    console.log('Looks like there was a problem: \n', error);
                })
            },
            remove_filter:function(filter){
                switch(filter){
                    case 'name':
                        vm.name = '';

                        break;
                    case 'email':
                        vm.email = '';
                        break;
                    default:
                        vm.role_search = vm.role_search.filter(e => e !== filter)
                        break;
                }
                this.query_change();
            },
            range:function (start, end) {
                return Array(end - start + 1).fill().map((_, idx) => start + idx)
            },
            role_update:function(employee, role,action){

                this.last_action_target_id = employee.id;
                this.last_action_target_name = employee.firstName+' '+employee.lastName;
                this.last_action_role = role;
                this.last_action = action;

                if(action == 'Grant'){
                    employee.authorities.push(role);
                }
                else if(action == 'Revoke') {
                    employee.authorities = employee.authorities.filter(e => e !== role);
                }
            },
            highlight(value,search_term,field){
                value = value.highlight(search_term);
                if(field != 'firstname') return value;
                return " <div class=\"ring-container\">\n" +
                    "                        <div class=\"ringring\"></div>\n" +
                    "                        <div class=\"circle\"></div>\n" +
                    "                    </div>" + value;

            }


        },
        created: function () {
            this.$nextTick(function () {
                vm.query_change();
            })


        }


    })



</script>
</body>
</html>
