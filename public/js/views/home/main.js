define([
  'jQuery',
  'Underscore',
  'Backbone',
  'text!templates/home/main.html'
  ], function($, _, Backbone, mainHomeTemplate){
    var mainHomeView = Backbone.View.extend({
      // Instead of generating a new element, bind to the existing skeleton of
      // the App already present in the HTML.
      el: $("#main-container"),

      // Our template for the line of statistics at the bottom of the app.
      mainHomeTemplate: _.template(mainHomeTemplate),

      // ...events, initialize() etc. can be seen in the complete file

      // Re-rendering the App just means refreshing the statistics -- the rest
      // of the app doesn't change.
      render: function() {
        $(this.el).html(this.mainHomeTemplate);
      }
    });
    return new mainHomeView;
});