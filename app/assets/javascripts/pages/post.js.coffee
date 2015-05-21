class DynamicFacebookComments
  constructor: ->
    $('#post-comments-hidden').on 'click', 'a', (event) =>
      event.preventDefault()
      @activateFbBox()
      false

  activateFbBox: ->
    fb_init_button = $('#post-comments-hidden a')
    fb_init_button.html(fb_init_button.data('loading-message'))
    fb_comments_section = $('#fb-comments-unloaded')
    return unless fb_comments_section?
    fb_comments_section.addClass 'fb-comments'
    if typeof FB != 'undefined'
      FB.XFBML.parse document.getElementById('post-comments'), () ->
        fb_init_button.hide()

$ ->
  new DynamicFacebookComments