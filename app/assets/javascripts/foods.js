// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//$(function() {
//    $( "#search_food_text_field" ).catcomplete({
//        source: $('#search_food_text_field').data('autocomplete-source')
//    });
// });
// 


$.widget( "custom.catcomplete", $.ui.autocomplete, {
    _renderMenu: function( ul, items ) {
      var that = this,
        currentType = "";
      $.each( items, function( index, item ) {
        if ( item.type != currentType ) {
          ul.append( "<li class='ui-autocomplete-type'>" + item.type + "</li>" );
          currentType = item.type;
        }
        that._renderItem( ul, item );
      });
    }
  });

$(function() {

    // toggle 'new food text field
    $('.search-form-block').hide()

    $('.new-food-button').hover(function(e){
        e.preventDefault();
        $(this).parent().parent().prev('tr').children().show(100);
    });

    $( ".auto-complete" ).catcomplete({
       source: $(".auto-complete").data('catcomplete-source')
    });
});
