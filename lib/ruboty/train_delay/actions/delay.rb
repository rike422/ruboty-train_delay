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
        class << self
          def train_list
            @train_list ||= []
          end

          def create_train_list
            Ruboty::TrainDelay::AREA_SET.values.each do |area|
              Nokogiri::HTML(open(list_url(area)))
              .css("#mdAreaMajorLine .elmTblLstLine > table tr a")
              .map do |a|
                data = { name: a.content, href: a.attributes["href"].value }
                train_list.push data
              end
            end
          end

          def list_url(area_code)
            "https://transit.yahoo.co.jp/traininfo/area/#{area_code}/"
          end
        end

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

        def route
          message[:route]
        end

        def cause_delay(route)
          Nokogiri::HTML(open(route[:href]))
          .css('#mdServiceStatus p').text
        end

        def delay_list
          self.class.train_list
          .select { |site| site[:name].include? route }
        end

        def found_route
          <<-"EOS"
  知らない路線です。
  #{list_url}
  から探してください。
          EOS
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

Ruboty::TrainDelay::Actions::Delay.create_train_list
