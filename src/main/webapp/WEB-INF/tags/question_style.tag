<style>
    #question-container{
        height:100%;
        width:100%;
        top:0;
        left:0;
        position:fixed;
        display:flex;
        z-index:10;
        align-items:center;
        justify-content:center;
        font-family: 'Open Sans', sans-serif;
        background-color:rgba(0,0,0,.8);



    }
    #question-box{
        width:500px;
        height:300px;
        /*background-color:#b71c1c;*/
        background:linear-gradient(to right,#b71c1c,#ff1744 );
        z-index:10;
        display:flex;
        flex-direction:column;
        border-radius:3px;
        padding:15px 15px;
        position:relative;
        align-items:center;

    }
    #question-box span{
        text-align:center;
        margin-bottom:10px;
        color:#ff8a80;
    }
    #question-box textarea{
        flex:1;
        resize:none;
        background-color:#ffcdd2;
        padding:5px;
        border-color:#ff5252;
        border-color:#e57373;
        outline-color:#e57373;
        width:100%;
    }
    #question-box > svg{
        height:1.5em;
        width:1.5em;
        position:absolute;
        left:calc(100% - 1em);
        bottom:calc(100% - .75em);
        fill:currentColor;
        color:green;
    }
    #question-box > svg:hover{
        cursor:pointer;
    }
    button{
        margin-top:10px;
        margin-bottom:0 !important;
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
    [v-cloak]{ display:none !important }

</style>
