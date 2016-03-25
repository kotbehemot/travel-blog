class DynamicCKEditor
  constructor: ->
    $('#init_ckeditor').on 'click', (event) =>
      event.preventDefault()
      $('#init_ckeditor').remove()
      CKEDITOR.replace('post_content')
      false

  $ ->
    new DynamicCKEditor if $('#post_content').length > 0