class Map

  DISPLAY_LATEST_LOCATIONS = 6
  POLYLINES_COLOURS = ['#FF9933', '#8899FF', '#337777', '#AAAAAA', '#66BB66']
  POLYLINES_OPACITIES = [0.7, 0.8, 0.7, 0.7, 0.8]
  ZOOM_BOUNDARY = 7

  constructor: ->
    @init_maps() unless $('#homepage-map').hasClass('no-init')

  init_maps: ->
    close_zoom = true
    $.getJSON '/map_locations.json', (locations) ->
      handler = Gmaps.build("Google", markers: { clusterer: undefined  })
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
        marker_object = (location) ->
          info = "<i>#{location.date}</i>"
          if location.title?
            info = "<h4>#{location.title}</h4><i>#{location.date}</i>"
          if location.description?
            info = info.concat "<p>#{location.description}</p>"
          {
            'lat': location.lat
            'lng': location.lon
            'title': location.title
            'infowindow': info
            "picture": {
              "url": "/images/cycling.png",
              "width":  32,
              "height": 37
            }
          }

        map_locations_latest = []
        for location in locations.slice(0,DISPLAY_LATEST_LOCATIONS)
          map_locations_latest.push marker_object(location)
        markers_latest = handler.addMarkers(map_locations_latest)
        handler.bounds.extendWith(markers_latest)
        handler.fitMapToBounds()

        map_locations_earlier = []
        for location in locations.slice(DISPLAY_LATEST_LOCATIONS)
          map_locations_earlier.push marker_object(location)
        markers_earlier = handler.addMarkers(map_locations_earlier)
        handler.bounds.extendWith(markers_earlier)

        previous_point = null
        for location in locations
          if previous_point?
            polylines = handler.addPolyline(
              [ {lat: location.lat, lng: location.lon}, {lat: previous_point.lat, lng: previous_point.lon} ],
              strokeColor: POLYLINES_COLOURS[previous_point.vehicle_type],
              geodesic: true,
              strokeOpacity: POLYLINES_OPACITIES[previous_point.vehicle_type]
            )
          previous_point = location

        handler.bounds.extendWith(polylines)

        all_markers = markers_latest.concat markers_earlier
        if handler.getMap().getZoom() < ZOOM_BOUNDARY
          close_zoom = false
          for marker in all_markers
            marker.hide()

        google.maps.event.addListener handler.getMap(), 'zoom_changed', ->
          zoom = handler.getMap().getZoom()
          if zoom >= ZOOM_BOUNDARY && close_zoom == false
            close_zoom = true
            for marker in all_markers
              marker.show()
          else if zoom < ZOOM_BOUNDARY && close_zoom == true
            close_zoom = false
            for marker in all_markers
              marker.hide()

        $('#homepage-map').removeClass('init')

$ ->
  new Map if $('#homepage-map').length > 0