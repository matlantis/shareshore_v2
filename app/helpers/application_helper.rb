module ApplicationHelper
  def underscore(txt)
    txt.squish.downcase.tr(" ","_")
  end

  def tipp_panel(title: t("common.title_tip_panel"), &block)
    capture do
      content_tag :div, class: ["tip-panel", "panel","panel-default"] do
        
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
        txt1 = content_tag :span, "", class: "glyphicon glyphicon-refresh", data_toggle: "tooltip", title: Article.human_attribute_name('rate')
        if article.gratis
          txt2 = content_tag :strong, Article.human_attribute_name('gratis')
        else
          txt2 = article.rate
        end
        txt1.concat(" ").concat(txt2)
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
          if article.stockitem_id
            txt1.concat(" ").concat(article.stockitem.title)
          else
            txt1.concat(" ").concat(article.title)
          end
        end
      end
    end
  end

  def articles_count(articles)
    articles.count.to_s + " " + I18n.t('activerecord.models.article', count: articles.count)
  end
end
