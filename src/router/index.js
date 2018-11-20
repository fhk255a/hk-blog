import Vue from 'vue'
import Router from 'vue-router'
import index_html from '@/pages/index/index_html'
import message_html from '@/pages/message/message_html'
import login_reg_html from '@/pages/login_reg/login_reg_html'
import add_article_html from '@/pages/add_article/push_article_html'
import article_info_html from '@/pages/article_info/article_info_html'
import personal_html from '@/pages/personal/personal_html'
import me_html from '@/pages/about/me'
import link_html from '@/pages/link/link_html'
import dev_html from '@/pages/develop_diary/index'
import devinfo_html from '@/pages/dev_page/dev_index'

Vue.use(Router)

export default new Router({
  mode:'hash',
  routes: [
    {
      path: '/',
      name: 'main',
      component: index_html
    },
    {
      path: '/message',
      name: 'message',
      component: message_html
    },
    {
      path: '/login',
      name: 'login_page',
      component:  login_reg_html
    },
    {
      path: '/add_article',
      name: 'article_page',
      component: add_article_html
    },
    {
      path: '/article/:id',
      name: 'article_page',
      component: article_info_html
    },
    {
      path: '/personal/id=:id',
      name: 'personal_page',
      component: personal_html
    },
    {
      path: '/about',
      name: 'me',
      component: me_html
    },
    {
      path: '/link',
      name: 'link',
      component: link_html
    },
    {
      path: '/dev_date',
      name: 'dev_html',
      component: dev_html
    },
    {
      path: '/devinfo/:id',
      name: 'devinfo',
      component: devinfo_html
    }
  ]
})
