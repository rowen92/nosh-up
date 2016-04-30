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
//= require jquery.inputmask
//= require jquery.inputmask.extensions
//= require jquery.inputmask.numeric.extensions
//= require jquery.inputmask.date.extensions

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

    function doAjaxStuff(){
      var currentLineItem = $(this).parents("tr")[0];
      var lineItemsCountElement = $("#line-items-count")
      var lineItemsCount = parseInt($(lineItemsCountElement).text());
      var lineItemQuantityElement = $(currentLineItem).children().next().next().next()[0];
      var lineItemQuantity = parseInt($(lineItemQuantityElement).text());
      var lineItemPrice = parseFloat($(currentLineItem).children().last().prev().children().attr("data-line-item-price"));
      var totalPriceElement = $("#total_price");
      var totalPrice = parseFloat($(totalPriceElement).text());
      if ($(this).hasClass("increase-line-item")){
        $.ajax({
          url: "/line_items/increase_quantity?line_item=" + $(currentLineItem).attr("data-line-item-id"),
          type: "POST",
          success: function(result){
            totalPrice = (totalPrice + lineItemPrice);
            $(lineItemQuantityElement).text(lineItemQuantity+1);
            $(totalPriceElement).text(totalPrice);
            console.log(result);
          }
        })
      }
      else if ($(this).hasClass("decrease-line-item")){
        $.ajax({
          url: "/line_items/decrease_quantity?line_item=" + $(currentLineItem).attr("data-line-item-id"),
          type: "POST",
          success: function(result){
            totalPrice = (totalPrice - lineItemPrice);
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
      }
      else if ($(this).hasClass("delete-line-item")){
        $.ajax({
          url: "/line_items/" + $(currentLineItem).attr("data-line-item-id"),
          type: "POST",
          data: { _method: "DELETE" },
          success: function(result){
            totalPrice -= (lineItemPrice*lineItemQuantity);
            $(currentLineItem).fadeOut(200);
            $(totalPriceElement).text(totalPrice);
            $(lineItemsCountElement).text(lineItemsCount - 1);
            console.log(result);
          }
        });
      }
    };

    $(".increase-line-item, .decrease-line-item, .delete-line-item").on("click", doAjaxStuff);

    $(".sub > a").click(function() {
      var ul = $(this).next(),
                clone = ul.clone().css({"height":"auto"}).appendTo(".sidebar"),
                height = ul.css("height") === "0px" ? ul[0].scrollHeight + "px" : "0px";
      clone.remove();
      ul.animate({"height":height});
      return false;
    });

    $("#phone").inputmask("+38(099)999-99-99");

};

$(document).ready(ready);
$(document).on('page:load', ready);
