class Homepage

  DEFAULT_DAILY_DISTANCE = 40

  constructor: ->
    @set_counter()
    @set_odo()
    setInterval =>
      @set_odo()
    , 1000
    @init_maps() unless $('#homepage-map').hasClass('no-init')

  set_counter: ->
    timer_el = $('#homepage-timer')
    that_moment = moment timer_el.data('when')
    diff = moment().diff(that_moment)/1000
    days = Math.ceil(diff/(60*60*24))
    timer_el.html timer_el.data('template').replace('[COUNT]', days)

  set_odo: ->
    counter_el = $('#homepage-odometer')
    km = counter_el.data('km')
    odo_moment = moment counter_el.data('when')
    diff = moment().diff(odo_moment)/1000
    proper_km = +km + diff*DEFAULT_DAILY_DISTANCE/(24*60*60)
    counter_el.html counter_el.data('template').replace('[COUNT]', Math.round(1000*proper_km))

  init_maps: ->
    handler = Gmaps.build('Google')
    handler.buildMap {
      provider: {
        mapTypeId: google.maps.MapTypeId.TERRAIN
        zoomControlOptions:
          style: google.maps.ZoomControlStyle.LARGE
        disableDefaultUI: false
        scrollwheel: false
      }
      internal: id: 'homepage-map'
    }, ->
      locations = $('#homepage-map').data('locations')
      map_locations = []
      for location in locations
        map_locations.push {
          'lat': location.lat
          'lng': location.lon
          'infowindow': location.date
          "picture": {
            "url": "/images/cycling.png",
            "width":  32,
            "height": 37
          }
        }

      markers = handler.addMarkers(map_locations)
      handler.bounds.extendWith(markers)
      handler.fitMapToBounds()
      $('#homepage-map').removeClass('init')

class ImageGallery

  gallery_current_index = 0
  gallery_images = []

  constructor: ->
    @init_gallery()

  init_gallery: ->
    gallery_images = $('.image-gallery').data('images')
    if gallery_images
      setTimeout =>
        @shift_image_in_gallery()
      , 10000

  shift_image_in_gallery: ->
    return if gallery_images.length < 2
    gallery_current_index = (gallery_current_index + 1)%gallery_images.length
    image_src = gallery_images[gallery_current_index]
    img = new Image()
    img.onload = =>
      $('.image-gallery').css("background-image", "url(\"#{image_src}\")")
      $(window).focus() #trigger resize event
      setTimeout =>
        @shift_image_in_gallery()
      , 10000
    img.src = image_src

$ ->
  new Homepage if $('#homepage').length > 0
  new ImageGallery if $('.image-gallery').length > 0
