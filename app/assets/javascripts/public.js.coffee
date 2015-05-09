class StickyNav
  constructor: ->
    $(document).on 'DOMMouseScroll', (e) =>
      if e.originalEvent.detail > 0
        @hideNav()
      else
        @showNav()
      true
    #IE, Opera, Safari
    $(document).on 'mousewheel', (e) =>
      if e.originalEvent.wheelDelta < 0
        @hideNav()
      else
        @showNav()
      true

  showNav: ->
    $('navigation').removeClass('hidden') if $('navigation').hasClass('hidden')

  hideNav: ->
    $('navigation').addClass('hidden') if !$('navigation').hasClass('hidden')


$ ->
  new StickyNav if $('navigation').length > 0