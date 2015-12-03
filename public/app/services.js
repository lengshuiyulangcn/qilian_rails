var app = angular.module('qilianCore');
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

app.factory("Event", function($http) {
  var list = function(){
    return $http.get('/events/list.json').then(function(response) {
      return response.data;
    });
  };
  var detail = function(id){
    return $http.get('/event/'+id+'.json').then(function(response) {
      return response.data;
    });
  };
  return{
    list: list,
    detail: detail 
  } 
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


