module ApplicationHelper
    APP_NAME = 'EbitenGames'.freeze
    
    def page_title
        base_title = APP_NAME
        return base_title if @title.blank?
        "#{base_title} | #{@title}"
    end



    def flash_message(message, klass)
        content_tag(:div,class: "alert alert-#{klass}") do
            concat content_tag(:button, '', class: 'close', data: { dismiss: 'alert'
                               })
            concat raw(message)
        end
    end
end

