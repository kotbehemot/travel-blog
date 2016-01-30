module ApplicationHelper
  def page_title
    if @title
      "#{@title} | #{t('app_name')}"
    else
      t('app_name')
    end
  end

  def page_type
    if params[:controller] == 'posts' && params[:action] == 'show'
      'article'
    else
      'website'
    end
  end

  def switch_locale_link
    new_locale = alternate_locale
    link_to(new_locale, alternate_locale_url)
  end

  def alternate_locale_url(options = {})
    new_locale = I18n.locale.to_s == 'pl' ? 'en' : nil
    url_for(options.merge({:locale => new_locale}))
  end

  def alternate_locale
    I18n.locale.to_s == 'pl' ? 'en' : 'pl'
  end
end
