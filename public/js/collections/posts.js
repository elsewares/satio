define([
'Underscore',
'Backbone',
'models/post'
], function(_, Backbone, Post){
  var postsCollection = Backbone.Collection.extend({
    model: Post,
    url: '/api/posts'
  });
  
  return postsCollection;
});