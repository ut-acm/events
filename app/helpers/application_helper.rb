module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # convert date from Gregorian to Hijri
  def persian_calendar(date)
    result = ''
    time = date.to_parsi.strftime ("%A %d %B %Y (%H:%M)").to_s
    time.split(//).each do |c|
      result += (c >= '0' and c <= '9') ? t(c) : c
    end
    result
  end

  def persian_calendar_month(date)
    result = ''
    time = date.to_parsi.strftime ("%d %B %Y (%H:%M)").to_s
    time.split(//).each do |c|
      result += (c >= '0' and c <= '9') ? t(c) : c
    end
    result
  end

end
