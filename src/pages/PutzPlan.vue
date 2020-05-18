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
 <q-list class="bg-white"
 separator
 bordered
 >
      <q-item
      v-for="(task, id) in tasks"
      :key="task.name"
      @click="task.status=!task.status"
      clickable
      v-ripple
      :class="{'done bg-blue-1' : task.status}"
      >


        <q-item-section avatar>
          <q-checkbox
          class="no-pointer-events"
          v-model="task.status"
          color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{task.name}}</q-item-label>
        </q-item-section>

        <q-item-section
        v-if="task.status"
        side
        >
         <q-btn
         @click.stop="deleteTask(task)"
         flat
         round
         dense
         color="primary"
         icon="delete" />
        </q-item-section>
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

 // const axios = require('axios');
export default {
  data() {
    return {
      newTask : '',
      tasks: [
        {
          id:'',
        name: '',
        status: false
        },
      ]
    }
  },
  methods: {
    deleteTask(task) {
      console.log(task.id)

      this.$q.dialog({
        title: 'Confirm',
        message: 'Delete?',
        cancel: true,
        persistent: true
      }).onOk(() => {
        this.tasks.splice(task.id, 1)
        this.$q.notify('Task.deleted')
        axios.delete('https://putzplan-admin.herokuapp.com/api/tasks/'+task.id, {
        });
      })
    },
    addTask() {

      axios.post('https://putzplan-admin.herokuapp.com/api/tasks', {
        name: this.newaTask,
        status: false
      })
        .then(function () {

          this.tasks.push({
            name: this.newTask,
            status: false
          })

        })
        .catch(function (error) {
          console.log(error);
        });

      this.newTask = ''
    //  console.log(response);

    }
  },

//https://putzplan-admin.herokuapp.com/api/tasks/6

  async created () {
    try {
      const res = await axios.get(`https://putzplan-admin.herokuapp.com/api/tasks`);
      this.tasks  = res.data;
      this.tasks = res.data["hydra:member"]
      console.log(this.tasks)
    }catch (e) {
      console.log(e)
    }
  }
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
</style>
