<link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">

<div id="question-container" v-if="question_active">

    <div id="question-box">
        <template v-if="mode == 'ask'">
            <svg @click="question_active = false">
                <use xlink:href="resources/images/icons.svg#delete"></use>
            </svg>
            <span>Send a question to recruiting</span>
            <textarea v-model="question"></textarea>
            <button class="standard-button green" v-if="!loading" @click="submit_question">Send</button>
            <div v-else class="loader-container">
                <svg class="loader">
                    <use xlink:href="resources/images/icons.svg#loading"></use>
                </svg>
            </div>
        </template>
        <template v-else-if="mode == 'result'">
            <span>Your question was received!</span>
            <button class="standard-button green" @click="mode = 'ask'; question=''">Ask another question</button>
        </template>
        <template v-else>
            <span>Oops something went wrong. Please try again later.</span>
        </template>
    </div>

</div>


<script>
    question_vue = new Vue({
        el: '#question-vue',
        data: {
            question_active: false,
            mode: 'ask',
            loading: false,
            question: ''
        },
        methods: {
            submit_question() {
                var vm_q = this;
                vm_q.loading = true;
                fetch('/recruiting/question', {
                    credentials: 'include',
                    body: JSON.stringify({'question': this.question}),
                    method: 'POST',
                    headers: {
                        "Content-type": "application/json",
                        "X-CSRF-TOKEN": document.querySelector('meta[name=_csrf]').content
                    }

                })
                    .then(function (response) {
                        if (!response.ok) throw new Error(response.statusText);


                        return response.json();
                    }).then(function (json) {
                       vm_q.loading = false;
                       vm_q.mode = 'result';


                }).catch(function (error) {
                    console.log('Looks like there was a problem: \n', error);
                    vm_q.mode = 'error';
                })
            }
        }
    })
</script>