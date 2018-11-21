# coding: utf-8
module ArticlesHelper
  class RateModel
    attr_accessor :model

    def initialize(model)
      self.model = model
    end

    def self.list_models
      [ "smile", "chocolate", "wine", "theater", "rocket", "special" ]
    end

    def self.list
      models = list_models
      models.map do |m|
        RateModel.new(m)
      end
    end

    def self.image(model)
      model + ".png"
    end

    def text
      I18n.t("articles.rate_models." + self.model)
    end
  end
end
