require "./lib/earthquake_manager"
include QuickAlertJp

# setup
EarthquakeManager.setup
Thread.abort_on_exception = true # for debug

# setup area
EarthquakeManager.add_area(EarthquakeManager::Area.new("九州", 29.2, 128.1, 34.4, 132.3))
EarthquakeManager.add_area(EarthquakeManager::Area.new("九州", 29.2, 128.1, 34.4, 132.3))
EarthquakeManager.add_area(EarthquakeManager::Area.new("中国・四国", 29.5, 130.4, 35.4, 134.0))
EarthquakeManager.add_area(EarthquakeManager::Area.new("近畿", 31.5, 134.1, 35.5, 136.5))
EarthquakeManager.add_area(EarthquakeManager::Area.new("中部・東海・北陸", 33.2, 136.6, 37.5, 139.3))
EarthquakeManager.add_area(EarthquakeManager::Area.new("関東", 33.3, 138.4, 37.4, 143.4))
EarthquakeManager.add_area(EarthquakeManager::Area.new("東北・中越・上越", 37.4, 137.3, 41.1, 144.3))
EarthquakeManager.add_area(EarthquakeManager::Area.new("北海道", 40.2, 138.2, 45.4, 148.1))

# watch
EarthquakeManager.watch do |alert, areas|
  puts "地震です。#{alert.inspect}"
  areas.each do |area|
    puts area.name
  end
end
