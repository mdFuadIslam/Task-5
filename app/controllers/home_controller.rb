require_relative '../services/fake_data_service'

class HomeController < ApplicationController
  def index
    @region = cookies[:region] || "de"
    @error = cookies[:error] || 0
    @seed = cookies[:seed] || 7
    @page = cookies[:page] || 1
    render :index
  end

  def update_data
    @region = params[:region]
    @error = params[:error]
    @seed = params[:seed]
    @page = params[:page]
    cookies[:region] = @region
    cookies[:error] = @error
    cookies[:seed] = @seed
    cookies[:page] = @page
    output = generate_fake_data
    render json: output
  end

  private

  def generate_fake_data
    output = []
    if @page == '1'
      start_at = 1
      end_at = 40
    else
      start_at = @page.to_i * 10 + 1
      end_at = start_at + 9
    end
    for i in start_at..end_at do
      fake_data = FakeDataService.generate_data(@seed.to_i + i, @region, @error.to_i)
      fake_data[:id] = i
      output << fake_data
    end
    puts output
    output
  end
end
