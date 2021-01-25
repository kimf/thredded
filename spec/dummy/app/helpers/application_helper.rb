# frozen_string_literal: true

require_dependency 'themes'

module ApplicationHelper
  def themes
    Themes::VALID_THEMES
  end

  def current_theme
    cookie_theme = cookies['app-theme']
    themes.include?(cookie_theme) ? cookie_theme : themes[0]
  end

  def method_missing(method, *args, &block)
    if method.to_s.end_with?("_path", "_url")
      if main_app.respond_to?(method)
        main_app.send(method, *args)
      else
        super
      end
    else
      super
    end
  end

  def respond_to?(method)
    if method.to_s.end_with?("_path", "_url")
      if main_app.respond_to?(method)
        true
      else
        super
      end
    else
      super
    end
  end
end
