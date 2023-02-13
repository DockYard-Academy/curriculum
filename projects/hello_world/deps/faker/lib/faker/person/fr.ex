defmodule Faker.Person.Fr do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for name data in French
  """

  @doc """
  Returns a complete name (may include a suffix/prefix or both)

  ## Examples
      iex> Faker.Person.Fr.name()
      "Madame Marcel Duplantier MD"
      iex> Faker.Person.Fr.name()
      "Quentin Garnier"
      iex> Faker.Person.Fr.name()
      "Docteur Camille Fontaine"
      iex> Faker.Person.Fr.name()
      "Serge Bassett V"
  """
  @spec name() :: String.t()
  def name, do: name(Faker.random_between(0, 9))
  defp name(0), do: "#{prefix()} #{first_name()} #{last_name()} #{suffix()}"
  defp name(1), do: "#{prefix()} #{first_name()} #{last_name()}"
  defp name(2), do: "#{first_name()} #{last_name()} #{suffix()}"

  defp name(n) when is_integer(n) do
    "#{first_name()} #{last_name()}"
  end

  @doc """
  Returns a random first name

  ## Examples
    
      iex> Faker.Person.Fr.first_name()
      "Damien"
      iex> Faker.Person.Fr.first_name()
      "Madeleine"
      iex> Faker.Person.Fr.first_name()
      "Marcel"
      iex> Faker.Person.Fr.first_name()
      "Fabrice"
  """
  @spec first_name() :: String.t()
  sampler(:first_name, [
    "Adrien",
    "Alexandra",
    "Alice",
    "Aline",
    "Amandine",
    "Anne",
    "Anne-Marie",
    "Annick",
    "Annie",
    "Audrey",
    "Aurore",
    "Alain",
    "Albert",
    "Alexandre",
    "Alexis",
    "Antoine",
    "Arnaud",
    "Arthur",
    "Baptiste",
    "Benjamin",
    "Bernard",
    "Bertrand",
    "Bruno",
    "Brigitte",
    "Bernadette",
    "Charles",
    "Christian",
    "Christophe",
    "Camille",
    "Carole",
    "Caroline",
    "Catherine",
    "Chantal",
    "Christiane",
    "Christine",
    "Claire",
    "Clara",
    "Colette",
    "Claude",
    "Cyril",
    "Damien",
    "Daniel",
    "Danielle",
    "Delphine",
    "Denise",
    "Dominique",
    "David",
    "Denis",
    "Didier",
    "Dominique",
    "Dylan",
    "Emmanuel",
    "Enzo",
    "Emma",
    "Emmanuelle",
    "Estelle",
    "Fabien",
    "Fabrice",
    "Florent",
    "Floriant",
    "Francis",
    "Franck",
    "Fabienne",
    "Fanny",
    "Florence",
    "Francine",
    "Gabriel",
    "Georges",
    "Gilbert",
    "Georgette",
    "Germaine",
    "Ghislaine",
    "Gilles",
    "Ginette",
    "Guillaume",
    "Guy",
    "Henri",
    "Hugo",
    "Henriette",
    "Huguette",
    "Isabelle",
    "Jacques",
    "Jean",
    "Jacqueline",
    "Janine",
    "Jeanne",
    "Jean-Claude",
    "Jeannine",
    "Jennifer",
    "Jessica",
    "Jocelyne",
    "Josette",
    "Julie",
    "Jean-Louis",
    "Juliette",
    "Justine",
    "Jean-Luc",
    "Jean-Marc",
    "Jean-Marie",
    "Jean-Michel",
    "Jean-Paul",
    "Jean-Pierre",
    "Jonathan",
    "Joseph",
    "Julien",
    "Kevin",
    "Karine",
    "Laurent",
    "Lionel",
    "Laetitia",
    "Laura",
    "Laure",
    "Laurence",
    "Liliane",
    "Louise",
    "Lucie",
    "Lydie",
    "Lydia",
    "Louis",
    "Luc",
    "Lucas",
    "Lucien",
    "Ludovic",
    "Marc",
    "Marcel",
    "Mathieu",
    "Maurice",
    "Madeleine",
    "Magali",
    "Manon",
    "Maria",
    "Marie",
    "Marie-Christine",
    "Marie-Claude",
    "Maxime",
    "Marine",
    "Michel",
    "Mohamed",
    "Nicolas",
    "Nicole",
    "Olivier",
    "Odette",
    "Odile",
    "Pascal",
    "Patrice",
    "Patrick",
    "Pascale",
    "Patricia",
    "Paulette",
    "Pauline",
    "Pierrette",
    "Paul",
    "Philippe",
    "Pierre",
    "Quentin",
    "Raymond",
    "Richard",
    "Raymonde",
    "Robert",
    "Roger",
    "Roland",
    "Romain",
    "Samuel",
    "Serge",
    "Sabine",
    "Sabrina",
    "Sandra",
    "Sandrine",
    "Simone",
    "Sarah",
    "Samara",
    "Solange",
    "Sonia",
    "Sophie",
    "Simon",
    "Suzanne",
    "Sylvain",
    "Thierry",
    "Thomas",
    "Valentin",
    "Vanessa",
    "Virginie",
    "Victor",
    "Vincent",
    "William",
    "Yann",
    "Yannick",
    "Yvette",
    "Yves",
    "Yvonne",
    "Xavier"
  ])

  @doc """
  Returns a random last name

    ## Examples

    iex> Faker.Person.Fr.last_name()
    "Bassett"
    iex> Faker.Person.Fr.last_name()
    "Duplantier"
    iex> Faker.Person.Fr.last_name()
    "Boivin"
    iex> Faker.Person.Fr.last_name()
    "Duplantier"
  """
  @spec last_name() :: String.t()
  sampler(:last_name, [
    "Abadie",
    "Allemand",
    "Auclair",
    "Bassett",
    "Beaumont",
    "Blanchet",
    "Boivin",
    "Boucher",
    "Beaufort",
    "Bonnet",
    "Chevrolet",
    "Corbin",
    "Cartier",
    "Chastain",
    "Couture",
    "Dubois",
    "Dupont",
    "Duplantier",
    "Fournier",
    "Fontaine",
    "Garnier",
    "Laurent",
    "Lavigne",
    "Leroy",
    "Lyon",
    "LaRue",
    "Martin",
    "Moulin",
    "Moreau",
    "Renaud",
    "Rousseau",
    "Toussaint",
    "Vernier"
  ])

  @doc """
  Returns a random prefix

  ## Examples
      
      iex> Faker.Person.Fr.prefix()
      "Docteur"
      iex> Faker.Person.Fr.prefix()
      "Madame"
      iex> Faker.Person.Fr.prefix()
      "Docteur"
      iex> Faker.Person.Fr.prefix()
      "Professeur"
  """
  @spec prefix() :: String.t()
  sampler(:prefix, [
    "Docteur",
    "Madame",
    "Mademoiselle",
    "Monsieur",
    "Professeur"
  ])

  @doc """
  Returns a random suffix

  ## Examples

      iex> Faker.Person.Fr.suffix()
      "V"
      iex> Faker.Person.Fr.suffix()
      "I"
      iex> Faker.Person.Fr.suffix()
      "PhD"
      iex> Faker.Person.Fr.suffix()
      "MD"
  """
  @spec suffix() :: String.t()
  sampler(:suffix, [
    "MD",
    "I",
    "V",
    "PhD"
  ])
end

# Faker.Person.Fr
