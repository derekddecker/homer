require 'treat'
require 'stanford-core-nlp'
StanfordCoreNLP.load(:tokenize, :ssplit, :pos, :lemma, :parse, :ner, :dcoref)

module Homer
  class NLP
    include Treat::Core::DSL

    module Tags
      
      module Words
        VERBS = [
          # verb, base form
          # ask assemble assess assign assume atone attention avoid bake 
          # balkanize bank begin behold believe bend benefit bevel beware 
          # bless boil bomb boost brace break bring broil brush build ...
          'VB',
         
          # verb, past tense 
          # dipped pleaded swiped regummed soaked tidied convened halted 
          # registered cushioned exacted snubbed strode aimed adopted 
          # belied figgered speculated wore appreciated contemplated ...
          'VBD', 
         
          # verb, present participle or gerund
          # telegraphing stirring focusing angering judging stalling 
          # lactating hankerin' alleging veering capping approaching 
          # traveling besieging encrypting interrupting erasing wincing ...
          'VBG',

          # verb, past participle
          # multihulled dilapidated aerosolized chaired languished panelized 
          # used experimented flourished imitated reunifed factored condensed 
          # sheared unsettled primed dubbed desired ...
          'VBN', 

          # verb, present tense, not 3rd person singular
          # predominate wrap resort sue twist spill cure lengthen brush 
          # terminate appear tend stray glisten obtain comprise detest 
          # tease attract emphasize mold postpone sever return wag ...
          'VBP', 

          # verb, present tense, 3rd person singular
          # bases reconstructs marks mixes displeases seals carps weaves 
          # snatches slumps stretches authorizes smolders pictures emerges 
          # stockpiles seduces fizzes uses bolsters slaps speaks pleads ...
          'VBZ'
        ]

        DETERMINERS = [
          # determiner
          # all an another any both del each either every half la many 
          # much nary neither no some such that the them these this those
          'DT', 

          # WH-determiner
          # that what whatever which whichever
          'WDT', 

          # pre-determiner
          # all both half many quite such sure this
          'PDT'
        ]

        # kitchen, pool, living room
        NOUNS = [
          # noun, common, singular or mass
          # common-carrier cabbage knuckle-duster Casino afghan shed 
          # thermostat investment slide humour falloff slick wind hyena 
          # override subhumanity machinist ...
          'NN',

          # noun, proper, singular
          # Motown Venneboerger Czestochwa Ranzer Conchita Trumplane Christos 
          # Oceanside Escobar Kreisler Sawyer Cougar Yvette Ervin ODI Darryl 
          # CTCA Shannon A.K.C. Meltex Liverpool ...
          'NNP',

          # noun, proper, plural
          # Americans Americas Amharas Amityvilles Amusements 
          # Anarcho-Syndicalists Andalusians Andes Andruses Angels Animals 
          # Anthony Antilles Antiques Apache Apaches Apocrypha ...
          'NNPS',

          # noun, common, plural
          # undergraduates scotches bric-a-brac products bodyguards facets 
          # coasts divestitures storehouses designs clubs fragrances averages 
          # subjectivists apprehensions muses factory-jobs ...
          'NNS'
        ]
        
        # on, in, to
        PREPOSITIONS = [
          # preposition or conjunction, subordinating
          # astride among uppon whether out inside pro despite on by throughout 
          # below within for towards near behind atop around if like until 
          # below next into if beside ...
          'IN', 
        
          # "to" as preposition or infinitive marker
          # to  
          'TO'
        ]
      end # Words

     end

    def self.parse(nl)
      @entity = nl.tokenize.parse
    end

  end
end
