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