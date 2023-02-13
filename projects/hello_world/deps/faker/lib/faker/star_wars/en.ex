defmodule Faker.StarWars.En do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for generating StarWars related data in English
  """

  @doc """
  Returns a Star Wars character name in English

  ## Examples

      iex> Faker.StarWars.En.character()
      "Greedo"
      iex> Faker.StarWars.En.character()
      "Jek Tono Porkins"
      iex> Faker.StarWars.En.character()
      "Poe Dameron"
      iex> Faker.StarWars.En.character()
      "R4-P17"
  """
  @spec character() :: String.t()
  sampler(:character, [
    "Luke Skywalker",
    "C-3PO",
    "R2-D2",
    "Darth Vader",
    "Leia Organa",
    "Owen Lars",
    "Beru Whitesun Lars",
    "R5-D4",
    "Biggs Darklighter",
    "Obi-Wan Kenobi",
    "Anakin Skywalker",
    "Wilhuff Tarkin",
    "Chewbacca",
    "Han Solo",
    "Greedo",
    "Jabba Desilijic Tiure",
    "Wedge Antilles",
    "Jek Tono Porkins",
    "Yoda",
    "Palpatine",
    "Boba Fett",
    "IG-88",
    "Bossk",
    "Lando Calrissian",
    "Lobot",
    "Ackbar",
    "Mon Mothma",
    "Arvel Crynyd",
    "Wicket Systri Warrick",
    "Nien Nunb",
    "Qui-Gon Jinn",
    "Nute Gunray",
    "Finis Valorum",
    "Jar Jar Binks",
    "Roos Tarpals",
    "Rugor Nass",
    "Ric Olié",
    "Watto",
    "Sebulba",
    "Quarsh Panaka",
    "Shmi Skywalker",
    "Darth Maul",
    "Bib Fortuna",
    "Ayla Secura",
    "Dud Bolt",
    "Gasgano",
    "Ben Quadinaros",
    "Mace Windu",
    "Ki-Adi-Mundi",
    "Kit Fisto",
    "Eeth Koth",
    "Adi Gallia",
    "Saesee Tiin",
    "Yarael Poof",
    "Plo Koon",
    "Mas Amedda",
    "Gregar Typho",
    "Cordé",
    "Cliegg Lars",
    "Poggle the Lesser",
    "Luminara Unduli",
    "Barriss Offee",
    "Dormé",
    "Count Dooku",
    "Bail Prestor Organa",
    "Jango Fett",
    "Zam Wesell",
    "Dexter Jettster",
    "Lama Su",
    "Taun We",
    "Jocasta Nu",
    "Ratts Tyerell",
    "R4-P17",
    "Wat Tambor",
    "San Hill",
    "Shaak Ti",
    "Grievous",
    "Tarfful",
    "Raymus Antilles",
    "Sly Moore",
    "Tion Medon",
    "Finn",
    "Rey",
    "Poe Dameron",
    "BB8",
    "Captain Phasma",
    "Padmé Amidala",
    "Enfys Nest"
  ])

  @doc """
  Returns a Star Wars planet name in English

  ## Examples

      iex> Faker.StarWars.En.planet()
      "Mon Cala"
      iex> Faker.StarWars.En.planet()
      "Ryloth"
      iex> Faker.StarWars.En.planet()
      "Endor"
      iex> Faker.StarWars.En.planet()
      "Shili"
  """
  @spec planet() :: String.t()
  sampler(:planet, [
    "Alderaan",
    "Aleen Minor",
    "Bespin",
    "Bestine IV",
    "Cato Neimoidia",
    "Cerea",
    "Champala",
    "Chandrila",
    "Concord Dawn",
    "Corellia",
    "Coruscant",
    "Dagobah",
    "Dantooine",
    "Dathomir",
    "Dorin",
    "Endor",
    "Eriadu",
    "Felucia",
    "Geonosis",
    "Glee Anselm",
    "Haruun Kal",
    "Hoth",
    "Iktotch",
    "Iridonia",
    "Jakku",
    "Kalee",
    "Kamino",
    "Kashyyyk",
    "Malastare",
    "Mirial",
    "Mon Cala",
    "Mustafar",
    "Muunilinst",
    "Mygeeto",
    "Naboo",
    "Nal Hutta",
    "Ojom",
    "Ord Mantell",
    "Polis Massa",
    "Quermia",
    "Rodia",
    "Ryloth",
    "Saleucami",
    "Serenno",
    "Shili",
    "Skako",
    "Socorro",
    "Stewjon",
    "Sullust",
    "Tatooine",
    "Tholoth",
    "Toydaria",
    "Trandosha",
    "Troiken",
    "Tund",
    "Umbara",
    "Utapau",
    "Vulpter",
    "Yavin IV",
    "Zolan"
  ])

  @doc """
  Returns a Star Wars quote in English

  ## Examples

      iex> Faker.StarWars.En.quote()
      "Congratulations. You are being rescued. Please do not resist."
      iex> Faker.StarWars.En.quote()
      "What chance do we have? The question is 'what choice'. Run, hide, plead for mercy, scatter your forces. You give way to an enemy this evil with this much power and you condemn the galaxy to an eternity of submission. The time to fight is now!"
      iex> Faker.StarWars.En.quote()
      "Will someone get this big walking carpet out of my way?"
      iex> Faker.StarWars.En.quote()
      "To be Jedi is to face the truth, and choose. Give off light, or darkness, Padawan. Be a candle, or the night."
  """
  @spec quote() :: String.t()
  sampler(:quote, [
    "I've got a bad feeling about this.",
    "There's always a bigger fish.",
    "Fear is the path to the Dark Side. Fear leads to anger, anger leads to hate, hate leads to suffering.",
    "Who's the more foolish: the fool, or the fool who follows him?",
    "No! Try not. Do, or do not. There is no try.",
    "Lost a planet, Master Obi-Wan has. How embarrassing. How embarrassing.",
    "Death is a natural part of life. Rejoice for those around you who transform into the Force.",
    "Hokey religions and ancient weapons are no match for a good blaster at your side, kid.",
    "When you look at the dark side, careful you must be ... for the dark side looks back.",
    "Size matters not. Look at me. Judge me by my size, do you?",
    "Women always figure out the truth. Always.",
    "Senators, I presume you are acquainted with the collection of half-truths and hyperbole known as Obi-Wan Kenobi?",
    "If there's a bright center to the universe, you're on the planet that it's farthest from.",
    "The fear of loss is a path to the Dark Side.",
    "Help me, Obi-Wan Kenobi; you're my only hope.",
    "Truly wonderful the mind of a child is.",
    "Someone has to save our skins. Into the garbage chute, fly boy.",
    "Yes, a Jedi's strength flows from the Force. But beware of the dark side. Anger, fear, aggression; the dark side of the Force are they. Easily they flow, quick to join you in a fight. If once you start down the dark path, forever will it dominate your destiny, consume you it will, as it did Obi-Wan's apprentice.",
    "It's true. All of it. The Dark Side, the Jedi. They're real.",
    "If we can make it to the ground, we'll take the next chance. And the next. On and on until we win ... or the chances are spent.",
    "I want to come with you to Alderaan. There's nothing for me here now. I want to learn the ways of the Force and become a Jedi like my father.",
    "Well, you tell them that Han Solo just stole back the Millennium Falcon, for good!",
    "This holiday is yours, where we all share with you the hope that this day brings us closer to freedom and to harmony and to peace. No matter how different we appear, we're all the same in our struggle against the powers of evil and darkness. I hope that this day will always be a day of joy, in which we can reconfirm our dedication and our courage. And more than anything else, our love for one another. This is the promise of the Tree of Life.",
    "May the Force be with you.",
    "I'm one with the Force, and the Force is with me.",
    "What if the democracy we thought we were serving no longer exists, and the Republic has become the very evil we've been fighting to destroy?",
    "A Jedi gains power through understanding and a Sith gains understanding through power.",
    "Only a Sith Lord deals in absolutes.",
    "I have lived long enough to see the same eyes in different people.",
    "Why, you stuck up, half-witted, scruffy-looking Nerf herder.",
    "How ya feeling kid? You don't look so bad to me. You look strong enough to pull the ears off a gundark.",
    "Aren't you a little short for a stormtrooper?",
    "Some day you're gonna be wrong, I just hope I'm there to see it.",
    "Will someone get this big walking carpet out of my way?",
    "On many long journeys have I gone. And waited, too, for others to return from journeys of their own. Some return; some are broken; some come back so different only their names remain.",
    "To be Jedi is to face the truth, and choose. Give off light, or darkness, Padawan. Be a candle, or the night.",
    "The Force will be with you ... always.",
    "You know, no matter how much we fought ... I've always hated watching you leave.",
    "There were a lot of explosions for two people blending in.",
    "It's against my programming to impersonate a deity.",
    "Always in motion is the future.",
    "The Force, it's calling to you. Just let it in.",
    "The Force is neither light nor dark, master nor slave, but a balance between extremes.",
    "Give yourself to the Dark Side. It is the only way you can save your friends. Yes, your thoughts betray you. Your feelings for them are strong. Especially for ... sister. So, you have a twin sister. Your feelings have now betrayed her, too. Obi-Wan was wise to hide her from me. Now his failure is complete. If you will not turn to the Dark Side ... then perhaps she will!",
    "Take care of yourself Han. I guess that's what you're best at isn't it?",
    "The more you tighten your grip, Tarkin, the more star systems will slip through your fingers.",
    "Would it help if I got out and pushed?",
    "Now don't get jittery, Luke. There are a lot of command ships. Keep your distance, though, Chewie, but don't look like you're trying to keeping your distance.",
    "To answer power with power, the Jedi way this is not. In this war, a danger there is, of losing who we are.",
    "You know what I always say... speak softly, and drive a big tank.",
    "If no mistake have you made, yet losing you are ... a different game you should play.",
    "Among the children of the Jedi, there are no innocents.",
    "This is a rebellion, isn't it? I rebel.",
    "The belonging you seek is not behind you ... it is ahead.",
    "There's no mystical energy field that controls my destiny.",
    "R2-D2, you know better than to trust a strange computer.",
    "Your eyes can deceive you; don't trust them.",
    "I think my eyes are getting better. Instead of a big dark blur, I see a big light blur.",
    "I don't know where you get your delusions, laser brain.",
    "Ah, strong am I with the Force, but not that strong. Twilight is upon me, and soon, night must fall. That is the way of things. The way of the Force.",
    "Look, I can't get involved. I've got work to do. It's not that I like the Empire; I hate it, but there's nothing I can do about it right now... It's all such a long way from here.",
    "Only a fully trained Jedi Knight, with the Force as his ally, will conquer Vader and his Emperor. If you end your training now - if you choose the quick and easy path as Vader did - you will become an agent of evil.",
    "Congratulations. You are being rescued. Please do not resist.",
    "I'm standing by as you requested, although there's a problem on the horizon. There's no horizon.",
    "The strongest stars have hearts of kyber.",
    "Well, trust a droid to get to the bottom of things.",
    "I need help with this giant hairy thing!",
    "I feel it again... The pull to the light... Supreme Leader senses it. Show me again... The power of the darkness... And I'll let nothing stand in our way... Show me... Grandfather... and I will finish... what you started.",
    "I fear nothing. For all is as the Force wills it.",
    "I'm not Resistance. I'm not a hero. I'm a stormtrooper. Like all of them, I was taken from a family I'll never know. And raised to do one thing. But my first battle, I made a choice. I wasn't gonna kill for them. So I ran. Right into you. And you looked at me like no one ever had. I was ashamed of what I was. But I'm done with the First Order. I'm never going back. Rey, come with me.",
    "What chance do we have? The question is 'what choice'. Run, hide, plead for mercy, scatter your forces. You give way to an enemy this evil with this much power and you condemn the galaxy to an eternity of submission. The time to fight is now!",
    "Be careful not to choke on your aspirations, Director.",
    "You're so lonely... So afraid to leave... At night, desperate to sleep... You imagine an ocean... I see it... I see the island... And Han Solo... You feel like he's the father you never had. He would have disappointed you."
  ])
end
