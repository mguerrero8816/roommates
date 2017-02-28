module ApplicationHelper

  # takes: integer
  # returns: string
  # converts cents amount to dollar amount
  def cents_to_dollars(cents)
    "$#{cents/100}.#{(cents%100).to_s.rjust(2, '0')}"
  end
end
