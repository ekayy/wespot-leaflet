$.Isotope.prototype._getCenteredMasonryColumns = function() {
    this.width = this.element.width();

    var parentWidth = this.element.parent().width();

                  // i.e. options.masonry && options.masonry.columnWidth
    var colW = this.options.masonry && this.options.masonry.columnWidth ||
                  // or use the size of the first item
                  this.$filteredAtoms.outerWidth(true) ||
                  // if there's no items, use size of container
                  parentWidth;

    var cols = Math.floor( parentWidth / colW );
    cols = Math.max( cols, 1 );

    // i.e. this.masonry.cols = ....
    this.masonry.cols = cols;
    // i.e. this.masonry.columnWidth = ...
    this.masonry.columnWidth = colW;
  };

  $.Isotope.prototype._masonryReset = function() {
    // layout-specific props
    this.masonry = {};
    // FIXME shouldn't have to call this again
    this._getCenteredMasonryColumns();
    var i = this.masonry.cols;
    this.masonry.colYs = [];
    while (i--) {
      this.masonry.colYs.push( 0 );
    }
  };

  $.Isotope.prototype._masonryResizeChanged = function() {
    var prevColCount = this.masonry.cols;
    // get updated colCount
    this._getCenteredMasonryColumns();
    return ( this.masonry.cols !== prevColCount );
  };

  $.Isotope.prototype._masonryGetContainerSize = function() {
    var unusedCols = 0,
        i = this.masonry.cols;
    // count unused columns
    while ( --i ) {
      if ( this.masonry.colYs[i] !== 0 ) {
        break;
      }
      unusedCols++;
    }

    return {
          height : Math.max.apply( Math, this.masonry.colYs ),
          // fit container to columns that have been used;
          width : (this.masonry.cols - unusedCols) * this.masonry.columnWidth
        };
  };

$(function(){

  var $container = $('#container');

  $container.imagesLoaded( function(){
    $('#container').show();
    $('#loading').hide();
    $container.isotope({
      itemSelector : '.box'
    });
  });

  $container.infinitescroll({
    navSelector  : '.pagination',    // selector for the paged navigation
    nextSelector : '.pagination a',  // selector for the NEXT link (to page 2)
    itemSelector : '.box',     // selector for all items you'll retrieve
    extraScrollPx:50,
    loading: {


        img: 'http://i.imgur.com/qkKy8.gif',

      }
    },
    // call Isotope as a callback
    function(newElements) {
      var $newElems = $(newElements);
      $newElems.imagesLoaded(function(){
        $container.isotope('appended', $newElems );
      });
    }
  );
});


// $(document).ready(function(){
//   $('button').click(function(){
//     $('#container').hide();
//     $('.map_container').show('slow', function() {
//       google.maps.event.trigger(map, 'resize');
//     });
//   });
// });

$(document).ready(function(){

   $(".various").fancybox({
      maxWidth  : 800,
      maxHeight : 600,
      fitToView : false,
      width   : '70%',
      height    : '70%',
      autoSize  : false,
     closeClick  : false,
      openEffect  : 'none',
      closeEffect : 'none'
   });
   $(".gram").fancybox({
      margin: [50,150,50,150]
   });

// grid hover effect

   $('.image').mouseover(function() {
    $(this).find('.info').show();
    }).mouseout(function() {
    $('.info').hide();
  });



}); // ready

// map redo search function


function drawItems(theBounds) {
    var url = '/places.json/?sw_y=' + theBounds.getSouthWest().lng() +
                           '&sw_x=' + theBounds.getSouthWest().lat() +
                           '&ne_y=' + theBounds.getNorthEast().lng() +
                           '&ne_x=' + theBounds.getNorthEast().lat();
    $.get(url, function(newItemData) {
        Gmaps.map.replaceMarkers(newItemData);
    });
}


