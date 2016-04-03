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
//= require bootstrap-sprockets

var ready;
ready = function () {

    $('#query').bind("change input paste", function(){
        var val = $(this).val();
        $.get( "/search_suggestions?query="+val, function(data) {
            $('#results').empty();
            $('#results').show();
            $.each(data, function(index, result) {
                if (index < 10){
                    $('#results').append("<li><a href=/products/"+result.id+">"+result.title+"</a></li>");
                }
            });
            if (typeof (val) == 'undefined' || val == null || val == "" || data == "") {
                $('#results').hide();
            }
        });
    });

    $(".delete-line-item").click(function(){
      var currentLineItem = $(this).parents("tr")[0];
      var lineItemsCountElement = $("#line-items-count")
      var lineItemsCount = parseInt($(lineItemsCountElement).text());
      var lineItemPrice = parseFloat($(currentLineItem).children().last().prev().children().attr("data-line-item-price"));
      var lineItemQuantityElement = $(currentLineItem).children().next().next().next()[0];
      var lineItemQuantity = parseInt($(lineItemQuantityElement).text());
      var totalPriceElement = $("#total_price");
      var totalPrice = parseFloat($(totalPriceElement).text());
      totalPrice -= (lineItemPrice*lineItemQuantity);
      $.ajax({
        url: "/line_items/" + $(currentLineItem).attr("data-line-item-id"),
        type: "POST",
        data: { _method: "DELETE" },
        success: function(result){
          $(currentLineItem).fadeOut(200);
          $(totalPriceElement).text(totalPrice);
          $(lineItemsCountElement).text(lineItemsCount - 1);
          console.log(result);
        }
      });
    });

    $(".decrease-line-item").click(function(){
      var currentLineItem = $(this).parents("tr")[0];
      var lineItemsCountElement = $("#line-items-count")
      var lineItemsCount = parseInt($(lineItemsCountElement).text());
      var lineItemQuantityElement = $(currentLineItem).children().next().next().next()[0];
      var lineItemQuantity = parseInt($(lineItemQuantityElement).text());
      var lineItemPrice = parseFloat($(currentLineItem).children().last().prev().children().attr("data-line-item-price"));
      var totalPriceElement = $("#total_price");
      var totalPrice = parseFloat($(totalPriceElement).text());
      totalPrice = (totalPrice - lineItemPrice);
      $.ajax({
        url: "/line_items/decrease_quantity?line_item=" + $(currentLineItem).attr("data-line-item-id"),
        type: "POST",
        success: function(result){
          if (lineItemQuantity > 1) {
            $(lineItemQuantityElement).text(lineItemQuantity-1);
          }
          else{
            $(currentLineItem).fadeOut(200);
            $(lineItemsCountElement).text(lineItemsCount - 1);
          };
          $(totalPriceElement).text(totalPrice);
          console.log(result);
        }
      })
    });

    $(".increase-line-item").click(function(){
      var currentLineItem = $(this).parents("tr")[0];
      var lineItemQuantityElement = $(currentLineItem).children().next().next().next()[0];
      var lineItemQuantity = parseInt($(lineItemQuantityElement).text());
      var lineItemPrice = parseFloat($(currentLineItem).children().last().prev().children().attr("data-line-item-price"));
      var totalPriceElement = $("#total_price");
      var totalPrice = parseFloat($(totalPriceElement).text());
      totalPrice = (totalPrice + lineItemPrice);
      $.ajax({
        url: "/line_items/increase_quantity?line_item=" + $(currentLineItem).attr("data-line-item-id"),
        type: "POST",
        success: function(result){
          $(lineItemQuantityElement).text(lineItemQuantity+1);
          $(totalPriceElement).text(totalPrice);
          console.log(result);
        }
      })
    });

};

$(document).ready(ready);
$(document).on('page:load', ready);
