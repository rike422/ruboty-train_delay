require "nokogiri"
require "open-uri"

module Ruboty
  module TrainDelay
    AREA_SET = {
      "北海道": 2,
      "東北": 3,
      "関東": 4,
      "中部": 5,
      "近畿": 6,
      "九州": 7,
      "中国": 8,
      "四国": 9
    }

    module Actions
      class Delay < Ruboty::Actions::Base
        def call
          list = delay_list
          return message.reply(found_route) if list.length == 0
          return message.reply(many_route(list)) if list.length > 1
          message.reply("#{list.first[:name]}: #{cause_delay(list.first)}")
        rescue OpenURI::HTTPError => e
          message.reply("情報を取得することができませんでした。URLが正しいか確認してください。")
          message.reply("今回使用したURL:#{list_url}")
        end

        private

        def area
          return "関東" unless message.match_data.names.include? "area"
          message[:area]
        end

        def route
          message[:route]
        end

        def area_code
          Ruboty::TrainDelay::AREA_SET[area.to_sym]
        end

        def cause_delay(route)
          Nokogiri::HTML(open(route[:href]))
          .css('#mdServiceStatus p').text
        end

        def delay_list
          doc = Nokogiri::HTML(open(list_url))
          .css("#mdAreaMajorLine .elmTblLstLine > table tr a")
          .map { |a| { name: a.content, href: a.attributes["href"].value } }
          .select { |site| site[:name].include? route }
        end

        def found_route
          <<-"EOS"
  知らない路線です。
  #{list_url}
  から探してください。
          EOS
        end

        def list_url
          "http://transit.loco.yahoo.co.jp/traininfo/area/#{area_code}/"
        end

        def many_route(routes)
          <<-"EOS"
絞り込めませんね。下のどれかでしょうか？
#{routes.map { |route| "  * #{route[:name]}" }.join("\n") }
          EOS
        end
      end
    end
  end
end
