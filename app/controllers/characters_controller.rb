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



  private

    def params_to_url
      allowed_params = ['paragraphs','cussin','mixed','startleb','html','characters']
      params.map { |k,v| if v.class == Array then "#{k}/#{v.join(',')}" else "#{k}/#{v}" end if allowed_params.include?(k) }
        .delete_if {|x| x.nil? }
        .join('/')
    end

end
