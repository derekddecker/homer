#Homer (Ruby Home)
##A Home Automation Command Router

Parses and routes a natural speech text commands into a ServiceController action, which can be implemented to proxy to a home automation API, or really do whatever you want. Multiple requests can be sent in a single command to 1 or more ServiceControllers. The result responses are returned in a CompoundResponse object.

Some details on what Homer does:

 - Parses a natural text phrase and attempts to route it to a configured ServiceController action
 - Labels (for services), supported locations, and the ServiceController to direct to are defined via a configuration [DSL](#dsl).
 - Action must be a single verb (on, off, set).
 - Can have multiple services (nouns) (lights, temperature). 
 - Settings are everything in the phrase minus Locations, Action, and Services (and some extra useless words like 'the', 'and', 'in').
 - Locations are an optional array and can be an array of locations.

##DSL
Given the following config, you can expect Homer to handle the following examples as described below:

```ruby
Homer.config do |homer|
  homer.define :labels => "lights", :locations => ["kitchen", "bedroom", "master bedroom"], :class => Homer::Hue
end
```

 - "Lights on in master bedroom"
   - Route to Homer::Hue#on
   - Location => ["master bedroom"]
   - Settings => []
 - "Lights on in backyard"
 - "Temperature set to 76 degrees in house"
 - "Set the temperature to 76 degrees in the bedroom and the pool"
 - "Set temperature to 76 degrees in bedroom"
 - "Turn on the lights in the kitchen"
 - "Turn off lights in kitchen"
 - "Kitchen lights on"
 - "Pool temperature set to eighty degrees"

##\[Service\] \(required\)
Directs to which service API to use, as home automation systems seem to target a specific service.

 - Lights -> Hue API (http://www2.meethue.com/en-us/)
 - Temperature -> Nest API (https://nest.com/)

##\[Action\] \(required\)
Maps to a service API endpoint

 - On -> \[Hue_API\]/turn_on
 - On -> \[Nest_API\]/turn_on

Obviously the API endpoints won't be the same, so would need an abstract interface that each 'Service' subclass must extend and implement for method #on.

##\[Location\] \(optional\)
Location has a default (example, "house"). If no Location is specified in the command, use the default.

Location grouping:
has_many :locations

 - House.locations = \[Living room, Dining room, kitchen, bedroom 1, bedroom 2, etc\]

