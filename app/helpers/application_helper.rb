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
    if not text
      text = location.address
    end
    if !user_signed_in?
      text = t('common.log_in_to_see')
    end
    capture do
      unless location
        content_tag :em, t('common.unknown_location')
      else
        content_tag :span, class: "location_marker" do
          #link_to location do
          txt1 = content_tag :span, "", class: "glyphicon glyphicon-map-marker"
          txt2 = text
          txt1.concat(txt2)
          #end
        end
      end
    end
  end

  def house_marker(house, text: nil)
    zoom = 18
    if not text
      text = house.address
    end
    if !user_signed_in?
      text = t('common.log_in_to_see')
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
    content_tag(:span, " ", class: "rate-model-" + article.rate) +
      t("articles.rate_models." + article.rate) +
      " " +
      content_tag(:sup ,("(" + link_to("?", "/pages/rate") + ")").html_safe)
  end

  def user_marker(user)
    capture do
      unless user
        content_tag :em, t('common.unknown_user')
      else
        content_tag :span, class: "user_marker" do
          link_to user do
            txt1 = content_tag :span, "", class: "glyphicon glyphicon-user"
            txt1.concat(" ").concat(user.nickname)
          end
        end
      end
    end
  end

  def article_marker(article)
    article_show_id = "#article-" + article.id.to_s + "-show"
    capture do
      unless article
        content_tag :em, t('common.unknown_article')
      else
        content_tag :span, class: "user_marker" do
          link_to article do
            txt1 = ""
            txt1.concat(" ").concat(article.title)
          end
        end
      end
    end
  end

  def articles_count(articles)
    articles.count.to_s + " " + I18n.t('activerecord.models.article', count: articles.count)
  end

  def articles_location_count(location)
    location.articles.count.to_s + " " + I18n.t('activerecord.models.article', count: location.articles.count)
  end

  def articles_location_count_link(location)
    link_to articles_location_path(location) do
      articles_location_count(location)
    end
  end

  def locations_count(locations)
    locations.count.to_s + " " + I18n.t('activerecord.models.location', count: locations.count)
  end

  def mail_subject_user_message(article, user)
    if article
      if user
        subject = t("mail.subject_article_request_username", user: user.nickname, article: article.title)
      else
        subject = t("mail.subject_article_request_anonymous", article: article.title)
      end
    else
      if user
        subject = t("mail.subject_message_username", user: user.nickname)
      else
        subject = t("mail.subject_message_anonymous")
      end
    end
  end

  def edit_icons(item)
    if user_signed_in? && (current_user.id == item.user.id)
      txt1 = link_to("", "", class: "glyphicon glyphicon-pencil edit-remove mp-toggle-visibility", data: { toggle_target: "#article-#{item.id}-div .article-edit", toggle: "tooltip"} , title: t('button.edit') )
      txt2 = link_to("", item, method: :delete, data: { confirm: t(".delete_confirmation_question") }, class: "glyphicon glyphicon-remove edit-remove", data_toggle: "tooltip", title: t('button.remove'), remote: true)
      txt1.concat(txt2)
    end
  end

  def home_icon
    content_tag :span, "", class: "glyphicon glyphicon-home", data_toggle: "tooltip", title: t('articles.common.tooltip_home')
  end

  def gratis_icon
    content_tag :span, "", class: "glyphicon glyphicon-heart", data_toggle: "tooltip", title: Article.human_attribute_name('gratis')
  end

  def transport_icon(transport_model)
    content_tag :span, "", class: "transport-model-" + transport_model
  end

  def rate_icon(rate_model)
    content_tag :span, "", class: "rate-model-" + rate_model, data_toggle: "tooltip", title: t("articles.rate_models." + rate_model)
  end

  def distance_label_time(home, loc1, loc2)
    if home
      content_tag :strong, t('articles.common.tooltip_home')
    else
      distance = loc2.distance_from( loc1 )
      if distance < SearchesHelper::TransportModel.radius("foot")
        time = (distance / 3 * 60).round
        txt = " ~ " + time.to_s + " min"
        model = "foot"
      elsif distance < SearchesHelper::TransportModel.radius("bike")
        time = (distance / 15 * 60).round
        txt = " ~ " + time.to_s + " min"
        model = "bike"
      elsif distance < SearchesHelper::TransportModel.radius("car")
        time = (distance / 75 * 60).round
        txt = " ~ " + time.to_s + " min"
        model = "car"
      else
        txt = t('locations.common.label_distance') + ": %.1f km" % distance
        model = "rocket"
      end
      tooltip = "%.1f km (%s)" % [distance, I18n.t('searches.transport_models.' + model)]
      content_tag :span,  data_toggle: "tooltip", title: tooltip do
        transport_icon(model) + txt
      end
    end
  end

  def distance_label(home, loc1, loc2)
    if home
      content_tag :strong, t('articles.common.tooltip_home')
    else
      distance = loc2.distance_from( loc1 )
      if distance < SearchesHelper::TransportModel.radius("foot")
        txt = "  ca. %i m" % [(distance * 100).round * 10]
        model = "foot"
      elsif distance < SearchesHelper::TransportModel.radius("bike")
        txt = "  ca. %.1f km" % [distance]
        model = "bike"
      elsif distance < SearchesHelper::TransportModel.radius("car")
        txt = "  ca. %i km" % [(distance / 10).round * 10]
        model = "car"
      else
        txt = "  ca. %f km" % [(distance / 100).round * 100]
        model = "rocket"
      end
      tooltip = I18n.t("searches.good_with_" + model)
      content_tag :span,  data_toggle: "tooltip", title: tooltip do
        transport_icon(model) + txt
      end
    end
  end

  def search_transport_radius(transport)
    t("searches.transport_models." + transport) + ": " + I18n.t('searches.transport_radius_explanation', radius: "%.0f" % SearchesHelper::TransportModel.radius(transport))
  end

  def create_map_house_marker(articles, house, house_center = nil)
    local_articles = articles.joins(:location).where("locations.house_id = ?", house.id)
    html_text = escape_javascript(render 'articles/popup', house: house, articles: local_articles )
    if false && house == house_center
      home_html = "<br>" + html_text
      home_id = house.id
    else
      ("{ coords: [#{house.latitude}, #{house.longitude} ], " +
       " html: '#{html_text}', " +
       " id: #{house.id}, " +
       " color: 'red' }").html_safe
    end
  end

  def create_map_house_markers(articles, houses, house_center)
    if user_signed_in?
      txt = houses.map { |house|
        create_map_house_marker(articles, house, house_center)
      }.join(",").html_safe
    end
  end

  def create_map_current_location_marker(current_location)
    # save text for home marker
    home_html = "#{@current_location.address}"
    home_id = -1

    ("{ coords: [#{@current_location.latitude}, #{@current_location.longitude} ], " +
     " html: '<strong>#{t('articles.map.marker_your_location')}</strong><br>#{home_html}', " +
     " id: #{home_id}, " +
     " color: 'blue' }").html_safe
  end

  def submit_icon
    content_tag :button, type: "submit", class: "submit-with-icon" do
      content_tag :div, "", class: "glyphicon glyphicon-ok", data_toggle: "tooltip", title: t('button.save')
    end
  end
end

def determine_owner(article)
  if article.new_record?
    owner = current_user
  else
    owner = article.location.user
  end
end
