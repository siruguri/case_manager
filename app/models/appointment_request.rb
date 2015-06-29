class AppointmentRequest < ActiveRecord::Base
  belongs_to :volunteer, class_name: 'User', foreign_key: :volunteer_id
end
