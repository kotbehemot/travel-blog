module ApplicationHelper
  def page_title
    if @title
      "#{@title} | #{t('app_name')}"
    else
      t('app_name')
    end
  end
end
