class ClientFlag < ActiveRecord::Base
  belongs_to :yes_no_flag
  belongs_to :flag_config
  belongs_to :client

  def toggle_value
    if !(self.flag_value) or self.flag_value=='no'
      self.flag_value = 'yes'
    else
      self.flag_value = 'no'
    end
  end

  def is_true?
    val=((self.flag_value.present?) ? self.flag_value.downcase : 'nil')

    val=='yes' or val=='true'
  end
end
