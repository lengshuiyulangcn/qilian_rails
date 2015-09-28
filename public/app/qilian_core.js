var app = angular.module('qilianCore', ['ngResource','ngRoute','mobile-angular-ui']);

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
app.config(function($routeProvider) {
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
    .when('/news/:id', {
      templateUrl: 'template/detail.html',
      controller: 'postCtrl'      
    })

    .when('/news', {
      templateUrl: 'template/info.html',
      controller: 'newsCtrl'      
    });
 }); app.controller('homeCtrl', function($scope, $route, $routeParams) {  
});
app.controller('postCtrl', function($scope, $route, $routeParams) {  
});

app.controller('courseCtrl', function($scope, $route, $routeParams) {
});

app.controller('mypageCtrl', function($scope, $route, $routeParams) {
});

app.controller('newsCtrl', ['Post','$scope','$route','$routeParams',function(Post,$scope, $route, $routeParams) {
  $scope.posts = Post.index();
  console.log($scope.posts)
}]);

