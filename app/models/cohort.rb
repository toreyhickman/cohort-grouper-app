class Cohort < ActiveRecord::Base

  def self.find_by_param(param)
    where(slug: param).first
  end

  def self.locations
    pluck(:location).uniq.sort
  end

  def to_param
    slug
  end

  def mascot_name
    name.sub(/^(?<mascot>.+)(?<year>\s\d{4})$/, '\k<mascot>')
  end
end
