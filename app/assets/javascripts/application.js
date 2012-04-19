// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.form
//= require_tree .
//= require bootstrap
//= require jquery.purr
//= require best_in_place
//= require autocomplete-rails
//= require jquery_nested_form
//= require jquery.zclip

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  
  jQuery(".jquery-form").ajaxForm({
    success: function(obj) {
      location.reload(true);
    },
    error: function(err) {
      var container = $("<span class='flash-error'></span>").html("oops, error...");
      container.purr();
    }}
  ); 

  var insertFields = window.nestedFormEvents.insertFields;
  window.nestedFormEvents.insertFields = function(content, assoc, link) {
    insertFields(content, assoc, link);
    $('.remove_nested_fields').addClass('btn btn-danger')
  }

  $('.popoverable').popover();

  $('.copyable').zclip({
    path:'/ZeroClipboard.swf',
    copy:function(){return $(this).text();}
  }).tooltip({
    title: 'Click to copy'
  });
});


