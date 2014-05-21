// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.draggable
//= require jquery.ui.droppable
//= require turbolinks
//= require_self
//= require_tree .

// Send a request to the 'modules' controller to get a module HTML content
var render_module = function(moduleName, locals, callback){
  $.ajax("/modules/" + moduleName, {
    type: "POST",
    data: {locals: locals},
    dataType: "html",
    success: function(data, textStatus, jqXHR){
      callback(data);
    }
  });
}
