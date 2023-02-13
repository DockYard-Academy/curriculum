defmodule Faker.Commerce do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating commerce related data
  """

  @doc """
  Returns a random color

  ## Examples

      iex> Faker.Commerce.color()
      "red"
      iex> Faker.Commerce.color()
      "sky blue"
      iex> Faker.Commerce.color()
      "lavender"
      iex> Faker.Commerce.color()
      "grey"
  """
  @spec color() :: String.t()
  localize(:color)

  @doc """
  Returns a random department

  ## Examples

      iex> Faker.Commerce.department()
      "Home, Garden & Tools"
      iex> Faker.Commerce.department()
      "Electronics & Computers"
      iex> Faker.Commerce.department()
      "Clothing, Shoes & Jewelery"
      iex> Faker.Commerce.department()
      "Toys, Kids & Baby"
  """
  @spec department() :: String.t()
  localize(:department)

  @doc """
  Returns a random number that represents a price

  ## Examples

      iex> Faker.Commerce.price()
      1.11
      iex> Faker.Commerce.price()
      4.02
      iex> Faker.Commerce.price()
      8.36
      iex> Faker.Commerce.price()
      3.05
  """
  @spec price() :: float
  def price do
    Faker.random_between(1, 1000) / 100.0
  end

  @doc """
  Returns a complete product name, based on product adjectives, product
  materials, product names

  ## Examples

      iex> Faker.Commerce.product_name()
      "Ergonomic Steel Shirt"
      iex> Faker.Commerce.product_name()
      "Fantastic Car"
      iex> Faker.Commerce.product_name()
      "Granite Gloves"
      iex> Faker.Commerce.product_name()
      "Plastic Shoes"
  """
  @spec product_name() :: String.t()
  localize(:product_name)

  @doc """
  Returns a random adjective for a product

  ## Examples

      iex> Faker.Commerce.product_name_adjective()
      "Small"
      iex> Faker.Commerce.product_name_adjective()
      "Ergonomic"
      iex> Faker.Commerce.product_name_adjective()
      "Incredible"
      iex> Faker.Commerce.product_name_adjective()
      "Gorgeous"
  """
  @spec product_name_adjective() :: String.t()
  localize(:product_name_adjective)

  @doc """
  Returns a random product material

  ## Examples

      iex> Faker.Commerce.product_name_material()
      "Rubber"
      iex> Faker.Commerce.product_name_material()
      "Concrete"
      iex> Faker.Commerce.product_name_material()
      "Steel"
      iex> Faker.Commerce.product_name_material()
      "Granite"
  """
  @spec product_name_material() :: String.t()
  localize(:product_name_material)

  @doc """
  Returns a random product name

  ## Examples

      iex> Faker.Commerce.product_name_product()
      "Gloves"
      iex> Faker.Commerce.product_name_product()
      "Computer"
      iex> Faker.Commerce.product_name_product()
      "Table"
      iex> Faker.Commerce.product_name_product()
      "Shirt"
  """
  @spec product_name_product() :: String.t()
  localize(:product_name_product)
end
