defmodule Faker.Vehicle do
  import Faker, only: [localize: 1]
  alias Faker.Util
  alias Faker.Vehicle.En

  @moduledoc """
  Functions for generating Vehicle related data
  """

  @doc """
  Returns a vehicle body style string

  ## Examples
      iex> Faker.Vehicle.body_style()
      "Minivan"
      iex> Faker.Vehicle.body_style()
      "Hatchback"
      iex> Faker.Vehicle.body_style()
      "Crew Cab Pickup"
      iex> Faker.Vehicle.body_style()
      "Regular Cab Pickup"
  """
  @spec body_style() :: String.t()
  localize(:body_style)

  @doc """
  Returns a vehicle drivetrain string

  ## Examples
      iex> Faker.Vehicle.drivetrain()
      "4x2/2-wheel drive"
      iex> Faker.Vehicle.drivetrain()
      "4x4/4-wheel drive"
      iex> Faker.Vehicle.drivetrain()
      "4x2/2-wheel drive"
      iex> Faker.Vehicle.drivetrain()
      "RWD"
  """
  @spec drivetrain() :: String.t()
  localize(:drivetrain)

  @doc """
  Returns a vehicle fuel type string

  ## Examples
      iex> Faker.Vehicle.fuel_type()
      "Ethanol"
      iex> Faker.Vehicle.fuel_type()
      "E-85/Gasoline"
      iex> Faker.Vehicle.fuel_type()
      "Compressed Natural Gas"
      iex> Faker.Vehicle.fuel_type()
      "Gasoline Hybrid"
  """
  @spec fuel_type() :: String.t()
  localize(:fuel_type)

  @doc """
  Returns a vehicle make string

  ## Examples

      iex> Faker.Vehicle.make()
      "Lincoln"
      iex> Faker.Vehicle.make()
      "Dodge"
      iex> Faker.Vehicle.make()
      "Chevy"
      iex> Faker.Vehicle.make()
      "Honda"
  """
  @spec make() :: String.t()
  localize(:make)

  @doc """
  Returns a vehicle make and model string

  ## Examples

      iex> Faker.Vehicle.make_and_model()
      "Lincoln MKZ"
      iex> Faker.Vehicle.make_and_model()
      "Chevy Malibu"
      iex> Faker.Vehicle.make_and_model()
      "Ford Focus"
      iex> Faker.Vehicle.make_and_model()
      "Ford Focus"
  """
  @spec make_and_model() :: String.t()
  localize(:make_and_model)

  @doc """
  Returns a vehicle model string

  ## Examples

      iex> Faker.Vehicle.model()
      "Encore"
      iex> Faker.Vehicle.model()
      "S5"
      iex> Faker.Vehicle.model()
      "Fiesta"
      iex> Faker.Vehicle.model()
      "X1"
  """
  @spec model() :: String.t()
  localize(:model)

  @doc """
  Returns a vehicle model string belonging to the given make

  ## Examples
      iex> Faker.Vehicle.model("Ford")
      "Focus"
      iex> Faker.Vehicle.model("BMW")
      "X5"
      iex> Faker.Vehicle.model("Audi")
      "A4"
      iex> Faker.Vehicle.model("Toyota")
      "Corolla"
  """
  @spec model(String.t()) :: String.t()
  def model(make) do
    En.model(make)
  end

  @doc """
  Returns a vehicle option string

  ## Examples
      iex> Faker.Vehicle.option()
      "Premium Sound"
      iex> Faker.Vehicle.option()
      "Power Steering"
      iex> Faker.Vehicle.option()
      "A/C: Front"
      iex> Faker.Vehicle.option()
      "Keyless Entry"
  """

  @spec option() :: String.t()
  localize(:option)

  @doc """
  Returns a vehicle option string

  ## Examples
      iex> Faker.Vehicle.option()
      "Premium Sound"
      iex> Faker.Vehicle.option()
      "Power Steering"
      iex> Faker.Vehicle.option()
      "A/C: Front"
      iex> Faker.Vehicle.option()
      "Keyless Entry"
  """
  @spec options() :: String.t()
  localize(:options)

  @doc """
  Returns a list of vehicle options()

  ## Examples
      iex> Faker.Vehicle.options
      ["Power Steering", "A/C: Front", "Keyless Entry", "AM/FM Stereo", "Power Steering", "Antilock Brakes", "8-Track Player", "Leather Interior"]
      iex> Faker.Vehicle.options
      ["MP3 (Multi Disc)", "A/C: Rear", "Fog Lights", "Power Windows", "Cruise Control", "Premium Sound", "A/C: Front"]
      iex> Faker.Vehicle.options
      ["Tinted Glass", "MP3 (Single Disc)", "CD (Multi Disc)"]
      iex> Faker.Vehicle.options
      ["Fog Lights", "Rear Window Wiper", "MP3 (Multi Disc)", "Navigation", "Airbag: Side", "Rear Window Defroster", "Premium Sound"]
  """
  @spec options(non_neg_integer()) :: list(String.t())
  def options(number) do
    En.options(number)
  end

  @doc """
  Returns a vehicle standard option string

  ## Examples
      iex> Faker.Vehicle.standard_spec()
      "Tire pressure monitoring system (TPMS)"
      iex> Faker.Vehicle.standard_spec()
      "20\\" x 9.0\\" front & 20\\" x 10.0\\" rear aluminum wheels"
      iex> Faker.Vehicle.standard_spec()
      "Deluxe insulation group"
      iex> Faker.Vehicle.standard_spec()
      "Torsion beam rear suspension w/stabilizer bar"
  """
  @spec standard_spec() :: String.t()
  localize(:standard_spec)

  @doc """
  Returns a list of vehicle standard specs

  ## Examples
      iex> Faker.Vehicle.standard_specs()
      ["20\\" x 9.0\\" front & 20\\" x 10.0\\" rear aluminum wheels", "Deluxe insulation group", "Torsion beam rear suspension w/stabilizer bar", "High performance suspension", "200mm front axle", "Traveler/mini trip computer", "P235/50R18 all-season tires", "Front door tinted glass"]
      iex> Faker.Vehicle.standard_specs()
      ["625-amp maintenance-free battery", "Body color sill extension", "Cargo compartment cover", "Dana 44/226mm rear axle", "Tachometer", "Leather-wrapped parking brake handle", "Side-impact door beams"]
      iex> Faker.Vehicle.standard_specs()
      ["Tilt steering column", "Luxury front & rear floor mats w/logo", "HomeLink universal transceiver"]
      iex> Faker.Vehicle.standard_specs()
      ["Multi-reflector halogen headlamps", "Multi-info display -inc: driving range, average MPG, current MPG, average speed, outside temp, elapsed time, maintenance & diagnostic messages", "Zone body construction -inc: front/rear crumple zones, hood deformation point", "60/40 split fold-down rear seat w/outboard adjustable headrests", "Trim-panel-mounted storage net", "Front side-impact airbags", "Front/rear spot-lamp illumination"]
  """
  @spec standard_specs() :: list(String.t())
  def standard_specs do
    En.standard_specs()
  end

  @doc """
  Returns a list of vehicle standard specs of the given length

  ## Examples
      iex> Faker.Vehicle.En.standard_specs(3)
      ["Tire pressure monitoring system (TPMS)", "20\\" x 9.0\\" front & 20\\" x 10.0\\" rear aluminum wheels", "Deluxe insulation group"]
      iex> Faker.Vehicle.En.standard_specs(3)
      ["Torsion beam rear suspension w/stabilizer bar", "High performance suspension", "200mm front axle"]
      iex> Faker.Vehicle.En.standard_specs(3)
      ["Traveler/mini trip computer", "P235/50R18 all-season tires", "Front door tinted glass"]
      iex> Faker.Vehicle.En.standard_specs(3)
      ["XM satellite radio receiver -inc: 90 day trial subscription", "625-amp maintenance-free battery", "Body color sill extension"]
  """
  @spec standard_specs(non_neg_integer()) :: list(String.t())
  def standard_specs(number) do
    En.standard_specs(number)
  end

  @doc """
  Returns a vehicle transmission string

  ## Examples
      iex> Faker.Vehicle.transmission()
      "CVT"
      iex> Faker.Vehicle.transmission()
      "Automatic"
      iex> Faker.Vehicle.transmission()
      "Manual"
      iex> Faker.Vehicle.transmission()
      "Automanual"
  """
  @spec transmission() :: String.t()
  localize(:transmission)

  @doc """
  Returns a vehicle identification number string

  ## Examples
      iex> Faker.Vehicle.vin()
      "1C68203VCV0360337"
      iex> Faker.Vehicle.vin()
      "5190V7FL8YX113016"
      iex> Faker.Vehicle.vin()
      "4RSE9035H9JA97940"
      iex> Faker.Vehicle.vin()
      "59E4A13G890C97377"
  """
  def vin do
    Util.format("%10x%y%x%5d",
      x: fn ->
        Util.pick([Util.upper_letter(), "#{Util.digit()}"], ["I", "O", "Q"])
      end,
      y: fn ->
        Util.pick([Util.upper_letter(), "0"], ["I", "O", "Q"])
      end,
      d: fn ->
        "#{Util.digit()}"
      end
    )
  end
end
