class QuotesController < ApplicationController
  # GET /quotes
  # GET /quotes.json
  def index

    @options = ParamParser.new.parse_options(params['options'], DEFAULT_OPTIONS, get_all_characters).validate_options

    conditions = { character_id: @options[:characters] }
    conditions.merge! cussin: false if @options[:cussin] == false

    @quotes = Quote.all conditions: conditions, order: "RANDOM()"
    @lebowski_ipsum = LebowskiIpsum.new(@quotes, @options).lebowski_ipsum @options[:paragraphs]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: json_results }
    end
  end


  private

    def json_results
      {
      meta: @options,
      results: @lebowski_ipsum
      }
    end

end
