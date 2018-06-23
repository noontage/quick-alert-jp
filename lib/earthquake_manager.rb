require "./lib/alert_manager"
require "./lib/alert_source_earthquake_twitter"

module QuickAlertJp
  class EarthquakeManager
    @@_areas = []

    # = Area
    class Area
      attr_accessor :name
      attr_accessor :min_lat
      attr_accessor :min_long
      attr_accessor :max_lat
      attr_accessor :max_long

      def initialize(name, min_lat, min_long, max_lat, max_long)
        @name = name
        @min_lat = min_lat
        @min_long = min_long
        @max_lat = max_lat
        @max_long = max_long
      end
    end

    # = self.setup
    def self.setup
      AlertManager.add_alert_source(AlertSourceEarthquakeTwitter)
    end

    # = self.watch
    def self.watch(&block)
      AlertManager.watch do |alert|
        if alert[:type] == :earth_quake_alert
          area = detect_areat(alert[:n_lat], alert[:e_long])
          block.call(alert, area)
        end
      end
    end

    # = self.add_area
    def self.add_area(area)
      raise ArgumentError, "No kind_of EarthquakeManager::Area" unless area.is_a?(Area)
      @@_areas << area
    end

    private

    # = self.detect_areat
    def self.detect_areat(n_lat, e_long)
      lat = n_lat.to_f
      long = e_long.to_f

      return (@@_areas.select do |area|
               (lat >= area.min_lat && lat <= area.max_lat && long >= area.min_long && long <= area.max_long)
             end)
    end
  end
end
