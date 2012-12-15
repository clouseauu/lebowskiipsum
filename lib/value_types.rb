module ValueTypes

  def to_boolean str
    str == 'true'
  end

  def determine_value_type option
    case
      when option == "false" || option == "true"
        to_boolean option
      when option =~ /,/
        option.split(',').map { |v| determine_value_type v }
      when option =~ /\d/
        option.to_i
      else
        option
    end
  end

end
