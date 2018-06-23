require "./lib/alert_source_base"

module QuickAlertJp
  class AlertManager
    @@_alert_sources = []
    @@_alert_queue = Queue.new

    # = self.set_alert_source
    def self.add_alert_source(as)
      raise ArgumentError, "#{as} is not class." unless as.is_a?(Class)
      raise ArgumentError, "#{as} is not kind of AlertSource class." unless as.new(@@_alert_queue).kind_of?(AlertSource)
      raise ArgumentError, "already added #{as}" if @@_alert_sources.include?(as)
      @@_alert_sources << as
    end

    # = self.watch
    def self.watch(&block)
      raise RuntimeError "No set alert source." if (@@_alert_sources.empty?)

      # each watch alert source
      @@_alert_sources.each do |as|
        Thread.new do
          alert_source = as.new(@@_alert_queue)
          loop do
            alert_source.watch
          end
        end
      end

      # watch queue
      while alert = @@_alert_queue.pop
        block.call(alert)
      end
    end
  end
end
