$(document).ready(function() {
  var count = 0;
  $('.add-inventory').click(function(event){
  // $(".inventory").on("click",".add-inventory",function(event) {
  	// var parentNode = event.target.parentNode;
  	// var textDiv = parentNode.cloneNode(true);
    var textDiv = $('.inventory-list:last').clone();
    // var old_name = textDiv.getAttribute('name');
    // console.log(old_name);
    textDiv = updateTextDiv(textDiv);
    textDiv.appendTo('.inventory:last');
  	// document.getElementsByClassName("inventory-list")[0].appendChild(textDiv);

  	return false;
 });

  var preview = $(".add-image img");

    $(".image").change(function(event){
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
  
  // $('.arrow_div_down').click(function(event)
  // { 
  //   alert("Clicked");
  //  $('.ui-accordion-header-active').hide();
    
  //   // alert(event.target);

  //   //$(function() 
  //   //{ 
  //     //$( "#asset_list" ).accordion({header : '.asset_list_row', active :true});
  //     // $('.asset_list_row ui-accordion-header').show();
  //     // $('.ui-accordion-header-active').hide();
  //   //});
  // });

  $('.arrow_div_up').click(function(event)
  {
    // $(function() 
    // { 
      // $('.ui-accordion-header-active').show('slow');
      //$( "#asset_list" ).accordion({header : '.asset_assign', collapsible :true, active: false});
    // });
    $('.ui-accordion-header').show();
    // $( "#asset_list" ).accordion({ active: false });
   
    accordion.accordion( "option", "active",  false );
  });

  // function get_user(value)
  // {
  //   cosole.log("............");
  // }
 $('.select_code').change(function()
  {
    var getValue=$(this).val();
    alert(getValue);
    var URL = 'products/get_user'
    $.ajax
    ({
       url: URL,
       data: {id:  getValue}
       // success: function(result)
       // {
          
       //    console.log("............");
       // }
    }); 

  })
// $("#search").autocomplete({
//     source: availableTags,
//     messages: {
//         noResults: '',
//         results: function() {
          
//         }
//     }
// });

// $('.search-query').bind('railsAutocomplete.select', function(event, data) {
//   $('.search-me').trigger('click')
//   });
 // $('.arrow_div_down').click(function(event){
    //   if($('.asset_assign').css('display') == 'none')
    //   {
    //     $('.asset_list_row').css('display','none');
    //     $('.asset_assign').css('display','table-row');
    //     $('.asset_assign').show('slow');
    //   }
    //   // else
    // //   {
    // //     $('.asset_assign').css('display','none');
    // //     $('.asset_list_row').css('display','table-row');
    // //     $('.asset_list_row').show('slow');
    // //   }
    //   });
    // $('.arrow_div_up').click(function(event){
    //   if($('.asset_list_row').css('display') == 'none')
    //   {
    //     $('.asset_assign').css('display','none');
    //     $('.asset_list_row').css('display','table-row');
    //     $('.asset_list_row').show('slow');
    //   }
    // });
    // $('.list').click(function(event){
    //   if($('.asset-view').css('display') == 'none' && count == 0)
    //   { 
    //     count ++;
    //     $(this).closest('tr').find('td').fadeOut('fast', function(here)
    //     { 
    //      $(here).parents('tr:first').remove();                    
    //     });
    //     $('.asset-view').css('display','inline-flex');
    //     $('.asset-view').show('fast');
    //   }
    //   else
    //   {
    //     $('.asset-view').hide('fast');
    //     count = 0;
    //   }
    // });
    //$('#accordion').accordion();

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