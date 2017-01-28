module SearchesHelper
  class Howto
    attr_accessor :howto
    
    def initialize(howto)
      self.howto = howto
    end

    def self.list_howtos
      ["foot", "bike", "car"]
    end
    
    def self.list
      howtos = list_howtos
      howtos.map do |m|
        Howto.new(m)
      end
    end

    def self.image(howto)
      howto + ".png"
    end

    def self.text(howto)
      I18n.t("searches.howtos." + howto)
    end
    
    def text
      Howto.text(self.howto)
    end

    def self.radius(howto)
      case howto
      when "foot"
        1.0
      when "bike"
        5.0
      when "car"
        20.0
      else
        raise "Unknown Howto"
      end
    end

    def radius
      self.radius(self.howto)
    end
  end
end
