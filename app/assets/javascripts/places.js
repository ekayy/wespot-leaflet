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



$(document).ready(function(){

  var $container = $('#container');

  $container.imagesLoaded( function(){
    $container.isotope({
      itemSelector : '.box'
    });
  });

  $container.infinitescroll({
    navSelector  : '.pagination',    // selector for the paged navigation
    nextSelector : '.pagination a',  // selector for the NEXT link (to page 2)
    itemSelector : '.box',     // selector for all items you'll retrieve
    loading: {
        finishedMsg: 'No more pages to load.',
        img: 'http://i.imgur.com/qkKy8.gif'
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

  /** Index Instance **/
    // var $container = $('#container');

    // $container.imagesLoaded( function(){
    //   $container.isotope({
    //     itemSelector : '.box',
    //     isFitWidth: true
    //   });
    // });

    // var $container1 = $('.profile-left');

    // $container1.imagesLoaded( function(){
    //   $container1.isotope({
    //     itemSelector : '.singlegram'
    //   });
    // });

    // $container.infinitescroll({
    // navSelector  : '.pagination',    // selector for the paged navigation
    // nextSelector : '.pagination a',  // selector for the NEXT link (to page 2)
    // itemSelector : '.box',     // selector for all items you'll retrieve
    // loading: {
    //     finishedMsg: 'No more pages to load.',
    //     img: 'http://i.imgur.com/6RMhx.gif'
    //   }
    // },

    // function( newElements ) {
    //   var $newElems = $( newElements ).css({ opacity: 0 });
    //   $newElems.imagesLoaded(function(){
    //     $newElems.animate({ opacity: 1 });
    //     $container.isotope( 'appended', $newElems, true );
    //   });
    // }
  // );


$(document).ready(function(){
  $('button').click(function(){
    $('#container').hide();
    $('.map_container').show('slow', function() {
      google.maps.event.trigger(map, 'resize');
    });
  });
});

$(document).ready(function(){

   $(".various").fancybox({

      margin: [50,150,50,150]
   });

}); // ready


