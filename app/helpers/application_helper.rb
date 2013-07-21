module ApplicationHelper

  def outstanding_translations(resource)
    outstanding_locales = I18n.available_locales.reject { |locale| (locale == I18n.locale) }
    if resource.respond_to? "translations"
      resource.translations.each do |translation|
        outstanding_locales.reject! { |locale| (locale == translation.locale) }
      end
      outstanding_locales
    else
      []
    end
  end

  def translation_tab_id(resource, locale)
    resource.class.name.downcase + "_" + resource.id.to_s + "_locale_" + locale.to_s
  end

  def cities_curated

    if can? :manage, :all
      City.all
    else
      current_user.cities_curated
    end
  end

end
