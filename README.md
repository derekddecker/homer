#Home Automation Command Interface:

[Service] [Action] [Settings] in [Location]

Examples: 
 - Lights on in master bedroom
 - Lights on in backyard
 - Temperature set to 76 degrees in house

Thoughts behind this convention:
 - Ease of parsing, as locations often contain multiple words. "in" is a keyword to target Location. Service must be a single noun. Action must be a single verb. Settings are optional and determined by words between Action and "in" keyword.

##[Service] 
Directs to which service API to use, as home automation systems seem to target a specific service.

 - Lights -> Hue API (http://www2.meethue.com/en-us/)
 - Temperature -> Nest API (https://nest.com/)

##[Action]
Maps to a service API endpoint

 - On -> [Hue_API]/turn_on
 - On -> [Nest_API]/turn_on

Obviously the API endpoints won't be the same, so would need an abstract interface that each 'Service' subclass must extend and implement for method #on.

##[Location] 
Location grouping:
has_many :locations

 - House.locations = [Living room, Dining room, kitchen, bedroom 1, bedroom 2, etc]

