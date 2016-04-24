class Homepage

  DEFAULT_DAILY_DISTANCE = 40
  DISPLAY_LATEST_LOCATIONS = 6
  POLYLINES_COLOURS = ['#FF9933', '#8899FF', '#337777', '#AAAAAA', '#66BB66']
  POLYLINES_OPACITIES = [0.7, 0.8, 0.7, 0.7, 0.8]

  constructor: ->
    @set_counter()
    @set_bike_odo()
    setInterval =>
      @set_bike_odo()
    , 1000
    @init_maps() #unless $('#homepage-map').hasClass('no-init')

  set_counter: ->
    timer_el = $('#homepage-timer')
    that_moment = moment timer_el.data('when')
    diff = moment().diff(that_moment)/1000
    days = Math.ceil(diff/(60*60*24))
    timer_el.children(".value").html days

  set_bike_odo: ->
    counter_el = $('#homepage-odometer-bike')
    km = counter_el.data('km')
    odo_moment = moment counter_el.data('when')
    diff = moment().diff(odo_moment)/1000
    proper_km = +km + diff*DEFAULT_DAILY_DISTANCE/(24*60*60)
    counter_el.children(".value").html Math.round(1000*proper_km)

  init_maps: ->
    $.getJSON '/map_locations.json', (locations) ->
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
        map_locations_latest = []

        for location in locations.slice(0,DISPLAY_LATEST_LOCATIONS)
          map_locations_latest.push {
            'lat': location.lat
            'lng': location.lon
            'infowindow': location.date
            "picture": {
              "url": "/images/location_icons/icon#{location.vehicle_type}.png",
              "width":  32,
              "height": 37
            }
          }
        markers_latest = handler.addMarkers(map_locations_latest)
        handler.bounds.extendWith(markers_latest)
        handler.fitMapToBounds()
        map_locations_earlier = []
        for location in locations.slice(DISPLAY_LATEST_LOCATIONS)
          map_locations_earlier.push {
            'lat': location.lat
            'lng': location.lon
            'infowindow': location.date
            "picture": {
              "url": "/images/location_icons/icon#{location.vehicle_type}.png",
              "width":  32,
              "height": 37
            }
          }
        markers_earlier = handler.addMarkers(map_locations_earlier)
        handler.bounds.extendWith(markers_earlier)

        previous_point = null
        for location in locations
          if previous_point?
            polylines = handler.addPolylines(
              [ [ {lat: location.lat, lng: location.lon}, {lat: previous_point.lat, lng: previous_point.lon} ] ],
              strokeColor: POLYLINES_COLOURS[previous_point.vehicle_type],
              geodesic: true,
              strokeOpacity: POLYLINES_OPACITIES[previous_point.vehicle_type]
            )
          previous_point = location

        handler.bounds.extendWith(polylines)



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
      $('.image-gallery').css("opacity", 0)
      setTimeout =>
        $('.image-gallery').css("background-image", "url(\"#{image_src}\")")
        $(window).focus() #trigger resize event
        setTimeout =>
          $('.image-gallery').css("opacity", 1)
          setTimeout =>
            @shift_image_in_gallery()
          , 10000
        , 80
      , 80
    img.src = image_src

$ ->
  new Homepage if $('#homepage').length > 0
  new ImageGallery if $('.image-gallery').length > 0
