require_relative '../services/fake_data_service'

class HomeController < ApplicationController
  def index
    @region = cookies[:region] || "de"
    @error = cookies[:error] || 0
    @seed = cookies[:seed] || 7
    render :index
  end

  def update_data
    puts "I was Here"
    @region = params[:region]
    @error = params[:error]
    @seed = params[:seed]
    cookies[:region] = @region
    cookies[:error] = @error
    cookies[:seed] = @seed
    output = generate_fake_data
    render json: output
  end

  private

  def generate_fake_data
    output = []
    for i in 1..20 do
      fake_data = FakeDataService.generate_data(@seed.to_i + i, @region, @error.to_i)
      fake_data[:id] = i
      output << fake_data
    end
    puts output
    output
  end
end
