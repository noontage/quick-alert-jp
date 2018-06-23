require "./lib/alert_source_base"
require "./lib/twitter_manager"

module QuickAlertJp
  class AlertSourceEarthquakeTwitter < AlertSource
    TWITTER_EEWBOT_ID = "214358709" # 緊急地震速報Bot(@eewbot)
    @watch_ids = [
      TWITTER_EEWBOT_ID,
    ]

    def initialize(quque)
      @quque = quque
      TwitterManager.setup
      if (ENV["QAJP_TW_TEST_ID"])
        @watch_ids << ENV["QAJP_TW_TEST_ID"]
      end
    end

    def watch
      TwitterManager.watch(@watch_ids) do |tweet_text|
        parse(tweet_text)
      end
    end

    private

    def parse(tweet_text)
      type, training, date, status, number, eq_id, occur_date, n_lat, e_long, location, depth, magnitude, scale, is_sea, is_warning = tweet_text.split(",")
      return unless (training == "00" && (type == "35" || type == "36" || type == "37")) # 訓練は無視

      # アラート
      if (type != "39")
        is_sea = (is_sea == "1") ? true : false
        is_warning = (is_warning == "1") ? true : false
        @quque << {
          type: :earth_quake_alert,
          date: date,
          status: status,
          number: number,
          eq_id: eq_id,
          occur_date: occur_date,
          n_lat: n_lat,
          e_long: e_long,
          location: location,
          depth: depth,
          magnitude: magnitude,
          scale: scale,
          is_sea: is_sea,
          is_warning: is_warning,
        }
      else
        @quque << {
          type: :earth_quake_alert_cancel,
        }
      end
    end
  end
end
