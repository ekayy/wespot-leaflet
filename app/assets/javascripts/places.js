$(document).ready(function(){

  /** Index Instance **/
    var $container = $('#container');

    $container.imagesLoaded( function(){
      $container.masonry({
        itemSelector : '.box',
        isFitWidth: true
      });
    });

    var $container1 = $('.profile-left');

    $container1.imagesLoaded( function(){
      $container1.masonry({
        itemSelector : '.singlegram'
      });
    });

    $container.infinitescroll({
    navSelector  : '.pagination',    // selector for the paged navigation
    nextSelector : '.pagination a',  // selector for the NEXT link (to page 2)
    itemSelector : '.box',     // selector for all items you'll retrieve
    loading: {
        finishedMsg: 'No more pages to load.',
        img: 'http://i.imgur.com/6RMhx.gif'
      }
    },

    function( newElements ) {
      var $newElems = $( newElements ).css({ opacity: 0 });
      $newElems.imagesLoaded(function(){
        $newElems.animate({ opacity: 1 });
        $container.masonry( 'appended', $newElems, true );
      });
    }
  );

  });
});

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


