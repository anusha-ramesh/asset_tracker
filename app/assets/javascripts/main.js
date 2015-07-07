$(document).ready(function() {
  var count = 0;
  $('.add-inventory').click(function(event)
  {
    var textDiv = $('.inventory-list:last').clone();
    textDiv = updateTextDiv(textDiv);
    textDiv.appendTo('.inventory:last');
  	return false;
  });

  $('.add-ptype').click(function(event)
  {
    var textDiv = $('.ptype:last').clone();
    textDiv = updateTextDiv(textDiv);
    textDiv.appendTo('.product-type:last');
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
    var getValue = $(this).val();
    var URL = 'products/get_user';

    $.ajax
    ({
      url: URL,
      data: {id:  getValue},
      success: function(data)
      {
        $('.ui-accordion-content-active').find($('.user-state')).html(data);
      }
    });
  })

  $('.input_datalist').autocomplete({
    minLength: 3,
    option: {enable: true},
    source: $('.input_datalist').data('autocomplete-source'),
    scroll: true,
    select: function( event, ui ) {
      $(this).val(ui.item.label);
      $('#user_id').val(ui.item.value);
      return false;
    },
    focus: function(event) {
      return false;
    }

  });

  
  $('.btn-green').click(function(event)
  {
    var pathname = window.location.pathname;
    var getEmail = $('.ui-accordion-content-active').find($('.input_datalist')).val();
    var getId = $('.ui-accordion-content-active').find($('.select_code')).val();
    var URL = 'products/update_user';
    $.ajax
    ({
      method: "PUT",
      url: URL,
      data: {id: getId, email: getEmail}
    });
    window.location = pathname;
  })

  $('.btn-green1').click(function(event)
  {
    var pathname = window.location.pathname;
    var getEmail = $('#currentUser_email').val();
    var getId = $('.ui-accordion-content-active').find($('.select_code')).val();
    var URL = 'products/update_user';
    $.ajax
    ({
      method: "PUT",
      url: URL,
      data: {id: getId, email: getEmail}
    });
    window.location = pathname;
  })

  $('.btn-red').click(function(event)
  {
    alert($('.ui-accordion-content-active').find($('.user-state')).text());
    var getId = $('.ui-accordion-content-active').find($('.select_code')).val();
    var getEmail = $('.ui-accordion-content-active').find($('.user-state')).text().replace('\n', '');
    getEmail = getEmail.replace('\n','');
    getEmail = $.trim(getEmail);
    alert(getEmail);
    var URL = 'products/user_asset_release';
    $.ajax
    ({
      url: URL,
      data: {id: getId, email: getEmail}
    });
  })

  $('.btn-green2').click(function(event)
  {
    var pathname = window.location.pathname;
    var getId = $('.ui-accordion-content-active').find($('.select_code')).val();
    var URL = 'products/'+getId;
    $.ajax
    ({
      method: "DELETE",
      url: URL,
      data: {id: getId}
    });
    window.location = pathname;
  })

  $('.btn-red1').click(function(event)
  {
    var pathname = window.location.pathname;
    var getId = $('.ui-accordion-content-active').find($('.select_code')).val();
    var URL = 'products/asset_to_shelf';
    $.ajax
    ({
      method: "PUT",
      url: URL,
      data: {id: getId}
    });
    window.location = pathname;
  })
    
  return false;
});

function updateTextDiv(textDiv) 
{
  var old_name = $(textDiv.children("input")[0]).attr("name");
  var result = /\[[\d]+\]/.exec(old_name).toString();
  var old_index = result.slice(1, -1);
  var new_index = (parseInt(old_index, 10) + 1).toString();
  var new_name = old_name.replace(old_index, new_index);
   $(textDiv.children("input")[0]).attr("name", new_name);
  return textDiv
}