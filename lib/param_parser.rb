class ParamParser

  include ValueTypes

  def parse_options url_params, defaults, characters
    @defaults = defaults
    @characters = characters

    user_options = !url_params.nil? ? array_to_param_hash(url_params.split '/') : {}
    @options = @defaults.merge(user_options)
    parse_characters
    self
  end

  def array_to_param_hash the_array
    the_array.pop if the_array.length.odd?
    Hash[*the_array].inject({}) { |memo,(k,v)| memo[k.to_sym] = determine_value_type v; memo }
  end

  def parse_characters
    @all_character_ids = @characters.map &:id
    @minor_character_ids = @characters.drop_while { |c| c.is_main?  }.map &:id
  end

  def validate_options

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


  def params_to_url params
    allowed_params = ['paragraphs','cussin','mixed','startleb','html','characters']
    params.map { |k,v| if v.class == Array then "#{k}/#{v.join(',')}" else "#{k}/#{v}" end if allowed_params.include?(k) }
      .delete_if {|x| x.nil? }
      .join('/')
  end


end