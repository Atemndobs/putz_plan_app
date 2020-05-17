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
      v-for="(task, index) in tasks"
      :key="task.title"
      @click="task.done=!task.done"
      clickable
      v-ripple
      :class="{'done bg-blue-1' : task.done}"
      >

    
        <q-item-section avatar>
          <q-checkbox 
          class="no-pointer-events"
          v-model="task.done" 
          color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{task.title}}</q-item-label>
        </q-item-section>

        <q-item-section
        v-if="task.done"
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
export default {
  data() {
    return {
      newTask : '',
      tasks: [
        {
        title: 'Start Work',
        done: false
        },
                {
        title: 'Prep Exams',
        done: false
        },
                {
        title: 'Be Happy',
        done: true
        }
      ]
    }
  },
  methods: {
    deleteTask(index) {
         
      this.$q.dialog({
        title: 'Confirm',
        message: 'Delet?',
        cancel: true,
        persistent: true
      }).onOk(() => {
         this.tasks.splice(index, 1)
         this.$q.notify('Task.deleted')
      })

    
    },
    addTask() {
      this.tasks.push({
        title: this.newTask,
        done: false
      })
      this.newTask = ''
      
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