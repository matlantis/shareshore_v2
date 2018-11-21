module SearchesHelper
  class TransportModel
    attr_accessor :transport

    def initialize(transport)
      self.transport = transport
    end

    def self.list_transport_models
      ["foot", "bike", "car", "rocket"]
    end

    def self.list
      transport_models = list_transport_models
      transport_models.map do |m|
        TransportModel.new(m)
      end
    end

    def self.image(transport)
      transport + ".png"
    end

    def self.text(transport)
      I18n.t("searches.transport_models." + transport)
    end

    def text
      TransportModel.text(self.transport)
    end

    def self.radius(transport)
      case transport
      when "foot"
        1.0
      when "bike"
        5.0
      when "car"
        20.0
      else # rocket
        10000
      end
    end

    def radius
      self.radius(self.transport)
    end
  end
end
