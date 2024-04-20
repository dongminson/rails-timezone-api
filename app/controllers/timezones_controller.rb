class TimezonesController < ApplicationController
  def current_time
    timezone = params[:timezone].to_s.strip

    begin
    time_zone = ActiveSupport::TimeZone.find_tzinfo(timezone)&.name
    rescue TZInfo::InvalidTimezoneIdentifier
      render json: { error: 'Invalid argument provided for timezone' }, status: :unprocessable_entity
      return
    end

    time = Time.now.in_time_zone(time_zone)
    render json: { timezone: time_zone, current_time: time }
  end
end