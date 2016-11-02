module ApplicationHelper
  def underscore(txt)
    txt.squish.downcase.tr(" ","_")
  end

  def tipp_panel(title: "Tipp", &block)
    capture do
      content_tag :div, class: ["panel","panel-default"] do
        
        txt1 = content_tag :div, class: "panel-heading" do
          content_tag(:h4, title)
        end
        txt2 = content_tag :div, class: "panel-body" do
          capture(&block)
        end

        txt1.concat(txt2)
      end          
    end
  end
end
