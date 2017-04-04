class Api::V1::WeatherController < ApplicationController
  skip_before_action :authenticate_user!, only: [:get_weather]

  def get_weather
    render :json => Weather.get_weather_at_coordinates(params[:coordinates])
  end
end