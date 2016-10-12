module ApplicationHelper
  def underscore(txt)
    txt.squish.downcase.tr(" ","_")
  end
end
