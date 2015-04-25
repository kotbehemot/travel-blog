class Homepage

  constructor: ->
    @init_counter()
    @init_maps()

  init_counter: ->
    that_moment = moment $('#homepage-timer').data('when')
    diff = that_moment.diff(moment())/1000
    days = -Math.floor(diff/(60*60*24))
    $('#homepage-timer').html "#{days}. dzień podróży"

  init_maps: ->
    handler = Gmaps.build('Google')
    handler.buildMap {
      provider: {
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
        }

      markers = handler.addMarkers(map_locations)
      handler.bounds.extendWith(markers)
      handler.fitMapToBounds()

$ ->
  new Homepage if $('#homepage').length > 0

