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

  def location_marker(location, text: nil)
    zoom = 18
    #link_ref = "http://www.openstreetmap.org/?mlat=#{location.latitude}&mlon=#{location.longitude}#map=#{zoom}/#{location.latitude}/#{location.longitude}"
    if not text
      text = location.shortaddress
    end
    capture do
      content_tag :span, class: "location_marker" do
        link_to location do
          txt1 = content_tag :span, "", class: "glyphicon glyphicon-map-marker"
          txt2 = content_tag :strong, text
          txt1.concat(txt2)
        end
      end
    end
  end

  def house_marker(house, text: nil)
    zoom = 18
    #link_ref = "http://www.openstreetmap.org/?mlat=#{location.latitude}&mlon=#{location.longitude}#map=#{zoom}/#{location.latitude}/#{location.longitude}"
    if not text
      text = house.shortaddress
    end
    capture do
      content_tag :span, class: "house_marker" do
        link_to house do
          txt1 = content_tag :span, "", class: "glyphicon glyphicon-home"
          txt2 = content_tag :strong, text
          txt1.concat(" ").concat(txt2)
        end
      end
    end
  end
  
  def rate_marker(article)
    capture do
      content_tag :span, class: "rate_marker" do
        if article.gratis
          txt1 = content_tag :strong, t("Gratis")
          txt1.concat(content_tag :span, "", class: ["glyphicon","glyphicon-ok"])
        else
          txt1 = content_tag :span, "", class: "glyphicon glyphicon-refresh"
          txt1.concat(" ").concat(article.rate)
        end
      end
    end
  end

  def user_marker(user)
    capture do
      content_tag :span, class: "user_marker" do
        link_to user_path(user) do
          txt1 = content_tag :span, "", class: "glyphicon glyphicon-user"
          txt1.concat(" ").concat(user.nickname)
        end
      end
    end
  end

  def article_marker_modal(article)
    article_show_id = "#article_" + article.id.to_s + "_show"
    capture do
      content_tag :span, class: "user_marker" do
        link_to article_show_id, data: { toggle: "modal" } do
          txt1 = content_tag :span, "", class: "glyphicon glyphicon-star"
          txt1.concat(" ").concat(article.title)
        end
      end
    end
  end
end
