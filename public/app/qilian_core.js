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

app.controller('mypageCtrl', function($scope, $route, $routeParams) {
});

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

