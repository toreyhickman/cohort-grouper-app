module DateDependent
  def current_month
    Date.today.month
  end

  def current_year
    Date.today.year
  end

  def next_year
    current_year + 1
  end

  def last_year
    current_year - 1
  end
end
