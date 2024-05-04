require_relative '../services/fake_data_service'

class HomeController < ApplicationController
  def index
    @region = "en-US"
    @seed = '7'
    @error = '0'
    generate_fake_data()
  end

  def update_data
    # Update instance variables based on the received data
    @region = params[:region]
    @error = params[:error]
    @seed = params[:seed]
    # Respond with updated instance variables as JSON
    #render json: { region: @region, error: @error, seed: @seed }
  end

  def generate_fake_data
    @list=[]
    for i in 1..20 do
      @fake_data = FakeDataService.generate_data(@seed.to_i + i , @region, @error.to_i)
      @fake_data[:id] = i
      @list<<@fake_data
    end
  end
end
