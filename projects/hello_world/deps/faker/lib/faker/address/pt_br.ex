defmodule Faker.Address.PtBr do
  import Faker, only: [sampler: 2]

  alias Faker.Person.PtBr

  @moduledoc """
  Functions for generating addresses in Spanish
  """

  @doc """
  Return random building number.

  ## Examples

      iex> Faker.Address.PtBr.building_number()
      "s/n"
      iex> Faker.Address.PtBr.building_number()
      "5426"
      iex> Faker.Address.PtBr.building_number()
      "6"
      iex> Faker.Address.PtBr.building_number()
      "0832"
  """
  @spec building_number() :: String.t()
  def building_number do
    ["s/n", "####", "###", "##", "#"]
    |> Enum.at(Faker.random_between(0, 4))
    |> Faker.format()
  end

  @doc """
  Return city name.

  ## Examples

      iex> Faker.Address.PtBr.city()
      "Senador Kaique Paulista"
      iex> Faker.Address.PtBr.city()
      "São Roberta dos Dourados"
      iex> Faker.Address.PtBr.city()
      "Salto das Flores"
      iex> Faker.Address.PtBr.city()
      "Kléber"
  """
  @spec city() :: String.t()
  def city do
    city(Faker.random_between(0, 6))
  end

  def city(0), do: "#{PtBr.first_name()} #{city_suffixes()}"
  def city(1), do: "#{PtBr.first_name()} #{city_suffixes()}"
  def city(2), do: "#{city_prefix()} #{PtBr.first_name()} #{city_suffixes()}"
  def city(3), do: "#{PtBr.first_name()}"
  def city(4), do: "#{city_prefix()} #{PtBr.first_name()}"
  def city(5), do: "#{city_prefix()} #{city_suffixes()}"
  def city(6), do: "#{city_prefix()} #{PtBr.first_name()} #{city_suffixes()}"

  @doc """
  Return city suffixes.

  ## Examples

      iex> Faker.Address.PtBr.city_suffixes()
      "da Serra"
      iex> Faker.Address.PtBr.city_suffixes()
      "dos Dourados"
      iex> Faker.Address.PtBr.city_suffixes()
      "da Serra"
      iex> Faker.Address.PtBr.city_suffixes()
      "Paulista"
  """
  @spec city_suffixes() :: String.t()
  sampler(:city_suffixes, [
    "do Sul",
    "do Norte",
    "de Minas",
    "do Campo",
    "Grande",
    "da Serra",
    "do Oeste",
    "de Goiás",
    "Paulista",
    "da Mata",
    "Alegre",
    "da Praia",
    "das Flores",
    "das Pedras",
    "dos Dourados",
    "do Amparo",
    "do Galho",
    "da Prata",
    "Verde"
  ])

  @doc """
  Return city suffixes.

  ## Examples

      iex> Faker.Address.PtBr.city_prefix()
      "Santo"
      iex> Faker.Address.PtBr.city_prefix()
      "Senador"
      iex> Faker.Address.PtBr.city_prefix()
      "Senador"
      iex> Faker.Address.PtBr.city_prefix()
      "Alta"
  """
  @spec city_prefix() :: String.t()
  sampler(:city_prefix, [
    "Agua",
    "Boa",
    "Barra",
    "Coronel",
    "Nova",
    "Boa",
    "Alta",
    "Bento",
    "Porto",
    "Praia",
    "Ribeirão",
    "Rio",
    "Salto",
    "Santa",
    "Santo",
    "Santana",
    "São",
    "Senador",
    "Serra",
    "Três",
    "Vale",
    "Vila"
  ])

  @doc """
  Return country.

  ## Examples

      iex> Faker.Address.PtBr.country()
      "Ilhas Virgens Britânicas"
      iex> Faker.Address.PtBr.country()
      "Coreia do Sul"
      iex> Faker.Address.PtBr.country()
      "Bolívia"
      iex> Faker.Address.PtBr.country()
      "Mongólia"
  """
  @spec country() :: String.t()
  sampler(:country, [
    "Afeganistão",
    "África do Sul",
    "Akrotiri",
    "Albânia",
    "Alemanha",
    "Andorra",
    "Angola",
    "Anguila",
    "Antártica",
    "Antígua e Barbuda",
    "Antilhas Holandesas",
    "Arábia Saudita",
    "Argélia",
    "Argentina",
    "Armênia",
    "Aruba",
    "Ashmore and Cartier Islands",
    "Austrália",
    "Áustria",
    "Azerbaijão",
    "Bahamas",
    "Bangladesh",
    "Barbados",
    "Barein",
    "Bélgica",
    "Belize",
    "Benim",
    "Bermudas",
    "Bielorrússia",
    "Birmânia",
    "Bolívia",
    "Bósnia e Herzegovina",
    "Botsuana",
    "Brasil",
    "Brunei",
    "Bulgária",
    "Burquina Faso",
    "Burundi",
    "Butão",
    "Cabo Verde",
    "Camarões",
    "Camboja",
    "Canadá",
    "Catar",
    "Cazaquistão",
    "Chade",
    "Chile",
    "China",
    "Chipre",
    "Clipperton Island",
    "Colômbia",
    "Comores",
    "Congo-Brazzaville",
    "Congo-Kinshasa",
    "Coral Sea Islands",
    "Coreia do Norte",
    "Coreia do Sul",
    "Costa do Marfim",
    "Costa Rica",
    "Croácia",
    "Cuba",
    "Dhekelia",
    "Dinamarca",
    "Domínica",
    "Egito",
    "Costa do Marfim",
    "Costa Rica",
    "Croácia",
    "Cuba",
    "Dhekelia",
    "Dinamarca",
    "Domínica",
    "Egito",
    "Emirados Árabes Unidos",
    "Equador",
    "Eritreia",
    "Eslováquia",
    "Eslovênia",
    "Espanha",
    "Estados Unidos",
    "Estônia",
    "Etiópia",
    "Faroé",
    "Fiji",
    "Filipinas",
    "Finlândia",
    "França",
    "Gabão",
    "Gâmbia",
    "Gana",
    "Geórgia",
    "Geórgia do Sul e Sandwich do Sul",
    "Gibraltar",
    "Granada",
    "Grécia",
    "Gronelândia",
    "Guam",
    "Guatemala",
    "Guernsey",
    "Guiana",
    "Guiné",
    "Guiné Equatorial",
    "Guiné-Bissau",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungria",
    "Iêmen",
    "Ilha Bouvet",
    "Ilha do Natal",
    "Ilha Norfolk",
    "Ilhas Caiman",
    "Ilhas Cook",
    "Ilhas dos Cocos",
    "Ilhas Falkland",
    "Ilhas Heard e McDonald",
    "Ilhas Marshall",
    "Ilhas Salomão",
    "Ilhas Turcas e Caicos",
    "Ilhas Virgens Americanas",
    "Ilhas Virgens Britânicas",
    "Índia",
    "Indonésia",
    "Iran",
    "Iraque",
    "Irlanda",
    "Islândia",
    "Israel",
    "Itália",
    "Jamaica",
    "Jan Mayen",
    "Japão",
    "Jersey",
    "Jibuti",
    "Jordânia",
    "Kuwait",
    "Laos",
    "Lesoto",
    "Letônia",
    "Líbano",
    "Libéria",
    "Líbia",
    "Liechtenstein",
    "Lituânia",
    "Luxemburgo",
    "Macau",
    "Macedônia",
    "Madagáscar",
    "Malásia",
    "Malávi",
    "Maldivas",
    "Mali",
    "Malta",
    "Man, Isle of",
    "Marianas do Norte",
    "Marrocos",
    "Maurícia",
    "Mauritânia",
    "Mayotte",
    "México",
    "Micronésia",
    "Moçambique",
    "Moldávia",
    "Mônaco",
    "Mongólia",
    "Monserrate",
    "Montenegro",
    "Namíbia",
    "Nauru",
    "Navassa Island",
    "Nepal",
    "Nicarágua",
    "Níger",
    "Nigéria",
    "Niue",
    "Noruega",
    "Nova Caledónia",
    "Nova Zelândia",
    "Omã",
    "Países Baixos",
    "Palau",
    "Panamá",
    "Papua-Nova Guiné",
    "Paquistão",
    "Paracel Islands",
    "Paraguai",
    "Peru",
    "Pitcairn",
    "Polinésia Francesa",
    "Polônia",
    "Porto Rico",
    "Portugal",
    "Quênia",
    "Quirguizistão",
    "Quiribáti",
    "Reino Unido",
    "República Centro-Africana",
    "República Checa",
    "República Dominicana",
    "Roménia",
    "Ruanda",
    "Rússia",
    "Salvador",
    "Samoa",
    "Samoa Americana",
    "Santa Helena",
    "Santa Lúcia",
    "São Cristóvão e Neves",
    "São Marinho",
    "São Pedro e Miquelon",
    "São Tomé e Príncipe",
    "São Vicente e Granadinas",
    "Sara Ocidental",
    "Seicheles",
    "Senegal",
    "Serra Leoa",
    "Sérvia",
    "Singapura",
    "Síria",
    "Somália",
    "Sri Lanka",
    "Suazilândia",
    "Sudão",
    "Suécia",
    "Suíça",
    "Suriname",
    "Svalbard e Jan Mayen",
    "Tailândia",
    "Taiwan",
    "Tajiquistão",
    "Tanzânia",
    "Território Britânico do Oceano Índico",
    "Territórios Austrais Franceses",
    "Timor Leste",
    "Togo",
    "Tokelau",
    "Tonga",
    "Trindade e Tobago",
    "Tunísia",
    "Turquemenistão",
    "Turquia",
    "Tuvalu",
    "Ucrânia",
    "Uganda",
    "União Europeia",
    "Uruguai",
    "Usbequistão",
    "Vanuatu",
    "Vaticano",
    "Venezuela",
    "Vietnam",
    "Wake Island",
    "Wallis e Futuna",
    "Zâmbia",
    "Zimbabu"
  ])

  @doc """
  Return country code.

  ## Examples

      iex> Faker.Address.PtBr.country_code()
      "BR"
  """
  @spec country_code() :: String.t()
  sampler(:country_code, ["BR"])

  @doc """
  Return random secondary address.

  ## Examples

      iex> Faker.Address.PtBr.secondary_address()
      "Sala 154"
      iex> Faker.Address.PtBr.secondary_address()
      "Sala 646"
      iex> Faker.Address.PtBr.secondary_address()
      "AP 083"
      iex> Faker.Address.PtBr.secondary_address()
      "Sala 970"
  """
  @spec secondary_address() :: String.t()
  def secondary_address do
    ["Sala ###", "AP ###"]
    |> Enum.at(Faker.random_between(0, 1))
    |> Faker.format()
  end

  @doc """
  Return state.

  ## Examples

      iex> Faker.Address.PtBr.state()
      "Rondônia"
      iex> Faker.Address.PtBr.state()
      "Rio Grande do Sul"
      iex> Faker.Address.PtBr.state()
      "Distrito Federal"
      iex> Faker.Address.PtBr.state()
      "Ceará"
  """
  @spec state() :: String.t()
  sampler(:state, [
    "Acre",
    "Alagoas",
    "Amapá",
    "Amazonas",
    "Bahia",
    "Ceará",
    "Distrito Federal",
    "Espírito Santo",
    "Goiás",
    "Maranhão",
    "Mato Grosso",
    "Mato Grosso do Sul",
    "Minas Gerais",
    "Pará",
    "Paraíba",
    "Paraná",
    "Pernambuco",
    "Piauí",
    "Rio de Janeiro",
    "Rio Grande do Norte",
    "Rio Grande do Sul",
    "Rondônia",
    "Roraima",
    "Santa Catarina",
    "São Paulo",
    "Sergipe",
    "Tocantins"
  ])

  @doc """
  Return neighborhood.

  ## Examples

      iex> Faker.Address.PtBr.neighborhood()
      "Granja De Freitas"
      iex> Faker.Address.PtBr.neighborhood()
      "Novo Ouro Preto"
      iex> Faker.Address.PtBr.neighborhood()
      "Padre Eustáquio"
      iex> Faker.Address.PtBr.neighborhood()
      "Nossa Senhora Aparecida"
  """

  @spec neighborhood() :: String.t()
  sampler(:neighborhood, [
    "Aarão Reis",
    "Acaba Mundo",
    "Acaiaca",
    "Ademar Maldonado",
    "Aeroporto",
    "Aguas Claras",
    "Alípio De Melo",
    "Alpes",
    "Alta Tensão 1ª Seção",
    "Alta Tensão 2ª Seção",
    "Alto Caiçaras",
    "Alto Das Antenas",
    "Alto Dos Pinheiros",
    "Alto Vera Cruz",
    "Álvaro Camargos",
    "Ambrosina",
    "Andiroba",
    "Antonio Ribeiro De Abreu 1ª Seção",
    "Aparecida 7ª Seção",
    "Ápia",
    "Apolonia",
    "Araguaia",
    "Atila De Paiva",
    "Bacurau",
    "Bairro Das Indústrias Ii",
    "Baleia",
    "Barão Homem De Melo 1ª Seção",
    "Barão Homem De Melo 2ª Seção",
    "Barão Homem De Melo 3ª Seção",
    "Barreiro",
    "Beija Flor",
    "Beira Linha",
    "Bela Vitoria",
    "Belmonte",
    "Bernadete",
    "Betânia",
    "Biquinhas",
    "Boa Esperança",
    "Boa União 1ª Seção",
    "Boa União 2ª Seção",
    "Boa Viagem",
    "Boa Vista",
    "Bom Jesus",
    "Bonfim",
    "Bonsucesso",
    "Brasil Industrial",
    "Braúnas",
    "Buraco Quente",
    "Cabana Do Pai Tomás",
    "Cachoeirinha",
    "Caetano Furquim",
    "Caiçara - Adelaide",
    "Calafate",
    "Califórnia",
    "Camargos",
    "Campo Alegre",
    "Camponesa 1ª Seção",
    "Camponesa 2ª Seção",
    "Canaa",
    "Canadá",
    "Candelaria",
    "Capitão Eduardo",
    "Cardoso",
    "Casa Branca",
    "Castanheira",
    "Cdi Jatoba",
    "Cenaculo",
    "Céu Azul",
    "Chácara Leonina",
    "Cidade Jardim Taquaril",
    "Cinquentenário",
    "Colégio Batista",
    "Comiteco",
    "Concórdia",
    "Cônego Pinheiro 1ª Seção",
    "Cônego Pinheiro 2ª Seção",
    "Confisco",
    "Conjunto Bonsucesso",
    "Conjunto Califórnia I",
    "Conjunto Califórnia Ii",
    "Conjunto Capitão Eduardo",
    "Conjunto Celso Machado",
    "Conjunto Floramar",
    "Conjunto Jardim Filadélfia",
    "Conjunto Jatoba",
    "Conjunto Lagoa",
    "Conjunto Minas Caixa",
    "Conjunto Novo Dom Bosco",
    "Conjunto Paulo Vi",
    "Conjunto Providencia",
    "Conjunto Santa Maria",
    "Conjunto São Francisco De Assis",
    "Conjunto Serra Verde",
    "Conjunto Taquaril",
    "Copacabana",
    "Coqueiros",
    "Corumbiara",
    "Custodinha",
    "Das Industrias I",
    "Delta",
    "Diamante",
    "Distrito Industrial Do Jatoba",
    "Dom Bosco",
    "Dom Cabral",
    "Dom Joaquim",
    "Dom Silverio",
    "Dona Clara",
    "Embaúbas",
    "Engenho Nogueira",
    "Ermelinda",
    "Ernesto Nascimento",
    "Esperança",
    "Estrela",
    "Estrela Do Oriente",
    "Etelvina Carneiro",
    "Europa",
    "Eymard",
    "Fazendinha",
    "Flamengo",
    "Flavio De Oliveira",
    "Flavio Marques Lisboa",
    "Floramar",
    "Frei Leopoldo",
    "Gameleira",
    "Garças",
    "Glória",
    "Goiania",
    "Graça",
    "Granja De Freitas",
    "Granja Werneck",
    "Grota",
    "Grotinha",
    "Guarani",
    "Guaratã",
    "Havaí",
    "Heliopolis",
    "Horto Florestal",
    "Inconfidência",
    "Indaiá",
    "Independência",
    "Ipe",
    "Itapoa",
    "Itatiaia",
    "Jaqueline",
    "Jaraguá",
    "Jardim Alvorada",
    "Jardim Atlântico",
    "Jardim Do Vale",
    "Jardim Dos Comerciarios",
    "Jardim Felicidade",
    "Jardim Guanabara",
    "Jardim Leblon",
    "Jardim Montanhês",
    "Jardim São José",
    "Jardim Vitoria",
    "Jardinópolis",
    "Jatobá",
    "João Alfredo",
    "João Paulo Ii",
    "Jonas Veiga",
    "Juliana",
    "Lagoa",
    "Lagoinha",
    "Lagoinha Leblon",
    "Lajedo",
    "Laranjeiras",
    "Leonina",
    "Leticia",
    "Liberdade",
    "Lindéia",
    "Lorena",
    "Madre Gertrudes",
    "Madri",
    "Mala E Cuia",
    "Manacas",
    "Mangueiras",
    "Mantiqueira",
    "Marajó",
    "Maravilha",
    "Marçola",
    "Maria Goretti",
    "Maria Helena",
    "Maria Tereza",
    "Maria Virgínia",
    "Mariano De Abreu",
    "Marieta 1ª Seção",
    "Marieta 2ª Seção",
    "Marieta 3ª Seção",
    "Marilandia",
    "Mariquinhas",
    "Marmiteiros",
    "Milionario",
    "Minas Brasil",
    "Minas Caixa",
    "Minaslandia",
    "Mineirão",
    "Miramar",
    "Mirante",
    "Mirtes",
    "Monsenhor Messias",
    "Monte Azul",
    "Monte São José",
    "Morro Dos Macacos",
    "Nazare",
    "Nossa Senhora Aparecida",
    "Nossa Senhora Da Aparecida",
    "Nossa Senhora Da Conceição",
    "Nossa Senhora De Fátima",
    "Nossa Senhora Do Rosário",
    "Nova America",
    "Nova Cachoeirinha",
    "Nova Cintra",
    "Nova Esperança",
    "Nova Floresta",
    "Nova Gameleira",
    "Nova Pampulha",
    "Novo Aarão Reis",
    "Novo Das Industrias",
    "Novo Glória",
    "Novo Santa Cecilia",
    "Novo Tupi",
    "Oeste",
    "Olaria",
    "Olhos D'água",
    "Ouro Minas",
    "Pantanal",
    "Paquetá",
    "Paraíso",
    "Parque São José",
    "Parque São Pedro",
    "Paulo Vi",
    "Pedreira Padro Lopes",
    "Penha",
    "Petropolis",
    "Pilar",
    "Pindorama",
    "Pindura Saia",
    "Piraja",
    "Piratininga",
    "Pirineus",
    "Pompéia",
    "Pongelupe",
    "Pousada Santo Antonio",
    "Primeiro De Maio",
    "Providencia",
    "Ribeiro De Abreu",
    "Rio Branco",
    "Salgado Filho",
    "Santa Amelia",
    "Santa Branca",
    "Santa Cecilia",
    "Santa Cruz",
    "Santa Helena",
    "Santa Inês",
    "Santa Isabel",
    "Santa Margarida",
    "Santa Maria",
    "Santa Rita",
    "Santa Rita De Cássia",
    "Santa Sofia",
    "Santa Terezinha",
    "Santana Do Cafezal",
    "Santo André",
    "São Benedito",
    "São Bernardo",
    "São Cristóvão",
    "São Damião",
    "São Francisco",
    "São Francisco Das Chagas",
    "São Gabriel",
    "São Geraldo",
    "São Gonçalo",
    "São João",
    "São João Batista",
    "São Jorge 1ª Seção",
    "São Jorge 2ª Seção",
    "São Jorge 3ª Seção",
    "São José",
    "São Marcos",
    "São Paulo",
    "São Salvador",
    "São Sebastião",
    "São Tomaz",
    "São Vicente",
    "Satelite",
    "Saudade",
    "Senhor Dos Passos",
    "Serra Do Curral",
    "Serra Verde",
    "Serrano",
    "Solar Do Barreiro",
    "Solimoes",
    "Sport Club",
    "Suzana",
    "Taquaril",
    "Teixeira Dias",
    "Tiradentes",
    "Tirol",
    "Tres Marias",
    "Trevo",
    "Túnel De Ibirité",
    "Tupi A",
    "Tupi B",
    "União",
    "Unidas",
    "Universitário",
    "Universo",
    "Urca",
    "Vale Do Jatoba",
    "Varzea Da Palma",
    "Venda Nova",
    "Ventosa",
    "Vera Cruz",
    "Vila Aeroporto",
    "Vila Aeroporto Jaraguá",
    "Vila Antena",
    "Vila Antena Montanhês",
    "Vila Atila De Paiva",
    "Vila Bandeirantes",
    "Vila Barragem Santa Lúcia",
    "Vila Batik",
    "Vila Betânia",
    "Vila Boa Vista",
    "Vila Calafate",
    "Vila Califórnia",
    "Vila Canto Do Sabiá",
    "Vila Cemig",
    "Vila Cloris",
    "Vila Copacabana",
    "Vila Copasa",
    "Vila Coqueiral",
    "Vila Da Amizade",
    "Vila Da Ária",
    "Vila Da Luz",
    "Vila Da Paz",
    "Vila Das Oliveiras",
    "Vila Do Pombal",
    "Vila Dos Anjos",
    "Vila Ecológica",
    "Vila Engenho Nogueira",
    "Vila Esplanada",
    "Vila Formosa",
    "Vila Fumec",
    "Vila Havaí",
    "Vila Independencia 1ª Seção",
    "Vila Independencia 2ª Seção",
    "Vila Independencia 3ª Seção",
    "Vila Inestan",
    "Vila Ipiranga",
    "Vila Jardim Alvorada",
    "Vila Jardim Leblon",
    "Vila Jardim São José",
    "Vila Madre Gertrudes 1ª Seção",
    "Vila Madre Gertrudes 2ª Seção",
    "Vila Madre Gertrudes 3ª Seção",
    "Vila Madre Gertrudes 4ª Seção",
    "Vila Maloca",
    "Vila Mangueiras",
    "Vila Mantiqueira",
    "Vila Maria",
    "Vila Minaslandia",
    "Vila Nossa Senhora Do Rosário",
    "Vila Nova",
    "Vila Nova Cachoeirinha 1ª Seção",
    "Vila Nova Cachoeirinha 2ª Seção",
    "Vila Nova Cachoeirinha 3ª Seção",
    "Vila Nova Dos Milionarios",
    "Vila Nova Gameleira 1ª Seção",
    "Vila Nova Gameleira 2ª Seção",
    "Vila Nova Gameleira 3ª Seção",
    "Vila Nova Paraíso",
    "Vila Novo São Lucas",
    "Vila Oeste",
    "Vila Olhos D'água",
    "Vila Ouro Minas",
    "Vila Paquetá",
    "Vila Paraíso",
    "Vila Petropolis",
    "Vila Pilar",
    "Vila Pinho",
    "Vila Piratininga",
    "Vila Piratininga Venda Nova",
    "Vila Primeiro De Maio",
    "Vila Puc",
    "Vila Real 1ª Seção",
    "Vila Real 2ª Seção",
    "Vila Rica",
    "Vila Santa Monica 1ª Seção",
    "Vila Santa Monica 2ª Seção",
    "Vila Santa Rosa",
    "Vila Santo Antônio",
    "Vila Santo Antônio Barroquinha",
    "Vila São Dimas",
    "Vila São Francisco",
    "Vila São Gabriel",
    "Vila São Gabriel Jacui",
    "Vila São Geraldo",
    "Vila São João Batista",
    "Vila São Paulo",
    "Vila São Rafael",
    "Vila Satélite",
    "Vila Sesc",
    "Vila Sumaré",
    "Vila Suzana Primeira Seção",
    "Vila Suzana Segunda Seção",
    "Vila Tirol",
    "Vila Trinta E Um De Março",
    "Vila União",
    "Vila Vista Alegre",
    "Virgínia",
    "Vista Alegre",
    "Vista Do Sol",
    "Vitoria",
    "Vitoria Da Conquista",
    "Xangri-Lá",
    "Xodo-Marize",
    "Zilah Sposito",
    "Outro",
    "Novo São Lucas",
    "Esplanada",
    "Estoril",
    "Novo Ouro Preto",
    "Ouro Preto",
    "Padre Eustáquio",
    "Palmares",
    "Palmeiras",
    "Vila De Sá",
    "Floresta",
    "Anchieta",
    "Aparecida",
    "Grajaú",
    "Planalto",
    "Bandeirantes",
    "Gutierrez",
    "Jardim América",
    "Renascença",
    "Barro Preto",
    "Barroca",
    "Sagrada Família",
    "Ipiranga",
    "Belvedere",
    "Santa Efigênia",
    "Santa Lúcia",
    "Santa Monica",
    "Vila Jardim Montanhes",
    "Santa Rosa",
    "Santa Tereza",
    "Buritis",
    "Vila Paris",
    "Santo Agostinho",
    "Santo Antônio",
    "Caiçaras",
    "São Bento",
    "Prado",
    "Lourdes",
    "Fernão Dias",
    "Carlos Prates",
    "Carmo",
    "Luxemburgo",
    "São Lucas",
    "São Luiz",
    "Mangabeiras",
    "São Pedro",
    "Horto",
    "Cidade Jardim",
    "Castelo",
    "Cidade Nova",
    "Savassi",
    "Serra",
    "Silveira",
    "Sion",
    "Centro",
    "Alto Barroca",
    "Nova Vista",
    "Coração De Jesus",
    "Coração Eucarístico",
    "Funcionários",
    "Cruzeiro",
    "João Pinheiro",
    "Nova Granada",
    "Nova Suíça",
    "Itaipu"
  ])

  @doc """
  Return state abbr.

  ## Examples

      iex> Faker.Address.PtBr.state_abbr()
      "RO"
      iex> Faker.Address.PtBr.state_abbr()
      "RS"
      iex> Faker.Address.PtBr.state_abbr()
      "DF"
      iex> Faker.Address.PtBr.state_abbr()
      "CE"
  """
  @spec state_abbr() :: String.t()
  sampler(:state_abbr, [
    "AC",
    "AL",
    "AP",
    "AM",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SP",
    "SE",
    "TO"
  ])

  @doc """
  Return street address.

  ## Examples

      iex> Faker.Address.PtBr.street_address()
      "Estação Kaique, 2"
      iex> Faker.Address.PtBr.street_address()
      "Lagoa Matheus, 0832"
      iex> Faker.Address.PtBr.street_address()
      "Estrada Diegues, s/n"
      iex> Faker.Address.PtBr.street_address()
      "Praia Limeira, 020"
  """
  @spec street_address() :: String.t()
  def street_address do
    "#{street_name()}, #{building_number()}"
  end

  @doc """
  Return `street_address/0` or if argument is `true` adds `secondary_address/0`.

  ## Examples

      iex> Faker.Address.PtBr.street_address(true)
      "Estação Kaique, 2 Sala 461"
      iex> Faker.Address.PtBr.street_address(false)
      "Conjunto Rodrigo, 970"
      iex> Faker.Address.PtBr.street_address(false)
      "Trecho Davi Luiz Limeira, 020"
      iex> Faker.Address.PtBr.street_address(false)
      "Sítio Maria Eduarda, 097"
  """
  @spec street_address(true | any) :: String.t()
  def street_address(true), do: street_address() <> " " <> secondary_address()
  def street_address(_), do: street_address()

  @doc """
  Return street name.

  ## Examples

      iex> Faker.Address.PtBr.street_name()
      "Estação Kaique"
      iex> Faker.Address.PtBr.street_name()
      "Morro Louise Macieira"
      iex> Faker.Address.PtBr.street_name()
      "Loteamento Maria Alice Junqueira"
      iex> Faker.Address.PtBr.street_name()
      "Condomínio da Maia"
  """
  @spec street_name() :: String.t()
  def street_name do
    street_name(Faker.random_between(0, 2))
  end

  defp street_name(0), do: "#{street_prefix()} #{PtBr.first_name()}"
  defp street_name(1), do: "#{street_prefix()} #{PtBr.last_name()}"

  defp street_name(2),
    do: "#{street_prefix()} #{PtBr.first_name()} #{PtBr.last_name()}"

  @doc """
  Return street prefix.

  ## Examples

      iex> Faker.Address.PtBr.street_prefix()
      "Recanto"
      iex> Faker.Address.PtBr.street_prefix()
      "Estação"
      iex> Faker.Address.PtBr.street_prefix()
      "Feira"
      iex> Faker.Address.PtBr.street_prefix()
      "Fazenda"
  """
  @spec street_prefix() :: String.t()
  sampler(:street_prefix, [
    "Aeroporto",
    "Alameda",
    "Área",
    "Avenida",
    "Campo",
    "Chácara",
    "Colônia",
    "Condomínio",
    "Conjunto",
    "Distrito",
    "Esplanada",
    "Estação",
    "Estrada",
    "Favela",
    "Fazenda",
    "Feira",
    "Jardim",
    "Ladeira",
    "Lago",
    "Lagoa",
    "Largo",
    "Loteamento",
    "Morro",
    "Núcleo",
    "Parque",
    "Passarela",
    "Pátio",
    "Praça",
    "Praia",
    "Quadra",
    "Recanto",
    "Residencial",
    "Rodovia",
    "Rua",
    "Setor",
    "Sítio",
    "Travessa",
    "Trecho",
    "Trevo",
    "Vale",
    "Vereda",
    "Via",
    "Viaduto",
    "Viela",
    "Vila"
  ])

  @doc """
  Return time zone.

  ## Examples

      iex> Faker.Address.PtBr.time_zone()
      "Australia/Sydney"
      iex> Faker.Address.PtBr.time_zone()
      "America/Guyana"
      iex> Faker.Address.PtBr.time_zone()
      "Asia/Kathmandu"
      iex> Faker.Address.PtBr.time_zone()
      "Europa/Vienna"
  """
  @spec time_zone() :: String.t()
  sampler(:time_zone, [
    "Pacífico/Midway",
    "Pacífico/Pago_Pago",
    "Pacífico/Honolulu",
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
    "Pacífico/Guam",
    "Pacífico/Port_Moresby",
    "Asia/Magadan",
    "Pacífico/Noumea",
    "Pacífico/Fiji",
    "Asia/Kamchatka",
    "Pacífico/Majuro",
    "Pacífico/Auckland",
    "Pacífico/Tongatapu",
    "Pacífico/Fakaofo",
    "Pacífico/Apia"
  ])

  @doc """
  Return random postcode.

  ## Examples

      iex> Faker.Address.PtBr.zip_code()
      "15426461"
      iex> Faker.Address.PtBr.zip_code()
      "83297052"
      iex> Faker.Address.PtBr.zip_code()
      "57.020-303"
      iex> Faker.Address.PtBr.zip_code()
      "09733-760"
  """
  @spec zip_code() :: String.t()
  def zip_code do
    ["########", "##.###-###", "#####-###"]
    |> Enum.at(Faker.random_between(0, 2))
    |> Faker.format()
  end
end
