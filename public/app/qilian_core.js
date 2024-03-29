var app = angular.module('qilianCore', ['ngResource','ngRoute','mobile-angular-ui','Devise','rorymadden.date-dropdowns','flash']);

app.directive("fileUpload", [function () {
    return {
       templateUrl: 'template/directives/uploadImage.html',
        scope: false, 
        link: function (scope, element, attributes) {
            element.bind("change", function (changeEvent) {
                var reader = new FileReader();
                reader.onload = function (loadEvent) {
                    scope.$apply(function () {
                        scope.image_source = loadEvent.target.result;
                    });
                }
                reader.readAsDataURL(changeEvent.target.files[0]);
            });
        }
    }
}]);

app.controller('MainController', ['$location','$scope','Auth', '$window',function($location,$scope, Auth, $window) {
  Auth.currentUser().then(function(user) {
    $scope.user = user;
    $scope.gotoUserInfo= function(){
      $location.url('/users/'+$scope.user.id+"/edit"); 
    }
  })
  $scope.gotoMypage= function(){
    $location.url('/mypage'); 
  };
  $scope.gotoJob= function(){
    $window.location = '/jobs/search'; 
  };
  $scope.metadata = {
    'title': '七联就职资讯-有态度的资讯，左右职业人生|七联就职',
    'description': '七联就职资讯-有态度的资讯，左右职业人生',
  };
  $scope.$on('newPageLoaded', function(event, metadata) {
     $scope.metadata = metadata
    });
}]);

app.config(function($routeProvider,$locationProvider) {
  $routeProvider

    .when('/', {
      templateUrl: 'template/home.html',
      controller: 'homeCtrl'      
    })
    .when('/courses/all', {
      templateUrl: 'template/courses.html',
      controller: 'coursesCtrl'      
    })
    .when('/course/:id', {
      templateUrl: 'template/course.html',
      controller: 'courseCtrl'      
    })
    .when('/mypage', {
      templateUrl: 'template/mypage.html',
      controller: 'mypageCtrl'      
    })
    .when('/users/sign_in', {
      templateUrl: 'template/signin.html',
      controller: 'sessionCtrl'      
    })
    .when('/users/sign_up', {
      templateUrl: 'template/signup.html',
      controller: 'sessionCtrl'      
    })
    .when('/news', {
      templateUrl: 'template/info.html',
      controller: 'newsCtrl'      
    })
    .when('/news/:id', {
      templateUrl: 'template/detail.html',
      controller: 'postCtrl'      
    })
    .when('/events/list', {
      templateUrl: 'template/events.html',
      controller: 'eventsCtrl'      
    })
    .when('/event/:id', {
      templateUrl: 'template/event.html',
      controller: 'eventCtrl'      
    })
    .when('/users/:id/edit', {
      templateUrl: 'template/userinfo.html',
      controller: 'userinfoCtrl'      
    });

    $locationProvider.html5Mode({enabled: true}).hashPrefix('!');
 });

app.controller('homeCtrl', function($scope, $route, $routeParams) {  
});

app.controller('eventsCtrl',['$location','Event','$scope','$routeParams',function($location,Event,$scope, $routeParams) {  
  Event.list().then(function(data){
    $scope.events = data;
  });
  $scope.title = "精彩活动";  
  $scope.gotoEvent = function(id){
    $location.url('/event/'+id) 
  }
}]);

app.controller('eventCtrl', ['Auth','Flash','Event','$scope','$routeParams','$http',function(Auth,Flash,Event,$scope,$routeParams,$http) {
  console.log('here');
  $scope.event = Event.detail($routeParams.id).then(function(data){
    $scope.event = data;
    $scope.title = data.title;
    $scope.$emit('newPageLoaded', {'title': $scope.title, 'description': $scope.event.description });
  });
  $scope.apply = function(){
    Auth.currentUser().then(function(user) {
        $http({
        method: 'POST',
        url: '/event/apply.json',
        data: {event_id: $scope.event.id}
        }).then(function successCallback(response) {
          if (response.data.response=="ok"){
            Flash.create('success', '报名活动成功', 'custom-class');
          }
          else{
            Flash.create('danger', '请不要重复报名', 'custom-class');
          }
        }, 
        function errorCallback(response) {
          Flash.create('danger', '请不要重复报名', 'custom-class');
        });
      },
      function(){
        Flash.create('danger', '请先登录', 'custom-class');
        $location.path("/users/sign_in");
      }) 
  }
}]);


