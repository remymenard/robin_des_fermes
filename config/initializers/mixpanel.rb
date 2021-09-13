require 'mixpanel-ruby'

eu_consumer = Mixpanel::Consumer.new(
  'https://api-eu.mixpanel.com/track',
  'https://api-eu.mixpanel.com/engage',
  'https://api-eu.mixpanel.com/groups',
)
$tracker = Mixpanel::Tracker.new(ENV["MIXPANEL_TOKEN"]) do |type, message|
  eu_consumer.send!(type, message)
end
