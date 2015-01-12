#Home Automation Command Interface:

Likely conventions:
 - \[Service\] \[Action\] \[Settings\] *in* \[Location\]  \(Functional\)
   - "Lights on in master bedroom"
   - "Lights on in backyard"
   - "Temperature set to 76 degrees in house"
 - \(Turn\)? \[Action\] \(the\)? \[Service\] \(to \[Settings\]\)? *in* \(the\)? \[Location\]
   - "Set the temperature to 76 degrees in the bedroom"
   - "Set temperature to 76 degrees in bedroom"
   - "Turn on the lights in the kitchen"
   - "Turn off lights in kitchen"
 - \[Location\] \[Service\] \[Action\] \[Settings\]
   - Fallthrough for lack of *in* keyword
   - "Kitchen lights on"
   - "Pool temperature set to eighty degrees"

Thoughts behind these convention:

 - *In* is a keyword to target Location. 
 - Service must be a single noun. 
 - Action must be a single verb. 
 - Settings are optional and determined by words between Action and "in" keyword.
 - Locations are optional (though this might make things more difficult to determine between convention 1 and 3 in cases)
 - In all conventions, *in* is defined at the later half of the command, and always followed only by [Location], if it exists.
 - In the second convention, the first word must be *Turn|Set*. This will dictate this method of parsing the command. It makes sense for binary actions [on|off] to use *Turn*. It makes sense for commands containing settings to use *Set* as the first word.
 - This should cover the majority of (at least my families) use-cases and common sentence syntax.

TODO:

 - Compound locations: "Lights on in the pool and the spa"
 - Support multiple labels, and define ServiceControllers by label and location (different Controllers used for indoor lights vs. pool lights vs. backyard lights)

##\[Service\] \(required\)
Directs to which service API to use, as home automation systems seem to target a specific service.

 - Lights -> Hue API (http://www2.meethue.com/en-us/)
 - Temperature -> Nest API (https://nest.com/)

##\[Action\] \(required\)
Maps to a service API endpoint

 - On -> \[Hue_API\]/turn_on
 - On -> \[Nest_API\]/turn_on

Obviously the API endpoints won't be the same, so would need an abstract interface that each 'Service' subclass must extend and implement for method #on.

##Configuration
```ruby
Homer.config do |homer|
  homer.define :labels => "lights", :locations => ["kitchen", "bedroom"], Homer::Hue
end
```

##\[Location\] \(optional\)
Location has a default (example, "house"). If no Location is specified in the command, use the default.

Location grouping:
has_many :locations

 - House.locations = \[Living room, Dining room, kitchen, bedroom 1, bedroom 2, etc\]

