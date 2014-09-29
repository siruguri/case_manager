class Organization < ActiveRecord::Base
  serialize :urls, Array

  has_many :theme_components, inverse_of: :theme_owner
end
