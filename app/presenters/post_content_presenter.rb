class PostContentPresenter

  IMG_WITH_TITLE_REGEXP = /<p><img[^>]*alt="([^"]+)[^>]*src="([^"]+)[^>]*style="[^"]*width:[ ]{0,1}([0-9]+)px;[^"]*height:[ ]{0,1}([0-9]+)px;[^"]*"[^>]*><\/p>/m
  IMG_REGEXP = /<p><img[^>]*src="([^"]+)[^>]*style="[^"]*width:[ ]{0,1}([0-9]+)px;[^"]*height:[ ]{0,1}([0-9]+)px;[^"]*"[^>]*><\/p>/m

  def initialize(post)
    @post = post
  end

  def content
    new_content = @post.content.gsub(IMG_WITH_TITLE_REGEXP, '<p class=\'image-title\'>\1</p><div title=\'\1\' class=\'fullscreen background parallax image-gallery\' style=\'width:100%; background-image:url(\2);\' data-mfp-src=\'\2\' data-img-width=\3 data-img-height=\4 data-diff=200></div>')
    new_content = new_content.gsub(IMG_REGEXP, '<div class=\'fullscreen background parallax image-gallery\' style=\'width:100%; background-image:url(\1);\' data-mfp-src=\'\1\' data-img-width=\2 data-img-height=\3 data-diff=200></div>')
    new_content.html_safe
  end

  def class_for_post_image
    klasses = []
    klasses << 'inverted' if @post.inverted_title
    klasses << 'photostory' if @post.photostory?
    klasses
  end

  def font_class
    @post.s_letter ? 'letter' : 'regular'
  end
end