module ApplicationHelper

  def flash_class(level)
    case level
      when "notice"
        "alert alert-info alert-dismissible"
      when "success"
        "alert alert-success alert-dismissible"
      when "error"
        "alert alert-warning alert-dismissible"
      when "alert"
        "alert alert-danger alert-dismissible"
    end
  end

end
