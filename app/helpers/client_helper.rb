module ClientHelper
  def show_checked(flg_value)
    if flg_value
      return "checked"
    else
      return ""
    end
  end
end

