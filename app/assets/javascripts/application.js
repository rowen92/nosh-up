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

    $(".delete_line_item").click(function(){
      var current_line_item = $(this).parents("tr")[0];
      var line_item_price = parseFloat($(current_line_item).children().last().prev().children().attr("data-line-item-price"));
      var $total_price_element = $("#total_price")
      var total_price = parseFloat($total_price_element.text());
      total_price = total_price - line_item_price;

      console.log(line_item_price);
      console.log(total_price);

      if(confirm("Убрать из корзины?")){
        $.ajax({
          url: "/line_items/" + $(current_line_item).attr("data-line-item-id"),
          type: "POST",
          data: { _method: "DELETE" },
          success: function(result){
            $(current_line_item).fadeOut(200);
            $total_price_element.text(total_price);
            console.log(result)
          }
        });
      };
    });

};

$(document).ready(ready);
$(document).on('page:load', ready);
