var app = angular.module('qilianCore', ['ngResource','ngRoute','mobile-angular-ui','Devise','rorymadden.date-dropdowns']);
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
app.factory("Post", function($resource) {
  return $resource("/admin/posts/:id.json", { id: "@id" },
    {
      'create':  { method: 'POST' },
      'index':   { method: 'GET', isArray: true },
      'show':    { method: 'GET', isArray: false },
      'update':  { method: 'PUT' },
      'destroy': { method: 'DELETE' }
    }
  );
});

app.factory("User", function($resource) {
  return $resource("/users/:id.json", { id: "@id" },
    {
      'update':  { method: 'PUT' },
    }
  );
});

app.factory("Category", function($resource) {
  return $resource("/admin/categories/:id.json", { id: "@id" },
    {
      'index':   { method: 'GET', isArray: true },
    }
  );
});
app.factory("Course", function($resource) {
  return $resource("/admin/courses/:id.json", { id: "@id" },
    {
      'index':   { method: 'GET', isArray: true },
      'show':    { method: 'GET', isArray: false },
    }
  );
});

app.factory('News', function($http) {
  var getCategory = function(id) {
    return $http.get('/news/category/'+id+'.json').then(function(response) {
      return response.data;
    });
  };
  return {
    getCategory: getCategory
  };
});

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
    .when('/users/:id/edit', {
      templateUrl: 'template/userinfo.html',
      controller: 'userinfoCtrl'      
    });

    $locationProvider.html5Mode({enabled: true}).hashPrefix('!');
 });

app.controller('homeCtrl', function($scope, $route, $routeParams) {  
});
app.controller('postCtrl', ['Post','$scope','$route','$routeParams','$window',function(Post,$scope, $route, $routeParams,$window) {  
  $scope.loading = true;
  $scope.history = "咨询";
  $scope.enableBack = true; 
  $scope.goBack = function(){
    $window.history.back();
  }
  $scope.post = Post.show({id: $routeParams.id});
  $scope.post.$promise.then(function (result) {
    $scope.title = $scope.post.title;
    $scope.content = result.content;
  });
  $scope.loading = false
}]);

app.controller('coursesCtrl', ['Course','$scope','$location',function(Course,$scope,$location) {
  var courses = Course.index();
  courses.$promise.then(function (result) {
  $scope.title = '七联课程';
  $scope.courses = result;
  console.log($scope.courses)
  });
  $scope.show_course = function(index){
  $location.path("/course/"+index);
  }
}]);

app.controller('courseCtrl', ['Course','$scope','$routeParams','$window',function(Course,$scope,$routeParams,$window) {  
  $scope.history = "课程";
  $scope.enableBack = true; 
  $scope.goBack = function(){
    $window.history.back();
  }
  $scope.course = Course.show({id: $routeParams.id});
  $scope.course.$promise.then(function (result) {
    $scope.course = result;
  $scope.title = result.name; 
    console.log($scope.couse)
  });
}]);

app.controller('mypageCtrl', ['Auth','$scope','$location',function(Auth,$scope, $location) {
  Auth.currentUser().then(function(user) {   
    $scope.title = '我的主页';
    $scope.user = user;
    console.log(user);
  }, 
  function(error) {
      $location.path("/users/sign_in");
    }); 
}]);
app.controller('sessionCtrl', ['Auth','$scope','$location',function(Auth,$scope, $location) {
 $scope.credentials = { login: '', password: '' };
 $scope.title = '用户注册/登陆';
 $scope.facebook_auth= function() {
  window.location = "/users/auth/facebook"
  // $location.path("/users/auth/facebook");
 }
 $scope.signIn = function() {
        Auth.login($scope.credentials).then(function(user) {
          $location.path("/");
          alert('Successfully signed in user!')
        }, function(error) {
          console.info('Error in authenticating user!');
          alert('Error in signing in user!');
        });
   }
}]);

app.controller('newsCtrl', ['Post','News','Category','$scope','$location',function(Post,News,Category,$scope,$location) {
  $scope.numberShow = 5;
  $scope.total_posts = Post.index(function(data){
    $scope.total_posts = data
    $scope.posts = $scope.total_posts.slice(0,$scope.numberShow);
  });
  $scope.readMore = function(){ 
    $scope.numberShow+=5 
    $scope.posts = $scope.total_posts.slice(0,$scope.numberShow);
  };
  console.log($scope.posts)
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

app.directive('qilianHeader',['$route','Auth',function($route,Auth) {
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

