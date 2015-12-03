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
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery-tablesorter/jquery.tablesorter
//= require jquery-tablesorter/jquery.tablesorter.widgets
//= require bootstrap-datepicker
//= require_tree .
//= require jquery.inputmask
//= require jquery.inputmask.extensions
//= require jquery.inputmask.numeric.extensions
//= require jquery.inputmask.date.extensions

$(document).ready(function() {
  $('i').tooltip();
});

(jQuery, window, document), $(function() {
  $('a[href="#toggle-search"], .search-box .input-group-btn > .btn[type="reset"]').on("click",
    function(e) {
      e.preventDefault(), $(".search-box .input-group > input").val(""),
      $(".search-box").toggleClass("open"),
      $('a[href="#toggle-search"]').closest("li").toggleClass("active"),
      $(".search-box").hasClass("open") && setTimeout(function() {
        $(".search-box .form-control").focus()
      }, 100)
    })
});



