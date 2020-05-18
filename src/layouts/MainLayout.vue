<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="leftDrawerOpen = !leftDrawerOpen"
        />

<!--        <q-toolbar-title>
          <q-btn
            to="/"
            round
            color="primary"
            icon="home"
            side
             />
        </q-toolbar-title>-->


      </q-toolbar>
      <div class="q-px-lg q-pt-xl  q-mb-md">
        <div class="text-h4">PutzPlan</div>
        <div class="text-subtitle">{{todaysDate}}</div>
      </div>
      <q-img
      src="statics/africa.jpg"
      class="header-image absolute-top"
      />
    </q-header>

<q-drawer
        v-model="leftDrawerOpen"
        show-if-above
        :width="250"
        :breakpoint="600"
      >
        <q-scroll-area style="height: calc(100% - 175px); margin-top: 175px; border-right: 1px solid #ddd">
          <q-list padding>
            <q-item
            to="/"
            exact
            clickable
            v-ripple>
              <q-item-section avatar>
                <q-icon name="list" />
              </q-item-section>

              <q-item-section>
                Putz Plan
              </q-item-section>
            </q-item>

            <q-item
            to="/help"
            clickable
            v-ripple>
              <q-item-section avatar>
                <q-icon name="help" />
              </q-item-section>

              <q-item-section>
                Help
              </q-item-section>
            </q-item>



          </q-list>
        </q-scroll-area>

        <q-img class="absolute-top" src="statics/africa.jpg" style="height: 175px">
          <div class="absolute-bottom bg-transparent">
            <q-avatar size="56px" class="q-mb-sm">
              <img src="/statics/avat_atem.png">
            </q-avatar>
            <div class="text-weight-bold">Bertrand Atemkeng</div>
            <div>@Atemkeng5</div>
          </div>
        </q-img>
      </q-drawer>


    <q-page-container>
      <keep-alive>
      <router-view />
      </keep-alive>

    </q-page-container>
  </q-layout>
</template>

<script>
import { date } from 'quasar'

export default {
  name: 'MainLayout',

  data () {
    return {
      leftDrawerOpen: false,
    }
  },
  computed: {
    todaysDate(){
     let timeStamp = Date.now()
    let formattedString = date.formatDate(timeStamp, 'dddd-MMM-YYYY:HH:mm.ss')
    return formattedString;
    }
  },
}
</script>

<style lang="scss">
.header-image {
  height: 100%;
  z-index: -1;
  opacity: 0.2;
  filter: grayscale(100%);
}
</style>
