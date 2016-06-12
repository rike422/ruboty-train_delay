# Ruboty::TrainDelay

check train status by [Yahoo!路線情報](http://transit.yahoo.co.jp/traininfo/top)

hubot-script-verison: https://gist.github.com/rike422/0041ab1fdde2298f5094
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-train_delay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-train_delay

## Usage

```
> @ruboty delay 山手線
山手線: 現在､事故･遅延に関する情報はありません。
> @ruboty delay 小湊鉄道線
小湊鉄道線: 関東・東北豪雨の影響で、本日も月崎～上総中野駅間の運転を見合わせています。なお、バス代行輸送を行っています。
> @ruboty delay 中央
絞り込めませんね。下のどれかでしょうか？
  * 中央線(快速)[東京～高尾]
  * 中央総武線(各停)
  * 中央本線[高尾～大月]
> @ruboty delay JR神戸線 of 近畿
JR神戸線: 18:51頃、尼崎～立花駅間で発生した人身事故の影響で、現在も列車に遅れや運休が出ています。
> @ruboty 副都心線遅れてる？
東京メトロ副都心線: 現在､事故･遅延に関する情報はありません。
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ruboty-train_delay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
