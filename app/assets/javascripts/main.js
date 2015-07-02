$(document).ready(function() {
  var count = 0;

  $('.add-inventory').click(function(event)
  {
    var textDiv = $('.inventory-list:last').clone();
    textDiv = updateTextDiv(textDiv);
    textDiv.appendTo('.inventory:last');
  	return false;
 });

  var preview = $(".add-image img");
  $(".image").change(function(event)
  {
    var input = $(event.currentTarget);
    var file = input[0].files[0];
    var reader = new FileReader();
    reader.onload = function(e){
      image_base64 = e.target.result;
      preview.attr("src", image_base64);
    };
    reader.readAsDataURL(file);
  });

  $('#logout').click(function(event)
  {
    var url = "/users/sign_out";
    window.location = url;
  });
   
  var accordion = $( "#asset_list" ).accordion({
    header : '.asset_list_row', 
    active :true, 
    collapsible: true,
    activate: function( event, ui ) {
      
    },
    beforeActivate: function( event, ui ) {

      console.log(ui);
      ui.newHeader.hide();
      ui.oldHeader.show();
    },
    animate :false
  });
   
  $('.arrow_div_up').click(function(event)
  {
    $('.ui-accordion-header').show();
    accordion.accordion( "option", "active",  false );
  });

  $('.select_code').change(function()
  {
    // var x = $('.ui-accordion-content-active');

    var getValue = $(this).val();
    // alert(getValue);
    var URL = 'products/get_user';

    $.ajax
    ({
      url: URL,
      data: {id:  getValue},
      success: function(data)
      {

        $('.ui-accordion-content-active').find($('.user-state')).html("");
        $('.ui-accordion-content-active').find($('.user-state')).html(data);
        // $('.ui-accordion-content-active').show();
        // return false;
      }
    }); 
  })
  return false;
});

function updateTextDiv(textDiv) {
  var old_name = $(textDiv.children("input")[0]).attr("name");
  var result = /\[[\d]+\]/.exec(old_name).toString();
  var old_index = result.slice(1, -1);
  var new_index = (parseInt(old_index, 10) + 1).toString();
  var new_name = old_name.replace(old_index, new_index);
   $(textDiv.children("input")[0]).attr("name", new_name);
  return textDiv
}