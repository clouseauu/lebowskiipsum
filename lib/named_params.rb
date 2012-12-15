class NamedParams

  include ValueTypes

  def initialize url_params
    @url_params = url_params
    self
  end

  def parse_options defaults
    user_options = array_to_param_hash @url_params.split('/')
    defaults.merge(user_options)
  end

  def array_to_param_hash the_array
    Hash[*the_array].inject({}) { |memo,(k,v)| memo[k.to_sym] = determine_value_type v; memo }
  end

end