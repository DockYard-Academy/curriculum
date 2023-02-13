defmodule Faker.Vehicle.En do
  import Faker, only: [sampler: 2]
  alias Faker.Util

  @moduledoc """
  Functions for generating Vehicle related data in English
  """

  @makes [
    "BMW",
    "Audi",
    "Toyota",
    "Chevy",
    "Ford",
    "Dodge",
    "Lincoln",
    "Buick",
    "Honda",
    "Nissan",
    "Mercedes-Benz",
    "Aston Martin"
  ]

  @models %{
    "BMW" => ["328i", "M3", "M5", "X1", "X3", "X5"],
    "Audi" => ["A4", "A5", "S5", "A7", "A8"],
    "Toyota" => ["Prius", "Camry", "Corolla"],
    "Chevy" => ["Camero", "Silverado", "Malibu"],
    "Ford" => ["Mustang", "F150", "Focus", "Fiesta"],
    "Dodge" => ["Ram", "Challenger", "Charger", "Durango"],
    "Lincoln" => ["Navigator", "MKZ", "MKX", "MKS"],
    "Buick" => ["Enclave", "Regal", "LaCrosse", "Verano", "Encore", "Riveria"],
    "Honda" => ["Accord", "Civic", "CR-V", "Odyssey"],
    "Nissan" => ["Rogue", "Juke", "Cube", "Pathfinder", "Versa", "Altima"],
    "Mercedes-Benz" => ["AMG GLB 35", "B-Class Electric Drive", "G 550 4x4 Squared"],
    "Aston Martin" => ["DB AR1 Zagato", "DB7 Vantage", "V8 Vantage S"]
  }

  @options [
    "A/C: Front",
    "Airbag: Driver",
    "AM/FM Stereo",
    "A/C: Rear",
    "Airbag: Passenger",
    "Cassette Player",
    "8-Track Player",
    "Cruise Control",
    "Airbag: Side",
    "CD (Single Disc)",
    "Navigation",
    "Alarm",
    "CD (Multi Disc)",
    "Power Locks",
    "Antilock Brakes",
    "MP3 (Single Disc)",
    "Power Steering",
    "Fog Lights",
    "MP3 (Multi Disc)",
    "Keyless Entry",
    "Premium Sound",
    "Integrated Phone",
    "DVD System",
    "Bucket Seats",
    "Power Windows",
    "Alloy Wheels",
    "Leather Interior",
    "Rear Window Defroster",
    "Moonroof/Sunroof",
    "Memory Seats",
    "Rear Window Wiper",
    "Third Row Seats",
    "Power Seats",
    "Tinted Glass",
    "Tow Package"
  ]

  @standard_specs [
    "1.8L DOHC 16-valve I4 engine -inc: engine cover",
    "Engine mounts -inc: (2) solid, (1) liquid-filled",
    "Front wheel drive",
    "Battery saver",
    "Independent strut front suspension w/stabilizer bar",
    "Torsion beam rear suspension w/stabilizer bar",
    "Electric speed-sensitive variable-assist pwr steering",
    "Pwr front vented disc/rear drum brakes",
    "Compact spare tire",
    "Body color front/rear bumpers",
    "Multi-reflector halogen headlamps",
    "Body color folding remote-controlled pwr mirrors",
    "Variable intermittent windshield wipers w/mist function",
    "Intermittent rear wiper w/washer",
    "Body color door handles",
    "Roof mounted antenna",
    "Reclining front bucket seats -inc: active head restraints, double-thickness foam in front seats",
    "60/40 split fold-down rear seat w/outboard adjustable headrests",
    "Dual front & rear cup holders",
    "Tilt steering column",
    "Silver accent IP trim finisher -inc: silver shifter finisher",
    "Tachometer",
    "Fasten seat belt warning light/chime",
    "Pwr windows",
    "Remote fuel lid release",
    "Immobilizer system",
    "Pwr rear liftgate release",
    "Air conditioning w/in-cabin microfilter",
    "Rear window defroster w/timer",
    "12V pwr outlet",
    "Silver finish interior door handles",
    "Driver & front passenger map pockets",
    "Rear passenger map pockets",
    "Front & rear passenger folding assist grips",
    "Carpeted floor & cargo area",
    "Cargo area lamp",
    "Anti-lock brake system (ABS) -inc: electronic brake force distribution (EBD), brake assist",
    "Energy absorbing front/rear bumpers",
    "Steel side-door impact beams",
    "Zone body construction -inc: front/rear crumple zones, hood deformation point",
    "Dual-stage front airbags w/occupant classification system",
    "Front side-impact airbags",
    "Front & rear side curtain airbags",
    "3-point ELR driver seat belt w/pretensioner & load limiter",
    "3-point ELR/ALR front passenger seat belt w/pretensioner & load limiter",
    "3-point ELR/ALR rear seat belts at all positions",
    "Child safety rear door locks",
    "Rear child seat tether anchors (LATCH)",
    "Tire pressure monitoring system (TPMS)",
    "Energy absorbing steering column",
    "4.6L DOHC 32-valve V8 engine -inc: DI & SFI dual fuel injection, dual variable valve timing w/intelligence & electronically controlled intake (VVT-iE), aluminum block & heads",
    "Vibration-dampening liquid-filled engine mounts",
    "Electronic throttle control system w/intelligence (ETCS-i)",
    "Acoustic control induction system (ACIS)",
    "8-speed automatic transmission -inc: intelligence (ECT-i), gated shifter, sequential sport-shift mode",
    "Full-time all-wheel drive",
    "Front/rear aluminum multi-link double joint suspension w/coil springs",
    "Front/rear stabilizer bars",
    "Electric pwr rack & pinion steering (EPS)",
    "4-wheel ventilated pwr disc brakes -inc: brake override system",
    "Dual chrome exhaust tips",
    "Tool kit",
    "P235/50R18 all-season tires",
    "Full-size spare tire w/aluminum alloy wheel",
    "Scratch-resistant paint clearcoating",
    "Pwr tilt/slide moonroof -inc: 1-touch open/close",
    "1-piece chrome window surround",
    "Xenon high-intensity discharge (HID) headlamps -inc: adaptive front lighting system, delayed auto-off",
    "Integrated fog lamps",
    "LED lights -inc: brake lamps, tail lamps, license plate",
    "Electrochromic pwr folding heated mirrors w/memory -inc: puddle lamps, integrated turn signals, auto reverse tilt-down",
    "Acoustic glass windshield",
    "Water-repellent windshield & front door glass",
    "Laminated side window glass",
    "Rain-sensing wipers",
    "XM satellite radio receiver -inc: 90 day trial subscription",
    "Rear bench seat -inc: (3) adjustable headrests",
    "Center console",
    "Optitron electroluminescent instrumentation",
    "Multi-info display -inc: driving range, average MPG, current MPG, average speed, outside temp, elapsed time, maintenance & diagnostic messages",
    "Eco drive indicator",
    "Pwr windows -inc: 1-touch open/close",
    "HomeLink universal transceiver",
    "Dual-zone automatic climate control system -inc: smog sensor, auto recirculation, clear air filter, pollen filter",
    "Rear-window defogger w/auto-off timer",
    "(2) aux 12V pwr outlets -inc: (1) in center console, (1) w/cigarette lighter",
    "Grain-matched wood trim -inc: center console, dash, door panels",
    "Electrochromic rearview mirror",
    "Foldable front door storage pockets",
    "Dual front illuminated visor vanity mirrors",
    "Front/rear spot-lamp illumination",
    "4-wheel/4-channel anti-lock brake system (ABS)",
    "Electronic control braking (ECB)",
    "Electronic brakeforce distribution (EBD) w/brake assist (BA) -inc: Smart stop technology",
    "Electronic parking brake",
    "Vehicle dynamics integrated management (VDIM) system -inc: vehicle stability control (VSC), traction control (TRAC)",
    "Front/rear crumple zones",
    "Daytime running lights (DRL)",
    "Side-impact door beams",
    "Dual front 2-stage airbags -inc: passenger occupant classification system w/twin-chamber airbag",
    "Front/rear side curtain airbags",
    "Dual front knee airbags",
    "Back-up camera",
    "All-position 3-point seat belts -inc: outboard pretensioners & force limiters, dual front pwr shoulder height adjusters, rear outboard emergency auto locking retractors, driver emergency locking retractor",
    "Child restraint seat anchors for outboard positions",
    "Rear door child safety locks",
    "Direct-type tire pressure monitor system",
    "Impact-dissipating upper interior trim",
    "Collapsible steering column",
    "Emergency interior trunk release",
    "First aid kit",
    "6.1L SRT V8 \"Hemi\" engine",
    "3.73 axle ratio",
    "Quadra-Trac active on demand 4WD system",
    "200mm front axle",
    "Dana 44/226mm rear axle",
    "625-amp maintenance-free battery",
    "160-amp alternator",
    "Tip start system",
    "Pwr accessory delay",
    "Trailer tow wiring harness",
    "High performance suspension",
    "Pwr steering cooler",
    "Pwr rack & pinion performance tuned steering",
    "Anti-lock 4-wheel performance disc brakes",
    "Brake assist",
    "Dual bright exhaust tips",
    "Run flat tires",
    "20\" x 9.0\" front & 20\" x 10.0\" rear aluminum wheels",
    "Monotone paint",
    "Black roof molding",
    "Rear body-color spoiler",
    "Body color grille",
    "Chrome bodyside molding",
    "Black windshield molding",
    "Body color fascias w/bright insert",
    "Body color sill extension",
    "Fog lamps",
    "Front door tinted glass",
    "\"Flipper\" liftgate glass",
    "Rear window wiper/washer",
    "Body color front license plate brow",
    "Body color door handles",
    "6.5\" touch screen display",
    "Fixed long mast antenna",
    "Pwr 8-way driver seat w/4-way front passenger seat",
    "60/40 folding rear seat",
    "Full-length floor console",
    "Luxury front & rear floor mats w/logo",
    "Floor carpeting",
    "Tilt/telescoping steering column",
    "Leather-wrapped steering wheel w/audio controls",
    "Instrument cluster w/tachometer",
    "Vehicle info center",
    "Traveler/mini trip computer",
    "Pwr front windows w/(1) touch up/down feature",
    "Speed control",
    "Sentry Key theft deterrent system",
    "Security alarm",
    "Bright pedals",
    "Rear window defroster",
    "Locking glove box",
    "Highline door trim panel",
    "Cloth covered headliner",
    "Overhead console",
    "Dual illuminated visor vanity mirrors",
    "Universal garage door opener",
    "Passenger assist handles",
    "Deluxe insulation group",
    "Cargo compartment lamp",
    "Glove box lamp",
    "Rear reading & courtesy lamps",
    "Illuminated entry",
    "Leather-wrapped shift knob",
    "Leather-wrapped parking brake handle",
    "Carpeted cargo area",
    "Trim-panel-mounted storage net",
    "Cargo-area tie down loops",
    "Cargo compartment cover",
    "Reversible/waterproof cargo storage",
    "Driver & front passenger advanced multistage airbags w/occupant sensors",
    "Supplemental side curtain air bags",
    "Enhanced accident response system unlocks the doors, shuts off the fuel pump and turns on interior lights after airbag deploys",
    "3-point rear center seat belts",
    "Child seat upper tether anchorages",
    "LATCH-ready child seat anchor system",
    "Child safety rear door locks",
    "Dual note horn",
    "Tire pressure monitoring display"
  ]

  @spec all_models :: [String.t()]
  defp all_models do
    @models
    |> Map.values()
    |> Enum.concat()
  end

  @doc """
  Returns a vehicle body style string

  ## Examples
      iex> Faker.Vehicle.En.body_style()
      "Minivan"
      iex> Faker.Vehicle.En.body_style()
      "Hatchback"
      iex> Faker.Vehicle.En.body_style()
      "Crew Cab Pickup"
      iex> Faker.Vehicle.En.body_style()
      "Regular Cab Pickup"
  """
  @spec body_style() :: String.t()
  sampler(:body_style, [
    "Cargo Van",
    "Convertible",
    "Coupe",
    "Crew Cab Pickup",
    "Extended Cab Pickup",
    "Hatchback",
    "Minivan",
    "Passenger Van",
    "Regular Cab Pickup",
    "Sedan",
    "SUV",
    "Wagon"
  ])

  @doc """
  Returns a vehicle drivetrain string

  ## Examples
      iex> Faker.Vehicle.En.drivetrain()
      "4x2/2-wheel drive"
      iex> Faker.Vehicle.En.drivetrain()
      "4x4/4-wheel drive"
      iex> Faker.Vehicle.En.drivetrain()
      "4x2/2-wheel drive"
      iex> Faker.Vehicle.En.drivetrain()
      "RWD"
  """
  @spec drivetrain() :: String.t()
  sampler(:drivetrain, ["4x2/2-wheel drive", "4x4/4-wheel drive", "AWD", "FWD", "RWD"])

  @doc """
  Returns a vehicle fuel type string

  ## Examples
      iex> Faker.Vehicle.En.fuel_type()
      "Ethanol"
      iex> Faker.Vehicle.En.fuel_type()
      "E-85/Gasoline"
      iex> Faker.Vehicle.En.fuel_type()
      "Compressed Natural Gas"
      iex> Faker.Vehicle.En.fuel_type()
      "Gasoline Hybrid"
  """
  @spec fuel_type() :: String.t()
  sampler(:fuel_type, [
    "Compressed Natural Gas",
    "Diesel",
    "E-85/Gasoline",
    "Electric",
    "Gasoline",
    "Gasoline Hybrid",
    "Ethanol"
  ])

  @doc """
  Returns a vehicle make string

  ## Examples

      iex> Faker.Vehicle.En.make()
      "Lincoln"
      iex> Faker.Vehicle.En.make()
      "Dodge"
      iex> Faker.Vehicle.En.make()
      "Chevy"
      iex> Faker.Vehicle.En.make()
      "Honda"
  """
  @spec make() :: String.t()
  def make do
    Util.pick(@makes)
  end

  @doc """
  Returns a vehicle make and model string

  ## Examples

      iex> Faker.Vehicle.En.make_and_model()
      "Lincoln MKZ"
      iex> Faker.Vehicle.En.make_and_model()
      "Chevy Malibu"
      iex> Faker.Vehicle.En.make_and_model()
      "Ford Focus"
      iex> Faker.Vehicle.En.make_and_model()
      "Ford Focus"
  """
  @spec make_and_model() :: String.t()
  def make_and_model do
    make = make()
    "#{make} #{model(make)}"
  end

  @doc """
  Returns a vehicle model string

  ## Examples

      iex> Faker.Vehicle.En.model()
      "Encore"
      iex> Faker.Vehicle.En.model()
      "S5"
      iex> Faker.Vehicle.En.model()
      "Fiesta"
      iex> Faker.Vehicle.En.model()
      "X1"
  """
  @spec model() :: String.t()
  def model do
    Util.pick(all_models())
  end

  @doc """
  Returns a realistic vehicle model string
  for the given model.

  ## Examples

      iex> Faker.Vehicle.En.model("Ford")
      "Focus"
      iex> Faker.Vehicle.En.model("BMW")
      "X5"
      iex> Faker.Vehicle.En.model("Audi")
      "A4"
      iex> Faker.Vehicle.En.model("Toyota")
      "Corolla"
  """
  @spec model(String.t()) :: String.t()
  def model(make) when make in @makes, do: Util.pick(@models[make])

  def model(_make), do: model()

  @doc """
  Returns a vehicle option string

  ## Examples
      iex> Faker.Vehicle.En.option()
      "Premium Sound"
      iex> Faker.Vehicle.En.option()
      "Power Steering"
      iex> Faker.Vehicle.En.option()
      "A/C: Front"
      iex> Faker.Vehicle.En.option()
      "Keyless Entry"
  """
  @spec option() :: String.t()
  def option do
    Util.pick(@options)
  end

  @doc """
  Returns a list of vehicle options()

  ## Examples
      iex> Faker.Vehicle.En.options
      ["Power Steering", "A/C: Front", "Keyless Entry", "AM/FM Stereo", "Power Steering", "Antilock Brakes", "8-Track Player", "Leather Interior"]
      iex> Faker.Vehicle.En.options
      ["MP3 (Multi Disc)", "A/C: Rear", "Fog Lights", "Power Windows", "Cruise Control", "Premium Sound", "A/C: Front"]
      iex> Faker.Vehicle.En.options
      ["Tinted Glass", "MP3 (Single Disc)", "CD (Multi Disc)"]
      iex> Faker.Vehicle.En.options
      ["Fog Lights", "Rear Window Wiper", "MP3 (Multi Disc)", "Navigation", "Airbag: Side", "Rear Window Defroster", "Premium Sound"]
  """
  @spec options() :: list(String.t())
  def options do
    Util.list(Faker.random_between(2, 8), fn _ -> Util.pick(@options) end)
  end

  @doc """
  Returns a list of vehicle options of the given length

  ## Examples
      iex> Faker.Vehicle.En.options(3)
      ["Premium Sound", "Power Steering", "A/C: Front"]
      iex> Faker.Vehicle.En.options(3)
      ["Keyless Entry", "AM/FM Stereo", "Power Steering"]
      iex> Faker.Vehicle.En.options(3)
      ["Antilock Brakes", "8-Track Player", "Leather Interior"]
      iex> Faker.Vehicle.En.options(3)
      ["Cassette Player", "MP3 (Multi Disc)", "A/C: Rear"]
  """
  @spec options(non_neg_integer()) :: list(String.t())
  def options(number) do
    Util.list(number, fn _ -> Util.pick(@options) end)
  end

  @doc """
  Reterns a vehicle standard option string

  ## Examples
      iex> Faker.Vehicle.En.standard_spec()
      "Tire pressure monitoring system (TPMS)"
      iex> Faker.Vehicle.En.standard_spec()
      "20\\" x 9.0\\" front & 20\\" x 10.0\\" rear aluminum wheels"
      iex> Faker.Vehicle.En.standard_spec()
      "Deluxe insulation group"
      iex> Faker.Vehicle.En.standard_spec()
      "Torsion beam rear suspension w/stabilizer bar"
  """
  @spec standard_spec() :: String.t()
  def standard_spec do
    Util.pick(@standard_specs)
  end

  @doc """
  Returns a list of vehicle standard specs

  ## Examples
      iex> Faker.Vehicle.En.standard_specs()
      ["20\\" x 9.0\\" front & 20\\" x 10.0\\" rear aluminum wheels", "Deluxe insulation group", "Torsion beam rear suspension w/stabilizer bar", "High performance suspension", "200mm front axle", "Traveler/mini trip computer", "P235/50R18 all-season tires", "Front door tinted glass"]
      iex> Faker.Vehicle.En.standard_specs()
      ["625-amp maintenance-free battery", "Body color sill extension", "Cargo compartment cover", "Dana 44/226mm rear axle", "Tachometer", "Leather-wrapped parking brake handle", "Side-impact door beams"]
      iex> Faker.Vehicle.En.standard_specs()
      ["Tilt steering column", "Luxury front & rear floor mats w/logo", "HomeLink universal transceiver"]
      iex> Faker.Vehicle.En.standard_specs()
      ["Multi-reflector halogen headlamps", "Multi-info display -inc: driving range, average MPG, current MPG, average speed, outside temp, elapsed time, maintenance & diagnostic messages", "Zone body construction -inc: front/rear crumple zones, hood deformation point", "60/40 split fold-down rear seat w/outboard adjustable headrests", "Trim-panel-mounted storage net", "Front side-impact airbags", "Front/rear spot-lamp illumination"]
  """
  @spec standard_specs() :: list(String.t())
  def standard_specs do
    Util.list(Faker.random_between(2, 8), fn _ -> Util.pick(@standard_specs) end)
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
    Util.list(number, fn _ -> Util.pick(@standard_specs) end)
  end

  @doc """
  Returns a vehicle transmission string

  ## Examples
      iex> Faker.Vehicle.En.transmission()
      "CVT"
      iex> Faker.Vehicle.En.transmission()
      "Automatic"
      iex> Faker.Vehicle.En.transmission()
      "Manual"
      iex> Faker.Vehicle.En.transmission()
      "Automanual"
  """
  @spec transmission() :: String.t()
  sampler(:transmission, ["Automanual", "Automatic", "CVT", "Manual"])
end
