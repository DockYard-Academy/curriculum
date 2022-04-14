defmodule Utils.Factory do
  def name do
    Faker.Person.name()
  end

  def string do
    Faker.String.base64()
  end
end
