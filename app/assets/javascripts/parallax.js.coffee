class FullscreenBackgrounds

  constructor: ->
    $(window).on 'resize', @backgroundResize
    $(window).on 'focus', @backgroundResize
    @backgroundResize()

  backgroundResize: ->
    windowH = $(window).height()
    $('.background').each (i) ->
      path = $(this)
      # variables
      contW = path.width()
      contH = path.height()
      imgW = path.attr('data-img-width')
      imgH = path.attr('data-img-height')
      ratio = imgW / imgH
      # overflowing difference
      diff = parseFloat(path.attr('data-diff'))
      diff = if diff then diff else 0
      # remaining height to have fullscreen image only on parallax
      remainingH = 0
      if path.hasClass('parallax') and !$('html').hasClass('touch')
        maxH = if contH > windowH then contH else windowH
        remainingH = windowH - contH
      # set img values depending on cont
      imgH = contH + remainingH + diff
      imgW = imgH * ratio
      # fix when too large
      if contW > imgW
        imgW = contW
        imgH = imgW / ratio
      #
      path.data 'resized-imgW', imgW
      path.data 'resized-imgH', imgH
      path.css 'background-size', imgW + 'px ' + imgH + 'px'


class ParallaxBackgrounds

  constructor: ->
    if @isMobile()
      document.documentElement.className = document.documentElement.className + ' touch'
    else
      $(window).resize @parallaxPosition
      $(window).scroll @parallaxPosition
      @parallaxPosition()

  ### detect touch ###
  isMobile: ->
    try
      document.createEvent 'TouchEvent'
      return true
    catch e
      return false

  parallaxPosition: (e) ->
    heightWindow = $(window).height()
    topWindow = $(window).scrollTop()
    bottomWindow = topWindow + heightWindow
    currentWindow = (topWindow + bottomWindow) / 2
    $('.parallax').each (i) ->
      path = $(this)
      height = path.height()
      top = path.offset().top
      bottom = top + height
      # only when in range
      if bottomWindow > top and topWindow < bottom
        imgW = path.data('resized-imgW')
        imgH = path.data('resized-imgH')
        # min when image touch top of window
        min = 0
        # max when image touch bottom of window
        max = -imgH + heightWindow
        # overflow changes parallax
        overflowH = if height < heightWindow then imgH - height else imgH - heightWindow
        # fix height on overflow
        top = top - overflowH
        bottom = bottom + overflowH
        # value with linear interpolation
        value = min + (max - min) * (currentWindow - top) / (bottom - top)
        # set background-position
        orizontalPosition = path.attr('data-oriz-pos')
        orizontalPosition = if orizontalPosition then orizontalPosition else '50%'
        $(this).css 'background-position', orizontalPosition + ' ' + value + 'px'

$ ->
  new FullscreenBackgrounds
  new ParallaxBackgrounds