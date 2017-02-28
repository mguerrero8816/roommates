module SqlObjectHelper

  # takes: hash, symbol
  # returns: string
  # build string with first name and last initial from hash
  def name_with_initial_from_sql(object, name_symbol)
    symbol_string = name_symbol.to_s
    first_name_key = "#{symbol_string}_first_name".to_sym
    last_name_key = "#{symbol_string}_last_name".to_sym
    object[last_name_key] ? "#{object[first_name_key]} #{object[last_name_key][0]}." : ''
  end
end
