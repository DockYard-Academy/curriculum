defmodule Faker.Address.It do
  import Faker, only: [sampler: 2]

  alias Faker.Address.It

  @moduledoc """
  Functions for generating addresses in Italian
  """

  @doc """
  Return random building number.

  ## Examples

      iex> Faker.Address.It.building_number()
      "154"
      iex> Faker.Address.It.building_number()
      "64"
      iex> Faker.Address.It.building_number()
      "1"
      iex> Faker.Address.It.building_number()
      "832"
  """
  @spec building_number() :: String.t()
  def building_number do
    ["###", "##", "#"]
    |> Enum.at(Faker.random_between(0, 2))
    |> Faker.format()
  end

  @doc """
  Return city name.

  ## Examples

      iex> Faker.Address.It.city()
      "Dionigi Marittima"
      iex> Faker.Address.It.city()
      "Quarto Gennaro"
      iex> Faker.Address.It.city()
      "Sesto Maurizia"
      iex> Faker.Address.It.city()
      "Case di Taffy"
  """
  @spec city() :: String.t()
  def city do
    city(Faker.random_between(0, 3))
  end

  defp city(0), do: "#{city_prefix()} #{Faker.Person.It.first_name()}"
  defp city(1), do: "#{city_prefix()} #{Faker.Person.It.first_name()} #{city_suffix()}"
  defp city(2), do: "#{Faker.Person.It.first_name()} #{city_suffix()}"
  defp city(3), do: "#{Faker.Person.It.last_name()}"

  @doc """
  Return city prefix.

  ## Examples

      iex> Faker.Address.It.city_prefix()
      "Quarto"
      iex> Faker.Address.It.city_prefix()
      "Castello"
      iex> Faker.Address.It.city_prefix()
      "Quarto"
      iex> Faker.Address.It.city_prefix()
      "Santa"
  """
  @spec city_prefix() :: String.t()
  sampler(:city_prefix, [
    "San",
    "Santo",
    "Santa",
    "Terzo",
    "Quarto",
    "Quinto",
    "Sesto",
    "Settimo",
    "Case",
    "Case di",
    "Borgo",
    "Castello",
    "Città di"
  ])

  @doc """
  Return city suffix.

  ## Examples

      iex> Faker.Address.It.city_suffix()
      "di sotto"
      iex> Faker.Address.It.city_suffix()
      "di sopra"
      iex> Faker.Address.It.city_suffix()
      "Marittima"
  """
  @spec city_suffix() :: String.t()
  sampler(:city_suffix, [
    "al mare",
    "di sopra",
    "di sotto",
    "Marittima"
  ])

  @doc """
  Return country.
  List from http://publications.europa.eu/code/it/it-5000500.htm

  ## Examples

      iex> Faker.Address.It.country()
      "Etiopia"
      iex> Faker.Address.It.country()
      "Cipro"
      iex> Faker.Address.It.country()
      "Timor Leste"
      iex> Faker.Address.It.country()
      "Nicaragua"
  """
  @spec country() :: String.t()
  sampler(:country, [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Anguilla",
    "Angola",
    "Antartide",
    "Antigua e Barbuda",
    "Arabia Saudita",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaigian",
    "Bahamas",
    "Bahrein",
    "Bangladesh",
    "Barbados",
    "Belgio",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bielorussia",
    "Bolivia",
    "Bosnia-Erzegovina",
    "Botswana",
    "Brasile",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambogia",
    "Camerun",
    "Canada",
    "Capo Verde",
    "Cechia",
    "Ciad",
    "Cile",
    "Cina",
    "Cipro",
    "Clipperton",
    "Colombia",
    "Comore",
    "Congo",
    "Corea del Nord",
    "Corea del Sud",
    "Costa d'Avorio",
    "Costa Rica",
    "Croazia",
    "Cuba",
    "Curaçao",
    "Danimarca",
    "Dominica",
    "Ecuador",
    "Egitto",
    "El Salvador",
    "Emirati arabi uniti",
    "Eritrea",
    "Estonia",
    "Eswatini",
    "Etiopia",
    "ex Repubblica jugoslava di Macedonia",
    "Fær Øer",
    "Figi",
    "Filippine",
    "Finlandia",
    "Francia",
    "Gabon",
    "Gambia",
    "Georgia",
    "Georgia del sud e Sandwich australi",
    "Germania",
    "Ghana",
    "Giamaica",
    "Giappone",
    "Gibilterra",
    "Gibuti",
    "Giordania",
    "Grecia",
    "Grenada",
    "Groenlandia",
    "Guadalupa",
    "Guam",
    "Guatemala",
    "Guernsey",
    "Guinea",
    "Guinea-Bissau",
    "Guinea equatoriale",
    "Guyana",
    "Guyana francese",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Irlanda",
    "Islanda",
    "Isola Christmas",
    "Isola di Bouvet",
    "Isola di Man",
    "Isola Norfolk",
    "Isole Åland",
    "Isole Cayman",
    "Isole Cocos",
    "Isole Cook",
    "Isole Falkland",
    "Isole Heard e McDonald",
    "Isole Marianne settentrionali",
    "Isole Marshall",
    "Isole minori periferiche degli Stati Uniti",
    "Isole Pitcairn",
    "Isole Salomone",
    "Isole Turks e Caicos",
    "Isole Vergini americane",
    "Isole Vergini britanniche",
    "Israele",
    "Italia",
    "Jersey",
    "Kazakhstan",
    "Kenya",
    "Kirghizistan",
    "Kiribati",
    "Kuwait",
    "Laos",
    "Lesotho",
    "Lettonia",
    "Libano",
    "Liberia",
    "Libia",
    "Liechtenstein",
    "Lituania",
    "Lussemburgo",
    "Macao",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldive",
    "Mali",
    "Malta",
    "Marocco",
    "Martinica",
    "Mauritania",
    "Maurizio",
    "Mayotte",
    "Messico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Montserrat",
    "Mozambico",
    "Myanmar/Birmania",
    "Namibia",
    "Nauru",
    "Nepal",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Niue",
    "Norvegia",
    "Nuova Caledonia",
    "Nuova Zelanda",
    "Oman",
    "Paesi Bassi",
    "Pakistan",
    "Palau",
    "Panama",
    "Papua Nuova Guinea",
    "Paraguay",
    "Perù",
    "Polinesia francese",
    "Polonia",
    "Portogallo",
    "Portorico",
    "Qatar",
    "Regno Unito",
    "Repubblica centrafricana",
    "Repubblica democratica del Congo",
    "Repubblica dominicana",
    "Riunione",
    "Romania",
    "Ruanda",
    "Russia",
    "Sahara occidentale",
    "Saint-Barthélemy",
    "Saint Kitts e Nevis",
    "Saint-Martin",
    "Saint Pierre e Miquelon",
    "Saint Vincent e Grenadine",
    "Samoa",
    "Samoa americane",
    "San Marino",
    "Santa Lucia",
    "Santa Sede/Stato della Città del Vaticano",
    "Sant'Elena, Ascensione e Tristan da Cunha",
    "Sao Tomé e Principe",
    "Seychelles",
    "Senegal",
    "Serbia",
    "Sierra Leone",
    "Singapore",
    "Sint Maarten",
    "Siria",
    "Slovacchia",
    "Slovenia",
    "Somalia",
    "Spagna",
    "Sri Lanka",
    "Stati Uniti",
    "Sud Africa",
    "Sudan",
    "Sud Sudan",
    "Suriname",
    "Svalbard e Jan Mayen",
    "Svezia",
    "Svizzera",
    "Tagikistan",
    "Taiwan",
    "Tanzania",
    "Terre australi e antartiche francesi",
    "Territorio britannico dell'Oceano Indiano",
    "Thailandia",
    "Timor Leste",
    "Togo",
    "Tokelau",
    "Tonga",
    "Trinidad e Tobago",
    "Tunisia",
    "Turchia",
    "Turkmenistan",
    "Tuvalu",
    "Ucraina",
    "Uganda",
    "Ungheria",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Venezuela",
    "Vietnam",
    "Wallis e Futuna",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ])

  @doc """
  Return country code.
  List from http://publications.europa.eu/code/it/it-5000500.htm

  ## Examples

      iex> Faker.Address.It.country_code()
      "CO"
      iex> Faker.Address.It.country_code()
      "LV"
  """
  @spec country_code() :: String.t()
  sampler(:country_code, [
    "AF",
    "AL",
    "DZ",
    "AD",
    "AI",
    "AO",
    "AQ",
    "AG",
    "SA",
    "AR",
    "AM",
    "AW",
    "AU",
    "AT",
    "AZ",
    "BS",
    "BH",
    "BD",
    "BB",
    "BE",
    "BZ",
    "BJ",
    "BM",
    "BT",
    "BY",
    "BO",
    "BA",
    "BW",
    "BR",
    "BN",
    "BG",
    "BF",
    "BI",
    "KH",
    "CM",
    "CA",
    "CV",
    "CZ",
    "TD",
    "CL",
    "CN",
    "CY",
    "CP",
    "CO",
    "KM",
    "CG",
    "KP",
    "KR",
    "CI",
    "CR",
    "HR",
    "CU",
    "CW",
    "DK",
    "DM",
    "EC",
    "EG",
    "SV",
    "AE",
    "ER",
    "EE",
    "SZ",
    "ET",
    "FO",
    "FJ",
    "PH",
    "FI",
    "FR",
    "GA",
    "GM",
    "GE",
    "GS",
    "DE",
    "GH",
    "JM",
    "JP",
    "GI",
    "DJ",
    "JO",
    "EL",
    "GD",
    "GL",
    "GP",
    "GU",
    "GT",
    "GG",
    "GN",
    "GW",
    "GQ",
    "GY",
    "GF",
    "HT",
    "HN",
    "HK",
    "IN",
    "ID",
    "IR",
    "IQ",
    "IE",
    "IS",
    "CX",
    "BV",
    "IM",
    "NF",
    "AX",
    "KY",
    "CC",
    "CK",
    "FK",
    "HM",
    "MP",
    "MH",
    "UM",
    "PN",
    "SB",
    "TC",
    "VI",
    "VG",
    "IL",
    "IT",
    "JE",
    "KZ",
    "KE",
    "KG",
    "KI",
    "KW",
    "LA",
    "LS",
    "LV",
    "LB",
    "LR",
    "LY",
    "LI",
    "LT",
    "LU",
    "MO",
    "MG",
    "MW",
    "MY",
    "MV",
    "ML",
    "MT",
    "MA",
    "MQ",
    "MR",
    "MU",
    "YT",
    "MX",
    "FM",
    "MD",
    "MC",
    "MN",
    "ME",
    "MS",
    "MZ",
    "MM",
    "NA",
    "NR",
    "NP",
    "NI",
    "NE",
    "NG",
    "NU",
    "NO",
    "NC",
    "NZ",
    "OM",
    "NL",
    "PK",
    "PW",
    "PA",
    "PG",
    "PY",
    "PE",
    "PF",
    "PL",
    "PT",
    "PR",
    "QA",
    "UK",
    "CF",
    "CD",
    "DO",
    "RE",
    "RO",
    "RW",
    "RU",
    "EH",
    "BL",
    "KN",
    "MF",
    "PM",
    "VC",
    "WS",
    "AS",
    "SM",
    "LC",
    "VA",
    "SH",
    "ST",
    "SC",
    "SN",
    "RS",
    "SL",
    "SG",
    "SX",
    "SY",
    "SK",
    "SI",
    "SO",
    "ES",
    "LK",
    "US",
    "ZA",
    "SD",
    "SS",
    "SR",
    "SJ",
    "SE",
    "CH",
    "TJ",
    "TW",
    "TZ",
    "TF",
    "IO",
    "TH",
    "TL",
    "TG",
    "TK",
    "TO",
    "TT",
    "TN",
    "TR",
    "TM",
    "TV",
    "UA",
    "UG",
    "HU",
    "UY",
    "UZ",
    "VU",
    "VE",
    "VN",
    "WF",
    "YE",
    "ZM",
    "ZW"
  ])

  @doc """
  Return random secondary address.

    ## Examples

      iex> Faker.Address.It.secondary_address()
      "/A"
      iex> Faker.Address.It.secondary_address()
      "/B"
      iex> Faker.Address.It.secondary_address()
      "/A"
      iex> Faker.Address.It.secondary_address()
      "Edificio 26"
  """
  @spec secondary_address() :: String.t()
  def secondary_address do
    ["/A", "/B", "/C", "Edificio #", "Edificio ##"]
    |> Enum.at(Faker.random_between(0, 4))
    |> Faker.format()
  end

  @doc """
  Return state. But Italy doesn't have states so this calls Faker.Address.It.region() instead
  """
  @spec state :: String.t()
  def state, do: region()

  @doc """
  Return region.
  If you call region(), province() or province_abbr() separately you'll end up with
  inconsistent data. For example: "Lombardia", "Roma", "GE".
  If you want consisten data call region_province_abbr() instead, which will return
  something like ["Lombardia", "Milano", "MI"].

      ## Examples

      iex> Faker.Address.It.region()
      "Molise"
      iex> Faker.Address.It.region()
      "Basilicata"
      iex> Faker.Address.It.region()
      "Toscana"
      iex> Faker.Address.It.region()
      "Emilia-Romagna"
  """
  @spec region() :: String.t()
  sampler(:region, [
    "Abruzzi",
    "Basilicata",
    "Calabria",
    "Campania",
    "Emilia-Romagna",
    "Friuli Venezia Giulia",
    "Lazio",
    "Liguria",
    "Lombardia",
    "Marche",
    "Molise",
    "Piemonte",
    "Puglia",
    "Sardegna",
    "Sicilia",
    "Toscana",
    "Trentino-Alto Adige/Südtirol",
    "Umbria",
    "Valle d'Aosta/Vallée d'Aoste",
    "Veneto"
  ])

  @doc """
  There are no state/region abbreviations in Italy.
  """
  @spec state_abbr :: String.t()
  def state_abbr, do: ""

  @doc """
  Return province name.
  Data from https://dait.interno.gov.it/servizi-demografici/documentazione/anagaire-tabelle-comuni-province-consolati-statiterritori
  If you call region(), province() or province_abbr() separately you'll end up with
  inconsistent data. For example: "Lombardia", "Roma", "GE".
  If you want consisten data call region_province_abbr() instead, which will return
  something like ["Lombardia", "Milano", "MI"].

      ## Examples

      iex> Faker.Address.It.province()
      "Barletta-Andria-Trani"
      iex> Faker.Address.It.province()
      "Trento"
      iex> Faker.Address.It.province()
      "Pavia"
      iex> Faker.Address.It.province()
      "Caserta"
  """
  @spec province() :: String.t()
  sampler(:province, [
    "Agrigento",
    "Alessandria",
    "Ancona",
    "Aosta",
    "Arezzo",
    "Ascoli Piceno",
    "Asti",
    "Avellino",
    "Bari",
    "Barletta-Andria-Trani",
    "Belluno",
    "Benevento",
    "Bergamo",
    "Biella",
    "Bologna",
    "Bolzano/Bozen",
    "Brescia",
    "Brindisi",
    "Cagliari",
    "Caltanissetta",
    "Campobasso",
    "Caserta",
    "Catania",
    "Catanzaro",
    "Chieti",
    "Como",
    "Cosenza",
    "Cremona",
    "Crotone",
    "Cuneo",
    "Enna",
    "Fermo",
    "Ferrara",
    "Firenze",
    "Foggia",
    "Forlì-Cesena",
    "Frosinone",
    "Genova",
    "Gorizia",
    "Grosseto",
    "Imperia",
    "Isernia",
    "L'Aquila",
    "La Spezia",
    "Latina",
    "Lecce",
    "Lecco",
    "Livorno",
    "Lodi",
    "Lucca",
    "Macerata",
    "Mantova",
    "Massa e Carrara",
    "Matera",
    "Messina",
    "Milano",
    "Modena",
    "Monza e della Brianza",
    "Napoli",
    "Novara",
    "Nuoro",
    "Oristano",
    "Padova",
    "Palermo",
    "Parma",
    "Pavia",
    "Perugia",
    "Pesaro e Urbino",
    "Pescara",
    "Piacenza",
    "Pisa",
    "Pistoia",
    "Pordenone",
    "Potenza",
    "Prato",
    "Ragusa",
    "Ravenna",
    "Reggio di Calabria",
    "Reggio nell'Emilia",
    "Rieti",
    "Rimini",
    "Roma",
    "Rovigo",
    "Salerno",
    "Sassari",
    "Savona",
    "Siena",
    "Siracusa",
    "Sondrio",
    "Sud Sardegna",
    "Taranto",
    "Teramo",
    "Terni",
    "Torino",
    "Trapani",
    "Trento",
    "Treviso",
    "Trieste",
    "Udine",
    "Varese",
    "Venezia",
    "Verbano-Cusio-Ossola",
    "Vercelli",
    "Verona",
    "Vibo Valentia",
    "Vicenza",
    "Viterbo"
  ])

  @doc """
  Return province code.
  Data from https://dait.interno.gov.it/servizi-demografici/documentazione/anagaire-tabelle-comuni-province-consolati-statiterritori
  If you call region(), province() or province_abbr() separately you'll end up with
  inconsistent data. For example: "Lombardia", "Roma", "GE".
  If you want consisten data call region_province_abbr() instead, which will return
  something like ["Lombardia", "Milano", "MI"].

    ## Examples

      iex> Faker.Address.It.province_abbr()
      "BA"
      iex> Faker.Address.It.province_abbr()
      "TR"
      iex> Faker.Address.It.province_abbr()
      "PG"
      iex> Faker.Address.It.province_abbr()
      "CE"
  """
  @spec province_abbr() :: String.t()
  sampler(:province_abbr, [
    "AG",
    "AL",
    "AN",
    "AO",
    "AP",
    "AQ",
    "AR",
    "AT",
    "AV",
    "BA",
    "BG",
    "BI",
    "BL",
    "BN",
    "BO",
    "BR",
    "BS",
    "BT",
    "BZ",
    "CA",
    "CB",
    "CE",
    "CH",
    "CL",
    "CN",
    "CO",
    "CR",
    "CS",
    "CT",
    "CZ",
    "EN",
    "FC",
    "FE",
    "FG",
    "FI",
    "FM",
    "FR",
    "GE",
    "GO",
    "GR",
    "IM",
    "IS",
    "KR",
    "LC",
    "LE",
    "LI",
    "LO",
    "LT",
    "LU",
    "MB",
    "MC",
    "ME",
    "MI",
    "MN",
    "MO",
    "MS",
    "MT",
    "NA",
    "NO",
    "NU",
    "OR",
    "PA",
    "PC",
    "PD",
    "PE",
    "PG",
    "PI",
    "PN",
    "PO",
    "PR",
    "PT",
    "PU",
    "PV",
    "PZ",
    "RA",
    "RC",
    "RE",
    "RG",
    "RI",
    "RM",
    "RN",
    "RO",
    "SA",
    "SI",
    "SO",
    "SP",
    "SR",
    "SS",
    "SU",
    "SV",
    "TA",
    "TE",
    "TN",
    "TO",
    "TP",
    "TR",
    "TS",
    "TV",
    "UD",
    "VA",
    "VB",
    "VC",
    "VE",
    "VI",
    "VR",
    "VT",
    "VV"
  ])

  @doc """
  Return a consistent list containing the region and province names with the province code.
  Data from https://dait.interno.gov.it/servizi-demografici/documentazione/anagaire-tabelle-comuni-province-consolati-statiterritori

  ## Examples

      iex> Faker.Address.It.region_province_abbr()
      ["Calabria", "Reggio di Calabria", "RC"]
      iex> Faker.Address.It.region_province_abbr()
      ["Trentino-Alto Adige/Südtirol", "Bolzano/Bozen", "BZ"]
      iex> Faker.Address.It.region_province_abbr()
      ["Puglia", "Bari", "BA"]
      iex> Faker.Address.It.region_province_abbr()
      ["Emilia-Romagna", "Piacenza", "PC"]
  """
  @spec region_province_abbr() :: [String.t()]
  sampler(:region_province_abbr, [
    ["Abruzzi", "Chieti", "CH"],
    ["Abruzzi", "L'Aquila", "AQ"],
    ["Abruzzi", "Pescara", "PE"],
    ["Abruzzi", "Teramo", "TE"],
    ["Basilicata", "Matera", "MT"],
    ["Basilicata", "Potenza", "PZ"],
    ["Calabria", "Catanzaro", "CZ"],
    ["Calabria", "Cosenza", "CS"],
    ["Calabria", "Crotone", "KR"],
    ["Calabria", "Reggio di Calabria", "RC"],
    ["Calabria", "Vibo Valentia", "VV"],
    ["Campania", "Avellino", "AV"],
    ["Campania", "Benevento", "BN"],
    ["Campania", "Caserta", "CE"],
    ["Campania", "Napoli", "NA"],
    ["Campania", "Salerno", "SA"],
    ["Emilia-Romagna", "Bologna", "BO"],
    ["Emilia-Romagna", "Ferrara", "FE"],
    ["Emilia-Romagna", "Forlì-Cesena", "FC"],
    ["Emilia-Romagna", "Modena", "MO"],
    ["Emilia-Romagna", "Parma", "PR"],
    ["Emilia-Romagna", "Piacenza", "PC"],
    ["Emilia-Romagna", "Ravenna", "RA"],
    ["Emilia-Romagna", "Reggio nell'Emilia", "RE"],
    ["Emilia-Romagna", "Rimini", "RN"],
    ["Friuli Venezia Giulia", "Gorizia", "GO"],
    ["Friuli Venezia Giulia", "Pordenone", "PN"],
    ["Friuli Venezia Giulia", "Trieste", "TS"],
    ["Friuli Venezia Giulia", "Udine", "UD"],
    ["Lazio", "Frosinone", "FR"],
    ["Lazio", "Latina", "LT"],
    ["Lazio", "Rieti", "RI"],
    ["Lazio", "Roma", "RM"],
    ["Lazio", "Viterbo", "VT"],
    ["Liguria", "Genova", "GE"],
    ["Liguria", "Imperia", "IM"],
    ["Liguria", "La Spezia", "SP"],
    ["Liguria", "Savona", "SV"],
    ["Lombardia", "Bergamo", "BG"],
    ["Lombardia", "Brescia", "BS"],
    ["Lombardia", "Como", "CO"],
    ["Lombardia", "Cremona", "CR"],
    ["Lombardia", "Lecco", "LC"],
    ["Lombardia", "Lodi", "LO"],
    ["Lombardia", "Mantova", "MN"],
    ["Lombardia", "Milano", "MI"],
    ["Lombardia", "Monza e della Brianza", "MB"],
    ["Lombardia", "Pavia", "PV"],
    ["Lombardia", "Sondrio", "SO"],
    ["Lombardia", "Varese", "VA"],
    ["Marche", "Ancona", "AN"],
    ["Marche", "Ascoli Piceno", "AP"],
    ["Marche", "Fermo", "FM"],
    ["Marche", "Macerata", "MC"],
    ["Marche", "Pesaro e Urbino", "PU"],
    ["Molise", "Campobasso", "CB"],
    ["Molise", "Isernia", "IS"],
    ["Piemonte", "Alessandria", "AL"],
    ["Piemonte", "Asti", "AT"],
    ["Piemonte", "Biella", "BI"],
    ["Piemonte", "Cuneo", "CN"],
    ["Piemonte", "Novara", "NO"],
    ["Piemonte", "Torino", "TO"],
    ["Piemonte", "Verbano-Cusio-Ossola", "VB"],
    ["Piemonte", "Vercelli", "VC"],
    ["Puglia", "Bari", "BA"],
    ["Puglia", "Barletta-Andria-Trani", "BT"],
    ["Puglia", "Brindisi", "BR"],
    ["Puglia", "Foggia", "FG"],
    ["Puglia", "Lecce", "LE"],
    ["Puglia", "Taranto", "TA"],
    ["Sardegna", "Cagliari", "CA"],
    ["Sardegna", "Nuoro", "NU"],
    ["Sardegna", "Oristano", "OR"],
    ["Sardegna", "Sassari", "SS"],
    ["Sardegna", "Sud Sardegna", "SU"],
    ["Sicilia", "Agrigento", "AG"],
    ["Sicilia", "Caltanissetta", "CL"],
    ["Sicilia", "Catania", "CT"],
    ["Sicilia", "Enna", "EN"],
    ["Sicilia", "Messina", "ME"],
    ["Sicilia", "Palermo", "PA"],
    ["Sicilia", "Ragusa", "RG"],
    ["Sicilia", "Siracusa", "SR"],
    ["Sicilia", "Trapani", "TP"],
    ["Toscana", "Arezzo", "AR"],
    ["Toscana", "Firenze", "FI"],
    ["Toscana", "Grosseto", "GR"],
    ["Toscana", "Livorno", "LI"],
    ["Toscana", "Lucca", "LU"],
    ["Toscana", "Massa e Carrara", "MS"],
    ["Toscana", "Pisa", "PI"],
    ["Toscana", "Pistoia", "PT"],
    ["Toscana", "Prato", "PO"],
    ["Toscana", "Siena", "SI"],
    ["Trentino-Alto Adige/Südtirol", "Bolzano/Bozen", "BZ"],
    ["Trentino-Alto Adige/Südtirol", "Trento", "TN"],
    ["Umbria", "Perugia", "PG"],
    ["Umbria", "Terni", "TR"],
    ["Valle d'Aosta/Vallée d'Aoste", "Aosta", "AO"],
    ["Veneto", "Belluno", "BL"],
    ["Veneto", "Padova", "PD"],
    ["Veneto", "Rovigo", "RO"],
    ["Veneto", "Treviso", "TV"],
    ["Veneto", "Venezia", "VE"],
    ["Veneto", "Verona", "VR"],
    ["Veneto", "Vicenza", "VI"]
  ])

  @doc """
  Return street address.

    ## Examples

      iex> Faker.Address.It.street_address()
      "Corso Agave, 2"
      iex> Faker.Address.It.street_address()
      "Viale Keith, 083"
      iex> Faker.Address.It.street_address()
      "Strada per Liguria, 523"
      iex> Faker.Address.It.street_address()
      "Viale De Rosa, 03"
  """
  @spec street_address() :: String.t()
  def street_address do
    "#{It.street_name()}, #{building_number()}"
  end

  @doc """
  Return `street_address/0` or if argument is `true` adds `secondary_address/0`.

    ## Examples

      iex> Faker.Address.It.street_address(true)
      "Corso Agave, 2/B"
      iex> Faker.Address.It.street_address(false)
      "Via per Piemonte, 832"
      iex> Faker.Address.It.street_address(false)
      "Vicolo Longo, 2"
      iex> Faker.Address.It.street_address(false)
      "Via Privata Galli, 2"
  """
  @spec street_address(true | any) :: String.t()
  def street_address(true), do: street_address() <> secondary_address()
  def street_address(_), do: street_address()

  @doc """
  Return street name.

    ## Examples

      iex> Faker.Address.It.street_name()
      "Corso Agave"
      iex> Faker.Address.It.street_name()
      "Via Privata Gennaro Mazza"
      iex> Faker.Address.It.street_name()
      "Vicolo Shaula Lombardi"
      iex> Faker.Address.It.street_name()
      "Strada per Giuliani"
  """
  @spec street_name() :: String.t()
  def street_name do
    street_name(Faker.random_between(0, 5))
  end

  defp street_name(0), do: "#{street_prefix()} #{Faker.Person.It.first_name()}"
  defp street_name(1), do: "#{street_prefix()} #{Faker.Person.It.last_name()}"

  defp street_name(2),
    do: "#{street_prefix()} #{Faker.Person.It.first_name()} #{Faker.Person.It.last_name()}"

  defp street_name(3), do: "#{street_prefix()} #{country()}"
  defp street_name(4), do: "#{street_prefix()} #{region()}"
  defp street_name(5), do: "#{street_prefix()} #{province()}"

  @doc """
  Return street prefix.

    ## Examples

      iex> Faker.Address.It.street_prefix()
      "Vicolo"
      iex> Faker.Address.It.street_prefix()
      "Corso"
      iex> Faker.Address.It.street_prefix()
      "Piazzale"
      iex> Faker.Address.It.street_prefix()
      "Piazza"
  """
  @spec street_prefix() :: String.t()
  sampler(:street_prefix, [
    "Via",
    "Viale",
    "Corso",
    "Vicolo",
    "Via Privata",
    "Piazza",
    "Piazzale",
    "Strada per",
    "Via per"
  ])

  @doc """
  Return time zone.

    ## Examples

      iex> Faker.Address.It.time_zone()
      "Australia/Sydney"
      iex> Faker.Address.It.time_zone()
      "America/Guyana"
      iex> Faker.Address.It.time_zone()
      "Asia/Kathmandu"
      iex> Faker.Address.It.time_zone()
      "Europa/Vienna"
  """
  @spec time_zone() :: String.t()
  sampler(:time_zone, [
    "Pacifico/Midway",
    "Pacifico/Pago_Pago",
    "Pacifico/Honolulu",
    "America/Juneau",
    "America/Los_Angeles",
    "America/Tijuana",
    "America/Denver",
    "America/Phoenix",
    "America/Chihuahua",
    "America/Mazatlan",
    "America/Chicago",
    "America/Regina",
    "America/Mexico_City",
    "America/Monterrey",
    "America/Guatemala",
    "America/New_York",
    "America/Indiana/Indianapolis",
    "America/Bogota",
    "America/Lima",
    "America/Halifax",
    "America/Caracas",
    "America/La_Paz",
    "America/Santiago",
    "America/St_Johns",
    "America/Sao_Paulo",
    "America/Argentina/Buenos_Aires",
    "America/Guyana",
    "America/Godthab",
    "Atlantic/South_Georgia",
    "Atlantic/Azores",
    "Atlantic/Cape_Verde",
    "Europa/Dublin",
    "Europa/Lisbon",
    "Europa/London",
    "Africa/Casablanca",
    "Africa/Monrovia",
    "Etc/UTC",
    "Europa/Belgrade",
    "Europa/Bratislava",
    "Europa/Budapest",
    "Europa/Ljubljana",
    "Europa/Prague",
    "Europa/Sarajevo",
    "Europa/Skopje",
    "Europa/Warsaw",
    "Europa/Zagreb",
    "Europa/Brussels",
    "Europa/Copenhagen",
    "Europa/Madrid",
    "Europa/Paris",
    "Europa/Amsterdam",
    "Europa/Berlin",
    "Europa/Rome",
    "Europa/Stockholm",
    "Europa/Vienna",
    "Africa/Algiers",
    "Europa/Bucharest",
    "Africa/Cairo",
    "Europa/Helsinki",
    "Europa/Kiev",
    "Europa/Riga",
    "Europa/Sofia",
    "Europa/Tallinn",
    "Europa/Vilnius",
    "Europa/Athens",
    "Europa/Istanbul",
    "Europa/Minsk",
    "Asia/Jerusalen",
    "Africa/Harare",
    "Africa/Johannesburg",
    "Europa/Moscú",
    "Asia/Kuwait",
    "Asia/Riyadh",
    "Africa/Nairobi",
    "Asia/Baghdad",
    "Asia/Tehran",
    "Asia/Muscat",
    "Asia/Baku",
    "Asia/Tbilisi",
    "Asia/Yerevan",
    "Asia/Kabul",
    "Asia/Yekaterinburg",
    "Asia/Karachi",
    "Asia/Tashkent",
    "Asia/Kolkata",
    "Asia/Kathmandu",
    "Asia/Dhaka",
    "Asia/Colombo",
    "Asia/Almaty",
    "Asia/Novosibirsk",
    "Asia/Rangoon",
    "Asia/Bangkok",
    "Asia/Jakarta",
    "Asia/Krasnoyarsk",
    "Asia/Shanghai",
    "Asia/Chongqing",
    "Asia/Hong_Kong",
    "Asia/Urumqi",
    "Asia/Kuala_Lumpur",
    "Asia/Singapore",
    "Asia/Taipei",
    "Australia/Perth",
    "Asia/Irkutsk",
    "Asia/Ulaanbaatar",
    "Asia/Seoul",
    "Asia/Tokyo",
    "Asia/Yakutsk",
    "Australia/Darwin",
    "Australia/Adelaide",
    "Australia/Melbourne",
    "Australia/Sydney",
    "Australia/Brisbane",
    "Australia/Hobart",
    "Asia/Vladivostok",
    "Pacifico/Guam",
    "Pacifico/Port_Moresby",
    "Asia/Magadan",
    "Pacifico/Noumea",
    "Pacífico/Fiji",
    "Asia/Kamchatka",
    "Pacifico/Majuro",
    "Pacifico/Auckland",
    "Pacifico/Tongatapu",
    "Pacifico/Fakaofo",
    "Pacifico/Apia"
  ])

  @doc """
  Return random postcode.

    ## Examples

      iex> Faker.Address.It.zip_code()
      "01542"
      iex> Faker.Address.It.zip_code()
      "64610"
      iex> Faker.Address.It.zip_code()
      "83297"
      iex> Faker.Address.It.zip_code()
      "05235"
  """
  @spec zip_code() :: String.t()
  def zip_code do
    ["#####"]
    |> Enum.at(0)
    |> Faker.format()
  end
end
