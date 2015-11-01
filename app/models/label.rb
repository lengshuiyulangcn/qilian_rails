class Label < ActiveRecord::Base
  has_and_belongs_to_many :jobs

  def self.by_graduate_year
    self.where(category: "gradyear")
  end
  def self.by_category
    self.where(category: "genre")
  end
  def self.by_industry
    self.where(category: "industry")
  end
  
end
