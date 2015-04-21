'use strict';

angular.module('MyApp') #your app name
.directive('facebookLogin', ['$rootScope', 'Facebook', 'MemberMgmt', ($rootScope, Facebook, MemberMgmt) -> #MemberMgmt is another homemade Service
    restrict: 'A'
    link: (scope, element, attrs) ->
      fbstatus = ''
      called = false

      if Facebook.isInit()
        Facebook.getLoginStatus()

      $(element).on 'click', (event) ->
        event.preventDefault()
        if scope.plane != ''
          if typeof scope.user == 'undefined'
            if fbstatus != 'connected'
              Facebook.login('email') #permissions
            else if fbstatus is 'connected'
              Facebook.getInfo()
          else
            scope.start() #Start function in your Controller

      scope.$on 'fb_Login_success', (event,response) ->
        Facebook.getInfo()

      scope.$on 'fb_infos', (event,response) ->
        user = response
        if !called
          called = true
          MemberMgmt.doSelectUser(user)

      scope.$on 'fb_statusChange', (event,response) ->
        fbstatus = response.status
  ]
)