app.controller('postCtrl', ['Post','$scope','$route','$routeParams','$window',function(Post,$scope, $route, $routeParams,$window) {  
  $scope.history = "咨询";
  $scope.enableBack = true; 
  $scope.goBack = function(){
    $window.history.back();
  }
  $scope.post = Post.show({id: $routeParams.id});
  $scope.post.$promise.then(function (result) {
    $scope.title = $scope.post.title;
    $scope.content = result.content;
    $scope.wechat_pickup = result.image.url ? result.image.url : result.fakeimage;
    $scope.$emit('newPageLoaded', { 'title': $scope.title, 'description': $scope.post.description });
  });
}]);

app.controller('coursesCtrl', ['Course','$scope','$location',function(Course,$scope,$location) {
  var courses = Course.index();
  courses.$promise.then(function (result) {
  $scope.title = '七联课程';
  $scope.courses = result;
  });
  $scope.show_course = function(index){
  $location.path("/course/"+index);
  }
}]);

app.controller('courseCtrl', ['Flash','Course','$scope','$routeParams','$window','$location','Auth','$http',function(Flash,Course,$scope,$routeParams,$window,$location, Auth, $http) {  
  $scope.history = "课程";
  $scope.goBack = function(){
    $window.history.back();
  }
  $scope.apply = function(){
    Auth.currentUser().then(function(user) {
      $http({
      method: 'POST',
      url: '/entries',
      data: {course_id: $scope.course.id, user_id: user.id}
      }).then(function successCallback(response) {
        Flash.create('success', '报名成功', 'custom-class');
      }, 
      function errorCallback(response) {
        Flash.create('danger', '已经申请过此课程', 'custom-class');
      });      
    },
    function(){
      Flash.create('danger', '请先登录', 'custom-class');
      $location.path("/users/sign_in");
    })  
  }
  $scope.course = Course.show({id: $routeParams.id});
  $scope.course.$promise.then(function (result) {
    $scope.course = result;
  $scope.title = result.name; 
  });
}]);

app.controller('mypageCtrl', ['Auth','$scope','$location',function(Auth,$scope, $location) {
  Auth.currentUser().then(function(user) {   
    $scope.title = '我的主页';
    $scope.user = user;
  }, 
  function(error) {
      $location.path("/users/sign_in");
    }); 
}]);
app.controller('sessionCtrl', ['Flash','Auth','$scope','$location',function(Flash,Auth,$scope, $location) {
 $scope.credentials = { login: '', password: '' };
 $scope.title = '用户注册/登陆';
 $scope.facebook_auth= function() {
  window.location = "/users/auth/facebook"
  // $location.path("/users/auth/facebook");
 }
 $scope.signIn = function() {
        Auth.login($scope.credentials).then(function(user) {
          $location.path("/news");
        }, function(error) {
        Flash.create('danger', '请输入正确的用户名或者密码', 'custom-class');
        });
   }
}]);

app.controller('newsCtrl', ['Post','News','Category','$scope','$location',function(Post,News,Category,$scope,$location) {
  $scope.$emit('newPageLoaded', { 'title': '咨询一览', 'description': '七联咨询' });
  $scope.numberShow = 5;
  $scope.total_posts = Post.index(function(data){
    $scope.total_posts = data
    $scope.posts = $scope.total_posts.slice(0,$scope.numberShow);
  });
  $scope.readMore = function(){ 
    $scope.numberShow+=5 
    $scope.posts = $scope.total_posts.slice(0,$scope.numberShow);
  };
  $scope.categories = Category.index();
  $scope.title = '咨询一览';
  $scope.show_post = function(index){
  $location.path("/news/"+index);
  }
  $scope.postsInCategory = function(id,category) {
    News.getCategory(id).then(function(data) {
      $scope.numberShow = 5;
      $scope.total_posts = data;
      $scope.posts = $scope.total_posts.slice(0,$scope.numberShow);
      $scope.title = category;
    });
  };
}]);

app.controller('userinfoCtrl', ['Auth','User','$scope','$location',function(Auth,User,$scope, $location) {
  Auth.currentUser().then(function(user) {
  $scope.image_source = user.image.profile.url
  $scope.user = user;   
  $scope.title  = user.name;
  $scope.updateUserInfo = function() {
    $scope.user.image = $scope.image_source
    User.update({id:$scope.user.id, user: $scope.user})
  }
 })}

]);

app.directive('qilianHeader',['$route',function($route) {
  return {
    templateUrl: 'template/header.html',
    }
}]);
app.directive('qilianFooter', function() {
  return {
    templateUrl: 'template/footer.html',
  };
});

app.filter('rawHtml', ['$sce', function($sce){
  return function(val) {
    return $sce.trustAsHtml(val);
  };
}]);
app.run(function($rootScope, $templateCache) {
   $rootScope.$on('$viewContentLoaded', function() {
      $templateCache.removeAll();
   });
});

