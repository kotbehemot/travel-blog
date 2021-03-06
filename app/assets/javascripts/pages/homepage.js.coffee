class HomepageCounters

  DEFAULT_DAILY_DISTANCE = 40

  constructor: ->
    @set_counter()
    @set_bike_odo()
    setInterval =>
      @set_bike_odo()
    , 1000

  set_counter: ->
    timer_el = $('#homepage-timer')
    that_moment = moment timer_el.data('when')
    days_earlier = timer_el.data('days')
    diff = moment().diff(that_moment)/1000
    days = Math.ceil(diff/(60*60*24))
    total_days = +days_earlier + days
    timer_el.children(".value").html total_days

  set_bike_odo: ->
    counter_el = $('#homepage-odometer-bike')
    km = counter_el.data('km')
    odo_moment = moment counter_el.data('when')
    diff = moment().diff(odo_moment)/1000
    proper_km = +km + diff*DEFAULT_DAILY_DISTANCE/(24*60*60)
    counter_el.children(".value").html Math.round(1000*proper_km)
    counter_el.children(".unit").html 'm'

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
  # homepage counters disabled due to blog freeze (end of journey)
  # new HomepageCounters if $('#homepage').length > 0
  new ImageGallery if $('.image-gallery').length > 0
