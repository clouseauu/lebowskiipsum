class CharactersController < ApplicationController
  # GET /characters
  # GET /characters.json
  def index
    @main_characters = get_main_characters
    @half_point = ((@main_characters.length + 1) / 2).ceil

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @characters }
    end
  end

  def robots
    url = ParamParser.new.params_to_url params
    redirect_to "/dude/generate/#{url}"
  end

end
