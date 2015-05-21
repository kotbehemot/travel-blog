class DynamicFacebookComments
  constructor: ->
    $('#post-comments-hidden').on 'click', 'a', (event) =>
      event.preventDefault()
      @activateFbBox()
      false

  activateFbBox: ->
    foundFBComs = false
    fb_init_button = $('#post-comments-hidden a')
    fb_init_button.html(fb_init_button.data('loading-message'))
    $('.fb-comments-unloaded').each ->
      $fbCom = $(this)
      contWidth = $fbCom.parent().width()
      $fbCom.attr('data-width', contWidth).removeClass('fb-comments-unloaded').addClass 'fb-comments'
      foundFBComs = true
      return
    if foundFBComs and typeof FB != 'undefined'
      FB.XFBML.parse()
    setTimeout ->
      fb_init_button.hide()
    , 3000

$ ->
  new DynamicFacebookComments