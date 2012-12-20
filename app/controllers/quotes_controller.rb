class QuotesController < ApplicationController
  # GET /quotes
  # GET /quotes.json
  def index

    @options = NamedParams.new(params['options']).parse_options DEFAULT_OPTIONS
    validate_options

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

    def validate_options
      @options[:paragraphs]     = validate_paragraphs
      @options[:cussin]         = validate_boolean :cussin
      @options[:mixed]          = validate_boolean :mixed
      @options[:startleb]       = validate_boolean :startleb
      @options[:html]           = validate_boolean :html
      @options[:characters]     = validate_characters
    end

    def validate_paragraphs
      begin
        p = @options[:paragraphs].to_i
        return p if p.to_i > 0 and p.to_i <= 500
      rescue
      end
      DEFAULT_OPTIONS[:paragraphs]
    end

    def validate_boolean key
      if @options[key].class == FalseClass or @options[key].class == TrueClass then return @options[key] end
      DEFAULT_OPTIONS[key]
    end

    def validate_characters
      c = @options[:characters]
      c = Array(c) if c.class != Array
      all_characters = get_all_characters

      return all_characters if c.include? 'all'

      c.map { |s| if s.to_s.downcase == 'minor' then  get_minor_characters.flatten else s end }.flatten.reject { |s| !all_characters.include? s }.uniq.sort
    end

end
