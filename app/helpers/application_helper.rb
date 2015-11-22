module ApplicationHelper
  
 def bootstrap_class_for flash_type
   { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info"}[flash_type.to_sym] || flash_type.to_s
 end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end
def markdown(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       no_intra_emphasis: true,
                                       fenced_code_blocks: true,
                                       disable_indented_code_blocks: true,
                                       autolink: true,
                                       tables: true,
                                       underline: true,
                                       highlight: true
                                      )
    return markdown.render(text).html_safe
  end 
def resource_name
  :user
end

def resource
  @resource ||= User.new
end

def devise_mapping
  @devise_mapping ||= Devise.mappings[:user]
end

def format_birthday date
  date.year.to_s+"年"+date.month.to_s+"月"+date.day.to_s+'日'
end

def format_month date
  date.year.to_s+"年"+date.month.to_s+"月"
end

end
