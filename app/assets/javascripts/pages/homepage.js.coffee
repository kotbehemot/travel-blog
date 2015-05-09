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
    that_moment = moment $('#homepage-timer').data('when')
    diff = moment().diff(that_moment)/1000
    days = Math.ceil(diff/(60*60*24))
    $('#homepage-timer').html "#{days}. dzień w trasie"

  set_odo: ->
    km = $('#homepage-odometer').data('km')
    odo_moment = moment $('#homepage-odometer').data('when')
    diff = moment().diff(odo_moment)/1000
    proper_km = +km + diff*DEFAULT_DAILY_DISTANCE/(24*60*60)
    $('#homepage-odometer').html "Przejechaliśmy #{Math.round(1000*proper_km)} metrów"

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

$ ->
  new Homepage if $('#homepage').length > 0

