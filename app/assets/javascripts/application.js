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
//= require flipclock.min


// GLOBAL VARIABLE FOR CLOCK
//This code catches all ajax calls and forces a page refresh
$(document).ready(function(){

  $(document).bind('ajaxSuccess', function(event, jqxhr, settings, exception){

    //alert("You have encountered an interesting event, please contact Sriram or Yew Siang to report this.");
    Turbolinks.visit(location.toString());

  }).bind('ajaxError', function(event, jqxhr, settings, exception){

    if ($(location).attr('pathname') === '/rank_participants') {

      alert("Either: The Bib number you tried to enter was not registered at the start of the Vertical Marathon \n OR \n Not all fields are filled up (i.e. name, rank or bib number) \n OR \n This rank is missing! Confirm with the rank chip giver if this rank has been cancelled.");

    } else {
      //alert("AJAX Error: Whatever you were saving was not saved.");
      //ok lo you want then can
      console.log("-----------");
      console.log(Date.now());
      console.log("AJAX ERROR: Error raised in xhr call");
      console.log("-----------");
      Turbolinks.visit(location.toString());
    }

  });


  // When the "enter" button is pressed and released, add a new entry to waves or ranks
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


  // Countdown clock in Participants for a particular wave
  var clock;
  clock = $('.clock').FlipClock((sessionStorage.getItem('start_time') || 60), {
        clockFace: 'MinuteCounter',
        countdown: true,
        autoStart: false,
        callbacks: {
          start: function() {
            $('.message').html('');
          },
          reset: function() {
            $('.message').html('Reset has been clicked');
          }
        }
    });

    $('.Start').click(function(e) {
      clock.start();
    });

    $('.Stop').click(function(e) {
      clock.stop();
    });

    $('.Reset').click(function(e) {
      clock.stop();
      clock.setTime((sessionStorage.getItem('start_time') || 60));
    });

  // Refresh the overview page once in a while

  if ($(location).attr('pathname') == '/overview') {
    setInterval(function() { window.location.reload(); }, 20000);
  }



});



