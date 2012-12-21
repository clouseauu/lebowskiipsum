class ParamParser

  include ValueTypes

  def initialize url_params, defaults, characters
    @url_params = url_params
    @defaults = defaults
    @options = parse_options
    @characters = characters
    @all_character_ids = @characters.map &:id
    @minor_character_ids = @characters.drop_while { |c| c.is_main?  }.map &:id
    self
  end

  def parse_options
    user_options = !@url_params.nil? ? array_to_param_hash(@url_params.split '/') : {}
    @defaults.merge(user_options)
  end

  def array_to_param_hash the_array
    the_array.pop if the_array.length.odd?
    Hash[*the_array].inject({}) { |memo,(k,v)| memo[k.to_sym] = determine_value_type v; memo }
  end

  def validate_options
    parse_options

    @options[:paragraphs]     = validate_paragraphs
    @options[:cussin]         = validate_boolean :cussin
    @options[:mixed]          = validate_boolean :mixed
    @options[:startleb]       = validate_boolean :startleb
    @options[:html]           = validate_boolean :html
    @options[:characters]     = validate_characters
    @options
  end

  def validate_paragraphs
    begin
      p = @options[:paragraphs].to_i
      return p if p > 0 and p <= 500
    rescue
    end
    @defaults[:paragraphs]
  end

  def validate_boolean key
    if @options[key].class == FalseClass or @options[key].class == TrueClass then return @options[key] end
    @defaults[key]
  end

  def validate_characters
    c = @options[:characters]
    c = Array(c) if c.class != Array

    return @all_character_ids if c.include? 'all'

    c.map { |s| if s.to_s.downcase == 'minor' then  @minor_character_ids.flatten else s end }
      .flatten.reject { |s| !@all_character_ids.include? s }
      .uniq
      .sort
  end


end