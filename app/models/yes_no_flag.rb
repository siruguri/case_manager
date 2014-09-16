class YesNoFlag < ActiveRecord::Base
  has_many :client_flags
  has_many :clients, through: :client_flags

end
