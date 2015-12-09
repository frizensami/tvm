// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require bootstrap-sprockets

//This code catches all ajax calls and forces a page refresh
$(document).ready(function(){

  $(document).bind('ajaxSuccess', function(event, jqxhr, settings, exception){

    //alert("You have encountered an interesting event, please contact Sriram or Yew Siang to report this.");
    Turbolinks.visit(location.toString());

  }).bind('ajaxError', function(event, jqxhr, settings, exception){
  	alert("AJAX Error: Whatever you were saving was not saved.")
  	//ok lo you want then can
    //Turbolinks.visit(location.toString());

  });


  $(document).keyup(function(event) {

  	var pathname = $(location).attr('pathname');

  	if (event.keyCode === 187) {
  		if (pathname === '/waves') {
	  		$.ajax({url: "/waves/auto", success: function(result){
		        Turbolinks.visit(location.toString());
		    }});
  		} else if (pathname === '/ranks') {
  			$.ajax({url: "/ranks/auto", success: function(result){
		        Turbolinks.visit(location.toString());
		    }});
  		}
  	}
  });

});



