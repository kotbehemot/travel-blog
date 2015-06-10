class Homepage

  DEFAULT_DAILY_DISTANCE = 40
  gallery_current_index = 0
  gallery_images = []

  constructor: ->
    @set_counter()
    @set_odo()
    setInterval =>
      @set_odo()
    , 1000
    @init_maps() unless $('#homepage-map').hasClass('no-init')
    @init_gallery()

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

  init_gallery: ->
    gallery_images = $('#homepage-title').data('images')
    setTimeout =>
      @shift_image_in_gallery()
    , 10000

  shift_image_in_gallery: ->
    return if gallery_images.length < 2
    gallery_current_index = (gallery_current_index + 1)%gallery_images.length
    image_src = gallery_images[gallery_current_index]
    img = new Image()
    img.onload = =>
      $('#homepage-title').css("background-image", "url(\"#{image_src}\")")
      setTimeout =>
        @shift_image_in_gallery()
      , 10000
    img.src = image_src

$ ->
  new Homepage if $('#homepage').length > 0

