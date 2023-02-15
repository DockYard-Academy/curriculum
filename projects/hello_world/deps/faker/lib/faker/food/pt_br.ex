defmodule Faker.Food.PtBr do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for food data in Brazilian Portuguese.
  """

  @doc """
  Returns a dish.

  ## Examples

      iex> Faker.Food.PtBr.dish()
      "Asinha de frango"
      iex> Faker.Food.PtBr.dish()
      "Pizza"
      iex> Faker.Food.PtBr.dish()
      "Salada Caprese"
      iex> Faker.Food.PtBr.dish()
      "Peixe frito e batata frita"
  """
  @spec dish() :: String.t()
  sampler(:dish, [
    "Costelas de churrasco",
    "Bruschetta com tomate",
    "Salada Caesar",
    "Salada Caprese",
    "X-Burger",
    "Frango à milanesa",
    "Asinha de frango",
    "Fettuccine caprese",
    "Peixe frito e batata frita",
    "Batata frita tradicional",
    "Batata frita com bacon",
    "Batata frita com cheddar e bacon",
    "Lasanha",
    "Almôndegas cozidas",
    "Risoto de cogumelos com salsinha",
    "Macarrão à carbonara",
    "Espaguete com tomate-cereja e manjericão",
    "Pizza",
    "Ravioli de Ricota e Espinafre",
    "Risoto com frutos do mar",
    "Ovos cozidos",
    "Frango Teriyaki",
    "Sashimi de atum",
    "Sopa de vegetais"
  ])

  @doc """
  Returns a description.

  ## Examples

      iex> Faker.Food.PtBr.description()
      "Três ovos com coentro, tomate, cebola, abacate e queijo derretido. Acompanhado com torradas ou croissant."
      iex> Faker.Food.PtBr.description()
      "Três claras de ovos com espinafre, cogumelos, cebola caramelizada, tomate e queijo com baixo teor de gordura. Acompanhado de torradas integrais."
      iex> Faker.Food.PtBr.description()
      "Três ovos com coentro, tomate, cebola, abacate e queijo derretido. Acompanhado com torradas ou croissant."
      iex> Faker.Food.PtBr.description()
      "Três claras de ovos com espinafre, cogumelos, cebola caramelizada, tomate e queijo com baixo teor de gordura. Acompanhado de torradas integrais."
  """
  @spec description() :: String.t()
  sampler(:description, [
    "Três ovos com coentro, tomate, cebola, abacate e queijo derretido. Acompanhado com torradas ou croissant.",
    "Três omeletes de ovo com queijo ralado, cebolinha e presunto. Acompanhado com torradas ou croissant.",
    "Três claras de ovos com espinafre, cogumelos, cebola caramelizada, tomate e queijo com baixo teor de gordura. Acompanhado de torradas integrais."
  ])

  @doc """
  Returns an ingredient.

  ## Examples

      iex> Faker.Food.PtBr.ingredient()
      "Avelã"
      iex> Faker.Food.PtBr.ingredient()
      "Pepino"
      iex> Faker.Food.PtBr.ingredient()
      "Polenta"
      iex> Faker.Food.PtBr.ingredient()
      "Vinagre Balsâmico"
  """
  @spec ingredient() :: String.t()
  sampler(:ingredient, [
    "Abacate",
    "Abacaxi",
    "Abóbora",
    "Açafrão",
    "Achacha",
    "Agar",
    "Água De Côco",
    "Água De Rosas",
    "Aipo",
    "Alcachofra",
    "Alcaçuz",
    "Alcaparras",
    "Alecrim",
    "Alface",
    "Alfafa",
    "Alho",
    "Alho-Poró",
    "Amaranto",
    "Ameixa",
    "Ameixas",
    "Amêndoas",
    "Amendoim",
    "Amora",
    "Anchovas",
    "Anis",
    "Araruta",
    "Arroz",
    "Arroz Integral",
    "Arroz Japonês",
    "Arroz Mascavo",
    "Atum",
    "Aveia",
    "Avelã",
    "Azeite",
    "Azeitonas",
    "Bacalhau",
    "Bacon",
    "Banana",
    "Barramundi",
    "Batata",
    "Bérberis",
    "Beringela",
    "Berinjela",
    "Beterraba",
    "Bicarbonato De Sódio",
    "Brócolis",
    "Broto De Feijão",
    "Brotos",
    "Cacau",
    "Cacau Em Pó",
    "Café",
    "Camarão",
    "Camomila",
    "Canela",
    "Caqui",
    "Carambola",
    "Caranguejo",
    "Cardamomo",
    "Carne",
    "Carne De Porco",
    "Cassia Casca",
    "Castanha De Caju",
    "Castanha Do Pará",
    "Castanha Portuguesa",
    "Cebola",
    "Cebolinha",
    "Cebolinhas",
    "Cenoura",
    "Cenoura Roxa",
    "Centeio",
    "Cevada",
    "Chá Verde",
    "Chagas",
    "Cheddar",
    "Chocolate Amargo",
    "Chuchu",
    "Coco",
    "Coentro",
    "Cogumelo",
    "Cogumelos Porcini",
    "Cominho",
    "Cordeiro",
    "Couve",
    "Couve-Flor",
    "Cravo",
    "Creme De Leite ",
    "Creme De Queijo",
    "Damasco",
    "Damascos",
    "Dente-De-Leão",
    "Edamame",
    "Erva-Doce",
    "Ervilha",
    "Eschallots",
    "Espargos",
    "Espinafre",
    "Farinha",
    "Farinha De Arroz",
    "Farinha De Batata",
    "Farinha De Grão-De-Bico",
    "Farinha De Rosca",
    "Farinha De Soja",
    "Farinha De Tapioca",
    "Farinha De Trigo",
    "Feijão",
    "Feijão Branco",
    "Feijão Carioca",
    "Fenacho",
    "Fermento Em Pó",
    "Fígado",
    "Figo",
    "Flocos De Milho",
    "Flores De Lavanda",
    "Framboesa",
    "Frango",
    "Fruta Di Conde",
    "Fruta Do Dragão",
    "Fubá",
    "Geléia",
    "Goiaba",
    "Goiabada",
    "Grão-De-Bico",
    "Groselha",
    "Hortelã",
    "Hummus",
    "Jewfish",
    "Kiwi",
    "Kombu",
    "Lagosta",
    "Laranja",
    "Leite",
    "Leite Condensado",
    "Leite De Arroz",
    "Leite De Cabra",
    "Leite De Soja",
    "Lemongrass",
    "Lentilha",
    "Lentilha Vermelha",
    "Lichia",
    "Limão",
    "Linguado",
    "Linguiça",
    "Linhaça",
    "Lula",
    "Maçã",
    "Maçã",
    "Macadâmia",
    "Macarrão",
    "Macarrão De Arroz",
    "Mamão",
    "Mandarins",
    "Manga",
    "Manjerona",
    "Manteiga",
    "Maracujá",
    "Margarina",
    "Massa De Lasanha",
    "Mel",
    "Melaço",
    "Melão",
    "Mexilhão",
    "Mexilhões",
    "Missô",
    "Molho De Ostras",
    "Molho De Peixe",
    "Molho De Soja",
    "Mostarda",
    "Mussarela",
    "Nectarinas",
    "Noodles Asiáticos",
    "Noz-Moscada",
    "Nozes",
    "Óleo De Amêndoa",
    "Óleo De Cártamo",
    "Óleo De Côco",
    "Óleo De Gergelim",
    "Óleo De Linhaça",
    "Óleo De Macadâmia",
    "Óleo De Milho",
    "Óleo De Oliva",
    "Orégano",
    "Ostras",
    "Ovo",
    "Pão",
    "Pão Da Montanha",
    "Pão De Forma",
    "Pão Integral",
    "Papel De Arroz",
    "Pato",
    "Pepino",
    "Pêra",
    "Pêssego",
    "Picanha",
    "Pimenta",
    "Pimenta Chili",
    "Pimenta Da Jamaica",
    "Pimenta Verde",
    "Pimentão",
    "Pistache",
    "Polenta",
    "Polvo",
    "Queijo Cottage",
    "Queijo De Cabra",
    "Queijo Parmesão",
    "Queijo Prato",
    "Queijo Provolone",
    "Quiabo",
    "Quinoa",
    "Rabanete",
    "Raisin",
    "Raspas De Limão",
    "Repolho",
    "Repolho Vermelho",
    "Ricotta",
    "Rins",
    "Romã",
    "Rúcula",
    "Sábio",
    "Sake",
    "Sal Marinho",
    "Salmão",
    "Salsicha",
    "Salsisha",
    "Sardinha",
    "Semente Ajowan",
    "Semente De Abóbora",
    "Semente De Alcaravia",
    "Semente De Mostarda",
    "Semente De Papoila",
    "Semente De Sésamo",
    "Sementes Chia",
    "Sementes De Gergelim",
    "Semolina",
    "Soja",
    "Soletrado",
    "Soro De Leite",
    "Star Anise",
    "Stevi",
    "Suco De Maçã",
    "Tangerina",
    "Tiras De Banbu",
    "Tortilla De Milho",
    "Truta Defumada",
    "Tubarão",
    "Uva",
    "Vagem",
    "Verdes Asiáticos",
    "Vieiras",
    "Vinagre",
    "Vinagre Balsâmico",
    "Vinagre De Arroz Integral",
    "Vinagre De Malte",
    "Vinagre De Vinho Tinto",
    "Vinho",
    "Xarope De Agave",
    "Xarope De Arroz",
    "Xarope De milho"
  ])

  @doc """
  Returns a type of measurement.

  ## Examples

      iex> Faker.Food.PtBr.measurement()
      "Colher de Chá"
      iex> Faker.Food.PtBr.measurement()
      "Colher de Sopa"
      iex> Faker.Food.PtBr.measurement()
      "Colher de Chá"
      iex> Faker.Food.PtBr.measurement()
      "Litro"
  """
  @spec measurement() :: String.t()
  sampler(:measurement, ["Colher de Chá", "Colher de Sopa", "Copo Americano", "Xícara", "Litro"])

  @doc """
  Returns a measurement size.

  ## Examples

      iex> Faker.Food.PtBr.measurement_size()
      "3"
      iex> Faker.Food.PtBr.measurement_size()
      "1/3"
      iex> Faker.Food.PtBr.measurement_size()
      "Pitada"
      iex> Faker.Food.PtBr.measurement_size()
      "2"
  """
  @spec measurement_size() :: String.t()
  sampler(:measurement_size, ["Pitada", "1/4", "1/3", "1/2", "1", "2", "3"])

  @doc """
  Returns a metric measurement.

  ## Examples

      iex> Faker.Food.PtBr.metric_measurement()
      "centilitro"
      iex> Faker.Food.PtBr.metric_measurement()
      "decilitro"
      iex> Faker.Food.PtBr.metric_measurement()
      "litro"
      iex> Faker.Food.PtBr.metric_measurement()
      "mililitro"
  """
  @spec metric_measurement() :: String.t()
  sampler(:metric_measurement, ["mililitro", "decilitro", "centilitro", "litro"])

  @doc """
  Returns a spicy ingredient.

  ## Examples

      iex> Faker.Food.PtBr.spice()
      "Açafrão"
      iex> Faker.Food.PtBr.spice()
      "Chili"
      iex> Faker.Food.PtBr.spice()
      "Alecrim"
      iex> Faker.Food.PtBr.spice()
      "Sal do mar grosso"
  """
  @spec spice() :: String.t()
  sampler(:spice, [
    "Açafrão",
    "Açafrão-da-Terra ou Cúrcuma",
    "Aceto",
    "Aceto balsamico",
    "Aipo Marrom",
    "Aipo ou Salsão",
    "Aji-no-moto",
    "Albahaca",
    "Alcaparra",
    "Alcarávia",
    "Alecrim",
    "Alecrim (ou rosmarinho)",
    "Alfavaca ou Basilicão",
    "Alho",
    "Alho desidratado",
    "Alho-poró",
    "Allspice",
    "Aneto, Dill ou Endro",
    "Anis",
    "Araruta",
    "Azedinha",
    "Azeite-de-dendê",
    "Basilico",
    "Baunilha",
    "Beldroega",
    "Benishooga",
    "Bouquet-garni",
    "Cajun",
    "Camomila",
    "Canela",
    "Canela em pó",
    "Cardamomo",
    "Cari",
    "Caril",
    "Casca de canela",
    "Cássia",
    "Cebola",
    "Cebola Frita",
    "Cebolinha",
    "Cerefólio",
    "Cheiro-verde",
    "Chili",
    "Chili Powder",
    "Chipotle",
    "Ciboulette",
    "Coentro",
    "Colorau ou Colorífico",
    "Cominho",
    "Cravo",
    "Cravo-da-Índia",
    "Cúrcuma",
    "Curry ou Caril ou Garam Masala",
    "Dente de Alho",
    "Dill",
    "Doenjang",
    "Endro",
    "Erva-doce",
    "Erva-doce de cabeça",
    "Ervas Finas ou Fines Herbes",
    "Essência de amêndoa",
    "Essência de baunilha",
    "Essência de menta",
    "Estragão ou Absinto Russo",
    "Feno Grego",
    "Fines Herbes",
    "Folha de aipo",
    "Folha de coentro",
    "Funcho ou Erva-doce de cabeça",
    "Funghi Secchi",
    "Gengibre",
    "Gergelim",
    "Gochu jan",
    "Herbes de Provence",
    "Hissopo",
    "Hondashi",
    "Hortelã",
    "Jalapeño",
    "Lavanda francesa",
    "Lemon Pepper",
    "Losna",
    "Louro",
    "Ma’ward",
    "Ma’zahr",
    "Macis",
    "Manjericão",
    "Manjerona",
    "Marasquino",
    "Masala (Garam Masala)",
    "Mirim",
    "Misk",
    "Missô",
    "Mistura de cinco especiarias",
    "Mistura de especiarias Dhansak",
    "Molho de ostra",
    "Mostarda",
    "Nirá",
    "Noz-moscada",
    "Óleo de semente de gergelim",
    "Orégano",
    "Papoula",
    "Paprica",
    "Páprica",
    "Pimenta",
    "Pimenta branca",
    "Pimenta Caiena",
    "Pimenta Chili",
    "Pimenta da Jamaica",
    "Pimenta do reino",
    "Pimenta síria ou Bhar",
    "Pimenta Vermelha ou Calabresa",
    "Pimenta-do-reino",
    "Pimento Ground",
    "Pimentões",
    "Pimentón",
    "Pimienta",
    "Pimiento",
    "Piripiri",
    "Pó de mostarda",
    "Quatre épices",
    "Raiz Forte",
    "Raspa de Gendibre",
    "Raspa de limão",
    "Raspa de Noz-moscada",
    "Raspas de laranja",
    "Rosmarino",
    "Ruibarbo",
    "Sal de aipo",
    "Sal de tempero",
    "Sal do himalaia",
    "Sal do mar grosso",
    "Salsa",
    "Salsão",
    "Salsinha",
    "Sálvia",
    "Segurelha ou Alfavaca-do-campo",
    "Semente de aipo",
    "Semente de alcaravia",
    "Semente de coentro",
    "Semente de mostarda Amarelo",
    "Semente de mostarda branca",
    "Semente de mostarda marrom",
    "Semente de mostarda preto",
    "Semente de papoila",
    "Shoga (gengibre)",
    "Shoyu",
    "Summac",
    "Tahine",
    "Tamarindo",
    "Tempero de churrasco",
    "Tempero misto",
    "Tomilho",
    "Urucum",
    "Wasabi",
    "Zeste",
    "Zimbro"
  ])
end
