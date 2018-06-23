# QuickAlertJp

事前準備
-----
Twitter API キーが必要です。`.env.local.sample`を参考に環境変数を読み込んでください。


使い方
-----
```ruby
require "./lib/earthquake_manager"
include QuickAlertJp

# setup
EarthquakeManager.setup

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
```

注意（重要）
---------

情報源の現在の実装は、Twitter API の `filter.json`※1を利用して、`@eewbot`(緊急地震速報Botさま※2)から取得します。貴重な情報の提供に感謝致します。

その性格上、Twitter API の仕様変更・廃止や、上記アカウントの運用状況に強く依存するために、商用利用には全く向いていません。

また、本ライブラリは上記運用アカウントとは何ら関係はありませんので、このライブラリに関する質問を情報提供元へすることはお控えください。

- ※1: https://developer.twitter.com/en/docs/tweets/filter-realtime/api-reference/post-statuses-filter.html

- ※2: https://twitter.com/eewbot
