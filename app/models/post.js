define([
'Underscore',
'Backbone'
], function(_, Backbone){
  var Post = Backbone.Model.extend({
    defaults: {
      title: "Default Title",
      body: "Defaul Body"
    }
  });
  // You usually don't return a model instantiated
  return Post;
});