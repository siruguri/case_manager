module ClientHelper
  def display_flag(flg_value)
    if flg_value
      return raw("<span class='red-font bold-font'>Yes</span>")
    else
      return raw("<span class='green-font'>No</span>")
    end
  end
end

