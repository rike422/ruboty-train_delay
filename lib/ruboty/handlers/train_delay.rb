require "ruboty/train_delay/actions/delay"

module Ruboty
  module Handlers
    class TrainDelay < Base
      on(/delay (?<route>[^\s]+)?\z/,
       name: 'delay',
       description: ''
      )

      on(/delay (?<route>.+) of (?<area>[^\s]+)?\z/,
        name: 'delay',
        description: ''
      )

      on(/(?<route>.+)線遅れてる(\?|？)\z/,
       name: 'delay',
       description: ''
      )

      def delay(message)
        Ruboty::TrainDelay::Actions::Delay.new(message).call
      end
    end
  end
end
