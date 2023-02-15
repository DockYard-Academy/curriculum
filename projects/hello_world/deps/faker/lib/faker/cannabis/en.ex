defmodule Faker.Cannabis.En do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for generating Cannabis related data in English
  """

  @doc """
  Returns a Cannabis strain string

  ## Examples

      iex> Faker.Cannabis.En.strain()
      "Critical Kush"
      iex> Faker.Cannabis.En.strain()
      "Blue Dream"
      iex> Faker.Cannabis.En.strain()
      "Mr. Nice Guy"
      iex> Faker.Cannabis.En.strain()
      "Gorilla Glue"
  """
  @spec strain() :: String.t()
  sampler(:strain, [
    "24k",
    "Acapulco Gold",
    "ACDC",
    "Alien Diesel",
    "Banana OG",
    "Bio-Diesel",
    "Black Diamond OG",
    "Black Jack",
    "Blackberry Cookies",
    "Blackberry Soda",
    "Blackwater OG",
    "Blue Dream",
    "Blueberry Tangie",
    "Boss Hog",
    "Bubba Kush",
    "Cali Mist",
    "Candy Skunk",
    "Candyland",
    "Canna Sutra",
    "Cheese",
    "Chem Berry",
    "Cherry Cheese",
    "Cherry Lime",
    "Chocolate Hashberry",
    "Chronic",
    "Church OG",
    "Clementine",
    "Colfax Cookies",
    "Colfax Jack",
    "Colfax Platinum",
    "Critical Kush",
    "Diablo OG",
    "Double Dutch Bus",
    "Dutch Treat",
    "Forbidden Fruit",
    "Gelato",
    "Ghost OG",
    "Girl Scout Cookies",
    "Godzilla Glue",
    "Golden Strawberries",
    "Gooberry",
    "Gorilla Glue",
    "Gorilla Princess",
    "Granddaddy Purple Kush",
    "Grapefruit Kush",
    "Green Cobra",
    "Green Queen",
    "Hardcore Grapes",
    "Heavy OG",
    "Hell's OG",
    "Jack Frost",
    "Jack Herer",
    "Jack the Ripper",
    "Key Lime Pie",
    "King Kong OG",
    "King Louis OG",
    "Kings Reserve OG",
    "Koffee Cake",
    "Lemon Jack",
    "Lemon Meringue",
    "Lemon Skunk",
    "Lemonade",
    "Lime #5",
    "Lucky Charms",
    "Master OG",
    "Maui Jack",
    "Mendo Breath",
    "Mojito",
    "Moon Glue",
    "Mr. Nice Guy",
    "NY Sour Diesel",
    "Nectarine",
    "Novicane Kush",
    "Nug Salad",
    "OG Chem",
    "OG Kush",
    "OG Salad",
    "ONAC OG",
    "Panama Punch",
    "Pineapple Express",
    "Pineapple Sage",
    "Pinesol OG",
    "Pink Lotus",
    "Pitbull",
    "Platinum OG",
    "Presidential OG",
    "Private Reserve",
    "Purple Punch",
    "Queen Dream",
    "Rainbow Sherbet",
    "Raskal OG",
    "Redwood Bubba Kush",
    "Rude Boi OG",
    "Satellite OG",
    "Saturn OG",
    "Sherbert",
    "Skywalker OG",
    "Snozzberry OG",
    "Sonoma Glue",
    "Soul Assasin OG",
    "Soul Assassin",
    "Sour Cheese",
    "Strawberry Banana",
    "Strawberry Cough",
    "Strawberry Moonrocks",
    "Strawberry Shortcake",
    "Sugar Momma",
    "Sunset Sherbert",
    "Super Glue",
    "Super Jack",
    "Super Silver Haze",
    "Tangie",
    "Trainwreck",
    "Watermelon",
    "White Tahoe Cookies",
    "Whitewalker OG",
    "XJ-13"
  ])

  @doc """
  Returns a Cannabis cannabinoid string

  ## Examples

      iex> Faker.Cannabis.En.cannabinoid()
      "Cannabinol"
      iex> Faker.Cannabis.En.cannabinoid()
      "Cannabigerolic Acid"
      iex> Faker.Cannabis.En.cannabinoid()
      "Cannabinolic Acid"
      iex> Faker.Cannabis.En.cannabinoid()
      "Cannabicyclol"
  """
  @spec cannabinoid() :: String.t()
  sampler(:cannabinoid, [
    "Tetrahydrocannabinol",
    "Tetrahydrocannabinolic Acid",
    "Tetrahydrocannabivarin",
    "Cannabidiol",
    "Cannabidiolic Acid",
    "Cannabidivarin",
    "Cannabinol",
    "Cannabinolic Acid",
    "Cannabigerol",
    "Cannabigerolic Acid",
    "Cannabichromene",
    "Cannabichromic Acid",
    "Cannabicyclol",
    "Cannabicyclic Acid"
  ])

  @doc """
  Returns a Cannabis cannabinoid abbreviation string

  ## Examples

      iex> Faker.Cannabis.En.cannabinoid_abbreviation()
      "THCa"
      iex> Faker.Cannabis.En.cannabinoid_abbreviation()
      "THCv"
      iex> Faker.Cannabis.En.cannabinoid_abbreviation()
      "CBC"
      iex> Faker.Cannabis.En.cannabinoid_abbreviation()
      "CBG"
  """
  @spec cannabinoid_abbreviation() :: String.t()
  sampler(:cannabinoid_abbreviation, [
    "THC",
    "THCa",
    "∆9THC",
    "∆8THC",
    "THCv",
    "THCv",
    "CBD",
    "CBDa",
    "CBDv",
    "CBN",
    "CBNa",
    "CBG",
    "CBGa",
    "CBC",
    "CBCa",
    "CBL",
    "CBLa"
  ])

  @doc """
  Returns a Cannabis terpene string

  ## Examples

      iex> Faker.Cannabis.En.terpene()
      "Camphor"
      iex> Faker.Cannabis.En.terpene()
      "Camphene"
      iex> Faker.Cannabis.En.terpene()
      "α Pinene"
      iex> Faker.Cannabis.En.terpene()
      "Sabinene"
  """
  @spec terpene() :: String.t()
  sampler(:terpene, [
    "α Pinene",
    "Myrcene",
    "α Phellandrene",
    "∆ 3 Carene",
    "Terpinene",
    "Limonene",
    "α Terpinolene",
    "Linalool",
    "Fenchol",
    "Borneol",
    "Terpineol",
    "Geraniol",
    "α Humulene",
    "β Caryophyllene",
    "Caryophyllene Oxide",
    "α Bisabolol",
    "Camphene",
    "β Pinene",
    "Ocimene",
    "Sabinene",
    "Camphor",
    "Isoborneol",
    "Menthol",
    "α Cedrene",
    "Nerolidol",
    "R-(+)-Pulegone",
    "Eucalyptol",
    "p-Cymene",
    "(-)-Isopulegol",
    "Geranyl",
    "Acetate",
    "Guaiol",
    "Valencene",
    "Phytol",
    "Citronellol"
  ])

  @doc """
  Returns a Cannabis medical use string

  ## Examples

      iex> Faker.Cannabis.En.medical_use()
      "analgesic"
      iex> Faker.Cannabis.En.medical_use()
      "anti-cancer"
      iex> Faker.Cannabis.En.medical_use()
      "anti-cancer"
      iex> Faker.Cannabis.En.medical_use()
      "anti-fungal"
  """
  @spec medical_use() :: String.t()
  sampler(:medical_use, [
    "analgesic",
    "anti-bacterial",
    "anti-diabetic",
    "anti-emetic",
    "anti-epileptic",
    "anti-fungal",
    "anti-depressant",
    "anti-inflammatory",
    "anti-insomnia",
    "anti-ischemic",
    "anti-cancer",
    "anti-psoriatic",
    "anti-psychotic",
    "anti-spasmodic",
    "anti-anxiety",
    "appetite stimulant",
    "anorectic",
    "bone stimulant",
    "immunoregulation",
    "immunostimulant",
    "intestinal anti-prokinetic",
    "neuroprotective",
    "bronchodilator",
    "anti-stress",
    "anti-septic",
    "psychoactive",
    "non-psychoactive",
    "decongestant",
    "anti-histamine",
    "anti-oxidant",
    "anti-viral"
  ])

  @doc """
  Returns a Cannabis health benefit string

  ## Examples

      iex> Faker.Cannabis.En.health_benefit()
      "relieves pain"
      iex> Faker.Cannabis.En.health_benefit()
      "inhibits cell growth in tumors/cancer cells"
      iex> Faker.Cannabis.En.health_benefit()
      "inhibits cell growth in tumors/cancer cells"
      iex> Faker.Cannabis.En.health_benefit()
      "treats fungal infection"
  """
  @spec health_benefit() :: String.t()
  sampler(:health_benefit, [
    "relieves pain",
    "kills or slows bacteria growth",
    "reduces blood sugar levels",
    "reduces vomiting and nausea",
    "reduces seizures and convulsion",
    "treats fungal infection",
    "treats depression",
    "reduces inflammation",
    "aids sleep",
    "reduces risk of artery blockage",
    "inhibits cell growth in tumors/cancer cells",
    "treats psoriasis",
    "tranquilizing",
    "suppresses muscle spasms",
    "relieves anxiety",
    "stimulates appetite",
    "suppresses appetite",
    "promotes bone growth",
    "regulates function in the immune system",
    "stimulates function in the immune system",
    "reduces contractions in the small intestines",
    "protects against nervous system degeneration",
    "improves airflow to lungs",
    "prevents stress",
    "prevents infection",
    "affects mental activity",
    "does not affect mental activity",
    "relieves congestion",
    "treats allergy symptoms",
    "cell protectant",
    "treats viral infections"
  ])

  @doc """
  Returns a Cannabis category string

  ## Examples

      iex> Faker.Cannabis.En.category()
      "flower"
      iex> Faker.Cannabis.En.category()
      "medical"
      iex> Faker.Cannabis.En.category()
      "seeds & clones"
      iex> Faker.Cannabis.En.category()
      "live resin"
  """
  @spec category() :: String.t()
  sampler(:category, [
    "capsules",
    "concentrates",
    "crumble",
    "crystalline",
    "distillate",
    "edibles",
    "flower",
    "ice hash",
    "live resin",
    "medical",
    "rosin",
    "seeds & clones",
    "shatter",
    "tinctures",
    "topicals",
    "vape pens"
  ])

  @doc """
  Returns a Cannabis type string

  ## Examples

      iex> Faker.Cannabis.En.type()
      "hybrid"
      iex> Faker.Cannabis.En.type()
      "sativa"
      iex> Faker.Cannabis.En.type()
      "hybrid"
      iex> Faker.Cannabis.En.type()
      "sativa"
  """
  @spec type() :: String.t()
  sampler(:type, ["hybrid", "indica", "sativa"])

  @doc """
  Returns a Cannabis buzzword string

  ## Examples

      iex> Faker.Cannabis.En.buzzword()
      "toke"
      iex> Faker.Cannabis.En.buzzword()
      "cbd"
      iex> Faker.Cannabis.En.buzzword()
      "stoned"
      iex> Faker.Cannabis.En.buzzword()
      "stoned"
  """
  @spec buzzword() :: String.t()
  sampler(:buzzword, [
    "blunt wrap",
    "bong",
    "bottom shelf",
    "bubbler",
    "cashed",
    "cbd",
    "dank",
    "eighth",
    "gram",
    "high",
    "hydroponic",
    "keef",
    "marijuana",
    "mary jane",
    "munchies",
    "ounce",
    "papers",
    "pipe",
    "pound",
    "private reserve",
    "ripped",
    "spliff",
    "stoned",
    "terpene",
    "thc",
    "toke",
    "top shelf",
    "wake and bake",
    "weed"
  ])

  @doc """
  Returns a Cannabis brand string

  ## Examples

      iex> Faker.Cannabis.En.brand()
      "Evolab"
      iex> Faker.Cannabis.En.brand()
      "CI Wholesale"
      iex> Faker.Cannabis.En.brand()
      "Muy"
      iex> Faker.Cannabis.En.brand()
      "Chong's Choice"
  """
  @spec brand() :: String.t()
  sampler(:brand, [
    "8 | FOLD Cultivation",
    "Apothecanna",
    "Auntie Dolores",
    "Big Pete's Treats",
    "Bloom Farms",
    "CI Wholesale",
    "California's Finest",
    "Cannapunch",
    "Cannavore Confections",
    "Caviar Gold",
    "Cheeba Chews",
    "Chong's Choice",
    "Claw",
    "Coda Signature",
    "Colorado Cannabis Company",
    "Dixie Edibles",
    "Dixie Elixirs",
    "Dosist",
    "Evolab",
    "Hashman Infused",
    "Hiku",
    "Jetty Extracts",
    "K.I.N.D. Concentrates",
    "Kiva Confections",
    "Leafs by Snoop",
    "Legal Drinks",
    "Level Blends",
    "Lola Lola",
    "Lord Jones",
    "Marley Natural",
    "Muy",
    "Nature’s Medicines",
    "Oil Stix",
    "Omaha Farms",
    "Orchid Essentials",
    "OreKron",
    "Roots",
    "Seven Point",
    "Shore Natural RX",
    "Siskiyou Sungrown",
    "Summit",
    "THC Design",
    "THC Factory",
    "The Goodship Company",
    "The Lab",
    "Timeless Vapes",
    "True Humboldt",
    "Wana Brands",
    "Whoopie & Maya",
    "Willie’s Reserve",
    "marQaha"
  ])
end
