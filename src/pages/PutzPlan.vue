<template>
  <q-page class="bg-grey-3 column ">
    <div class="row q-pa-sm bg-primary">
            <q-input
            v-model="newTask"
            @keyup.enter="addTask"
            class="col"
            square

            filled
            bg-color="white"
            placeholder="Add Task"
            dense
            >

        <template v-slot:append>
          <q-btn
          @click="addTask"
          round
          dense
          flat
          icon="add" />
        </template>
      </q-input>
    </div>

    <div class="loading-element loading" id="loading-element">
      <img src="../statics/spinner.svg"  alt=""/>
    </div>

 <q-list class="bg-white"
         separator
         bordered
 >

   <q-item
      v-for="(task, index) in tasks"
      :key="task.name"
      @click="updateTask(task)"
      clickable
      v-ripple
      :class="{'done bg-blue-1' : task.status}"
      >

     <q-slide-item
       @left="onLeft"
       @right="onRight"
     >

       <template v-slot:left>
         <div class="row items-center">
           <q-icon left name="done" /> Left
         </div>
       </template>
       <template v-slot:right>
         <div class="row items-center">
           Right content.. long <q-icon right name="alarm" />
         </div>
       </template>
<!--- Slide Section  --->
       <q-item bordered>
         <q-item-section avatar>
           <q-checkbox
             class="no-pointer-events"
             v-model="task.status"
             color="primary" />
         </q-item-section>

<!--         <q-item-section avatar>
           <q-avatar>
             <img src="https://cdn.quasar.dev/img/avatar4.jpg" draggable="false">
           </q-avatar>
         </q-item-section>-->

         <q-item-section >
           <q-item-label>{{task.name}}</q-item-label>
         </q-item-section>

         <q-item-section
           v-if="task.status"
           side
         >
           <q-btn
             @click.stop="deleteTask(index)"
             flat
             round
             dense
             color="primary"
             icon="delete" />
         </q-item-section>
       </q-item>
       <!--- Slide Section  --->
   </q-slide-item>


   </q-item>





    </q-list>
    <div
    v-if="!tasks.length"
    class="no-tasks absolute-center">
      <q-icon
      name="check"
      size="100px"
      color="primary"
      />
      <div class="text-h5 text-primary text-center">
        No Tasks
      </div>
    </div>

  </q-page>
</template>

<script>
  import axios from "axios"

export default {
  data() {
    return {
      newTask : '',
      tasks: [],
      info: null
    }
  },
  methods: {
    deleteTask(index) {
      let task = this.tasks[index]
      this.$q.dialog({
        title: 'Confirm',
        message: 'Delete?',
        cancel: true,
        persistent: true
      }).onOk(() => {
        this.tasks.splice(index, 1)
        this.$q.notify('Task.deleted')
        axios.delete(`https://putzplan-admin.herokuapp.com/api/tasks/${task.id}`);
      })
    },
    addTask() {

      let task =  {
        name: this.newTask,
        status: false
      };

      if (task.name !== ''){
        axios.post('https://putzplan-admin.herokuapp.com/api/tasks', task)
          .then(function (response) {
            //
          })
          .catch(function (error) {
            console.log(error);
          });

        this.tasks.push({
          name: this.newTask,
          status: false
        })
      }
      this.newTask = ''
    },

    updateTask(task){
      task.status=!task.status
        axios.put(`https://putzplan-admin.herokuapp.com/api/tasks/${task.id}`, {
          status: task.status
        }).then(function (response) {
          console.log(response.status)
        }).catch(function (error) {
          console.log(error);
        });
      if (task.status === true){
        this.showNotif(task)
        //this.triggerPositive(task)
      }
    },


    showNotif (task) {
      this.$q.notify({
        message: 'You just completed:' + task.name,
        color: 'purple',
        //avatar: 'https://cdn.quasar.dev/img/boy-avatar.png'
        avatar: "/statics/avat_atem.png",
       // type: 'positive',
      })
    },
    triggerPositive (task) {
      this.$q.notify({
        type: 'positive',
        message: 'You just completed:' + task.name,
      })
    },

    startLoading(){
      let loadingElement = document.getElementById("loading-element");
      loadingElement.classList.add('loading')
    },

    stopLoading(){
      let loadingElement = document.getElementById("loading-element");
      loadingElement.classList.remove('loading')

      //console.log(loadingElement.classList.remove('loading-element'))
    },

    onLeft ({ reset }) {
      this.$q.notify('Left action triggered. Resetting in 1 second.')
      this.finalize(reset)
    },

    onRight ({ reset }) {
      this.$q.notify('Right action triggered. Resetting in 1 second.')
      this.finalize(reset)
    },

    finalize (reset) {
      this.timer = setTimeout(() => {
        reset()
      }, 1000)
    }
  },

  beforeDestroy () {
    clearTimeout(this.timer)
  },

  async created () {

    try {
      const res = await axios.get(`https://putzplan-admin.herokuapp.com/api/tasks`);
      this.tasks  = res.data;
      this.tasks = res.data["hydra:member"]
      this.stopLoading();
    }catch (e) {
   this.stopLoading()
    }
  },

}
</script>

<style lang="scss">
.done {
  .q-item__label {
     text-decoration: line-through;
     color: #bbb;
  }
}
  .no-tasks {
    opacity: 0.5;
  }

.loading-element {
  width: 100px;
  height: 100px;
  margin: 0 auto;
  display: none;
  &.loading {
  display: block;
  }

}

</style>
