class Organization < ActiveRecord::Base
  serialize :urls, Array
end
