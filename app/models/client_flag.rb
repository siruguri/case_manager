class ClientFlag < ActiveRecord::Base
  belongs_to :yes_no_flag
  belongs_to :client

  def is_true?
    val=((self.flag_value.present?) ? self.flag_value.downcase : 'nil')

    val=='yes' or val=='true'
  end
end
