class QuotesController < ApplicationController
  # GET /quotes
  # GET /quotes.json
  def index

    @options = ParamParser.new.parse_options(params['options'], DEFAULT_OPTIONS, get_all_characters).validate_options

    conditions = { character_id: @options[:characters] }
    conditions.merge! cussin: false if @options[:cussin] == false

    @quotes = Quote.all conditions: conditions, order: "RANDOM()"
    @lebowski_ipsum = LebowskiIpsum.new(@quotes, @options).lebowski_ipsum @options[:paragraphs]

    if @options.try(:[], :output) == "json"
      render json: json_results
    end

  end

  private

    def json_results
      cast = get_all_characters
      @options[:characters] = @options[:characters].inject({}) { |chars,c| chars.merge( { c => cast.select{ |m| m.id == c }.first.name } ) }

      {
      meta: @options,
      results: @lebowski_ipsum
      }
    end

end
