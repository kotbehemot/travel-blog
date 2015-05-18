module ApplicationHelper
  def page_title
    if @title
      "#{@title} | #{t('app_name')}"
    else
      t('app_name')
    end
  end

  def switch_locale_link
    new_locale = (I18n.locale.to_s == 'pl' ? 'en' : 'pl')
    link_to(new_locale, {:locale => new_locale})
  end
end
