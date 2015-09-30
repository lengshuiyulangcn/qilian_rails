var app = angular.module('qilianCore', ['ngResource','ngRoute','mobile-angular-ui','Devise']);

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
app.config(function($routeProvider,$locationProvider) {
  $routeProvider

    .when('/', {
      templateUrl: 'template/home.html',
      controller: 'homeCtrl'      
    })
    .when('/courses/all', {
      templateUrl: 'template/courses.html',
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
    });
    $locationProvider.html5Mode({enabled: true});
 });

app.controller('homeCtrl', function($scope, $route, $routeParams) {  
});
app.controller('postCtrl', ['Post','$scope','$route','$routeParams',function(Post,$scope, $route, $routeParams) {  
  $scope.loading = true
  $scope.post = Post.show({id: $routeParams.id});
  $scope.post.$promise.then(function (result) {
    $scope.content = result.content;
  });
  $scope.loading = false
}]);

app.controller('courseCtrl', function($scope, $route, $routeParams) {
});


app.controller('mypageCtrl', ['Auth','$scope','$location',function(Auth,$scope, $location) {
  Auth.currentUser().then(function(user) {   
    $scope.name = user.name;
    console.log(user)
  }, 
  function(error) {
      $location.path("/users/sign_in");
    }); 
}]);
app.controller('sessionCtrl', ['Auth','$scope','$location',function(Auth,$scope, $location) {
 $scope.credentials = { login: '', password: '' };
 $scope.facebook_auth= function() {
  window.location = "/users/auth/facebook"
  // $location.path("/users/auth/facebook");
 }
 $scope.signIn = function() {
        Auth.login($scope.credentials).then(function(user) {
          $location.path("/");
          console.log(user)
          alert('Successfully signed in user!')
        }, function(error) {
          console.info('Error in authenticating user!');
          alert('Error in signing in user!');
        });
   }
}]);

app.controller('newsCtrl', ['Post','$scope','$route','$routeParams',function(Post,$scope, $route, $routeParams) {
  $scope.posts = Post.index();
  $scope.show_post = function(index){
  window.location = "/news/"+index
  }

}]);
app.filter('rawHtml', ['$sce', function($sce){
  return function(val) {
    return $sce.trustAsHtml(val);
  };
}]);

