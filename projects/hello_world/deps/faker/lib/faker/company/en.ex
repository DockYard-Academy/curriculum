defmodule Faker.Company.En do
  import Faker, only: [sampler: 2]

  alias Faker.Person.En, as: Person

  @moduledoc """
  Functions for company data in English
  """

  @doc """
  Returns a random complete English business related bullshit

  ## Examples

      iex> Faker.Company.En.bs()
      "syndicate e-business e-business"
      iex> Faker.Company.En.bs()
      "scale global metrics"
      iex> Faker.Company.En.bs()
      "optimize scalable markets"
      iex> Faker.Company.En.bs()
      "implement out-of-the-box content"
  """
  @spec bs() :: String.t()
  def bs, do: "#{bullshit_prefix()} #{bullshit()} #{bullshit_suffix()}"

  @doc """
  Returns a random English business related bullshit

  ## Examples

      iex> Faker.Company.En.bullshit()
      "web-enabled"
      iex> Faker.Company.En.bullshit()
      "e-business"
      iex> Faker.Company.En.bullshit()
      "web-enabled"
      iex> Faker.Company.En.bullshit()
      "next-generation"
  """
  @spec bullshit() :: String.t()
  sampler(:bullshit, [
    "clicks-and-mortar",
    "value-added",
    "vertical",
    "proactive",
    "robust",
    "revolutionary",
    "scalable",
    "leading-edge",
    "innovative",
    "intuitive",
    "strategic",
    "e-business",
    "mission-critical",
    "sticky",
    "one-to-one",
    "24/7",
    "end-to-end",
    "global",
    "B2B",
    "B2C",
    "granular",
    "frictionless",
    "virtual",
    "viral",
    "dynamic",
    "24/365",
    "best-of-breed",
    "killer",
    "magnetic",
    "bleeding-edge",
    "web-enabled",
    "interactive",
    "dot-com",
    "sexy",
    "back-end",
    "real-time",
    "efficient",
    "front-end",
    "distributed",
    "seamless",
    "extensible",
    "turn-key",
    "world-class",
    "open-source",
    "cross-platform",
    "cross-media",
    "synergistic",
    "bricks-and-clicks",
    "out-of-the-box",
    "enterprise",
    "integrated",
    "impactful",
    "wireless",
    "transparent",
    "next-generation",
    "cutting-edge",
    "user-centric",
    "visionary",
    "customized",
    "ubiquitous",
    "plug-and-play",
    "collaborative",
    "compelling",
    "holistic",
    "rich"
  ])

  @doc """
  Returns a random English business related bullshit prefix

  ## Examples

      iex> Faker.Company.En.bullshit_prefix()
      "syndicate"
      iex> Faker.Company.En.bullshit_prefix()
      "visualize"
      iex> Faker.Company.En.bullshit_prefix()
      "incentivize"
      iex> Faker.Company.En.bullshit_prefix()
      "scale"
  """
  @spec bullshit_prefix() :: String.t()
  sampler(:bullshit_prefix, [
    "implement",
    "utilize",
    "integrate",
    "streamline",
    "optimize",
    "evolve",
    "transform",
    "embrace",
    "enable",
    "orchestrate",
    "leverage",
    "reinvent",
    "aggregate",
    "architect",
    "enhance",
    "incentivize",
    "morph",
    "empower",
    "envisioneer",
    "monetize",
    "harness",
    "facilitate",
    "seize",
    "disintermediate",
    "synergize",
    "strategize",
    "deploy",
    "brand",
    "grow",
    "target",
    "syndicate",
    "synthesize",
    "deliver",
    "mesh",
    "incubate",
    "engage",
    "maximize",
    "benchmark",
    "expedite",
    "reintermediate",
    "whiteboard",
    "visualize",
    "repurpose",
    "innovate",
    "scale",
    "unleash",
    "drive",
    "extend",
    "engineer",
    "revolutionize",
    "generate",
    "exploit",
    "transition",
    "e-enable",
    "iterate",
    "cultivate",
    "matrix",
    "productize",
    "redefine",
    "recontextualize"
  ])

  @doc """
  Returns a random English business related bullshit suffix

  ## Examples

      iex> Faker.Company.En.bullshit_suffix()
      "e-services"
      iex> Faker.Company.En.bullshit_suffix()
      "niches"
      iex> Faker.Company.En.bullshit_suffix()
      "e-business"
      iex> Faker.Company.En.bullshit_suffix()
      "systems"
  """
  @spec bullshit_suffix() :: String.t()
  sampler(:bullshit_suffix, [
    "synergies",
    "web-readiness",
    "paradigms",
    "markets",
    "partnerships",
    "infrastructures",
    "platforms",
    "initiatives",
    "channels",
    "eyeballs",
    "communities",
    "ROI",
    "solutions",
    "e-tailers",
    "e-services",
    "action-items",
    "portals",
    "niches",
    "technologies",
    "content",
    "vortals",
    "supply-chains",
    "convergence",
    "relationships",
    "architectures",
    "interfaces",
    "e-markets",
    "e-commerce",
    "systems",
    "bandwidth",
    "infomediaries",
    "models",
    "mindshare",
    "deliverables",
    "users",
    "schemas",
    "networks",
    "applications",
    "metrics",
    "e-business",
    "functionalities",
    "experiences",
    "web services",
    "methodologies"
  ])

  @doc """
  Returns a random English business related buzzword

  ## Examples

      iex> Faker.Company.En.buzzword()
      "upward-trending"
      iex> Faker.Company.En.buzzword()
      "full-range"
      iex> Faker.Company.En.buzzword()
      "uniform"
      iex> Faker.Company.En.buzzword()
      "tertiary"
  """
  @spec buzzword() :: String.t()
  sampler(:buzzword, [
    "24 hour",
    "24/7",
    "3rd generation",
    "4th generation",
    "5th generation",
    "6th generation",
    "actuating",
    "analyzing",
    "assymetric",
    "asynchronous",
    "attitude-oriented",
    "background",
    "bandwidth-monitored",
    "bi-directional",
    "bifurcated",
    "bottom-line",
    "clear-thinking",
    "client-driven",
    "client-server",
    "coherent",
    "cohesive",
    "composite",
    "context-sensitive",
    "contextually-based",
    "content-based",
    "dedicated",
    "demand-driven",
    "didactic",
    "directional",
    "discrete",
    "disintermediate",
    "dynamic",
    "eco-centric",
    "empowering",
    "encompassing",
    "even-keeled",
    "executive",
    "explicit",
    "exuding",
    "fault-tolerant",
    "foreground",
    "fresh-thinking",
    "full-range",
    "global",
    "grid-enabled",
    "heuristic",
    "high-level",
    "holistic",
    "homogeneous",
    "human-resource",
    "hybrid",
    "impactful",
    "incremental",
    "intangible",
    "interactive",
    "intermediate",
    "leading edge",
    "local",
    "logistical",
    "maximized",
    "methodical",
    "mission-critical",
    "mobile",
    "modular",
    "motivating",
    "multimedia",
    "multi-state",
    "multi-tasking",
    "national",
    "needs-based",
    "neutral",
    "next generation",
    "non-volatile",
    "object-oriented",
    "optimal",
    "optimizing",
    "radical",
    "real-time",
    "reciprocal",
    "regional",
    "responsive",
    "scalable",
    "secondary",
    "solution-oriented",
    "stable",
    "static",
    "systematic",
    "systemic",
    "system-worthy",
    "tangible",
    "tertiary",
    "transitional",
    "uniform",
    "upward-trending",
    "user-facing",
    "value-added",
    "web-enabled",
    "well-modulated",
    "zero administration",
    "zero defect",
    "zero tolerance"
  ])

  @doc """
  Returns a random English business related buzzword prefix

  ## Examples

      iex> Faker.Company.En.buzzword_prefix()
      "Configurable"
      iex> Faker.Company.En.buzzword_prefix()
      "Advanced"
      iex> Faker.Company.En.buzzword_prefix()
      "Grass-roots"
      iex> Faker.Company.En.buzzword_prefix()
      "Automated"
  """
  @spec buzzword_prefix() :: String.t()
  sampler(:buzzword_prefix, [
    "Adaptive",
    "Advanced",
    "Ameliorated",
    "Assimilated",
    "Automated",
    "Balanced",
    "Business-focused",
    "Centralized",
    "Cloned",
    "Compatible",
    "Configurable",
    "Cross-group",
    "Cross-platform",
    "Customer-focused",
    "Customizable",
    "Decentralized",
    "De-engineered",
    "Devolved",
    "Digitized",
    "Distributed",
    "Diverse",
    "Down-sized",
    "Enhanced",
    "Enterprise-wide",
    "Ergonomic",
    "Exclusive",
    "Expanded",
    "Extended",
    "Face to face",
    "Focused",
    "Front-line",
    "Fully-configurable",
    "Function-based",
    "Fundamental",
    "Future-proofed",
    "Grass-roots",
    "Horizontal",
    "Implemented",
    "Innovative",
    "Integrated",
    "Intuitive",
    "Inverse",
    "Managed",
    "Mandatory",
    "Monitored",
    "Multi-channelled",
    "Multi-lateral",
    "Multi-layered",
    "Multi-tiered",
    "Networked",
    "Object-based",
    "Open-architected",
    "Open-source",
    "Operative",
    "Optimized",
    "Optional",
    "Organic",
    "Organized",
    "Persevering",
    "Persistent",
    "Phased",
    "Polarised",
    "Pre-emptive",
    "Proactive",
    "Profit-focused",
    "Profound",
    "Programmable",
    "Progressive",
    "Public-key",
    "Quality-focused",
    "Reactive",
    "Realigned",
    "Re-contextualized",
    "Re-engineered",
    "Reduced",
    "Reverse-engineered",
    "Right-sized",
    "Robust",
    "Seamless",
    "Secured",
    "Self-enabling",
    "Sharable",
    "Stand-alone",
    "Streamlined",
    "Switchable",
    "Synchronised",
    "Synergistic",
    "Synergized",
    "Team-oriented",
    "Total",
    "Triple-buffered",
    "Universal",
    "Up-sized",
    "Upgradable",
    "User-centric",
    "User-friendly",
    "Versatile",
    "Virtual",
    "Visionary",
    "Vision-oriented"
  ])

  @doc """
  Returns a random English business related buzzword suffix

  ## Examples

      iex> Faker.Company.En.buzzword_suffix()
      "encoding"
      iex> Faker.Company.En.buzzword_suffix()
      "standardization"
      iex> Faker.Company.En.buzzword_suffix()
      "Graphical User Interface"
      iex> Faker.Company.En.buzzword_suffix()
      "product"
  """
  @spec buzzword_suffix() :: String.t()
  sampler(:buzzword_suffix, [
    "ability",
    "access",
    "adapter",
    "algorithm",
    "alliance",
    "analyzer",
    "application",
    "approach",
    "architecture",
    "archive",
    "artificial intelligence",
    "array",
    "attitude",
    "benchmark",
    "budgetary management",
    "capability",
    "capacity",
    "challenge",
    "circuit",
    "collaboration",
    "complexity",
    "concept",
    "conglomeration",
    "contingency",
    "core",
    "customer loyalty",
    "database",
    "data-warehouse",
    "definition",
    "emulation",
    "encoding",
    "encryption",
    "extranet",
    "firmware",
    "flexibility",
    "focus group",
    "forecast",
    "frame",
    "framework",
    "function",
    "functionalities",
    "Graphic Interface",
    "groupware",
    "Graphical User Interface",
    "hardware",
    "help-desk",
    "hierarchy",
    "hub",
    "implementation",
    "info-mediaries",
    "infrastructure",
    "initiative",
    "installation",
    "instruction set",
    "interface",
    "internet solution",
    "intranet",
    "knowledge user",
    "knowledge base",
    "local area network",
    "leverage",
    "matrices",
    "matrix",
    "methodology",
    "middleware",
    "migration",
    "model",
    "moderator",
    "monitoring",
    "moratorium",
    "neural-net",
    "open architecture",
    "open system",
    "orchestration",
    "paradigm",
    "parallelism",
    "policy",
    "portal",
    "pricing structure",
    "process improvement",
    "product",
    "productivity",
    "project",
    "projection",
    "protocol",
    "secured line",
    "service-desk",
    "software",
    "solution",
    "standardization",
    "strategy",
    "structure",
    "success",
    "superstructure",
    "support",
    "synergy",
    "system engine",
    "task-force",
    "throughput",
    "time-frame",
    "toolset",
    "utilisation",
    "website",
    "workforce"
  ])

  @doc """
  Returns a random complete English catch phrase

  ## Examples

      iex> Faker.Company.En.catch_phrase()
      "Configurable full-range Graphical User Interface"
      iex> Faker.Company.En.catch_phrase()
      "Automated mission-critical pricing structure"
      iex> Faker.Company.En.catch_phrase()
      "Profit-focused bottom-line algorithm"
      iex> Faker.Company.En.catch_phrase()
      "Self-enabling systematic initiative"
  """
  @spec catch_phrase() :: String.t()
  def catch_phrase, do: "#{buzzword_prefix()} #{buzzword()} #{buzzword_suffix()}"

  @doc """
  Returns complete English company name

  ## Examples

      iex> Faker.Company.En.name()
      "Hayes Inc"
      iex> Faker.Company.En.name()
      "Sipes, Wehner and Hane"
      iex> Faker.Company.En.name()
      "Schiller, Rogahn and Hartmann"
      iex> Faker.Company.En.name()
      "Murphy-Metz"
  """
  @spec name() :: String.t()
  def name, do: name(Faker.random_between(0, 2))
  defp name(0), do: "#{Person.last_name()} #{suffix()}"
  defp name(1), do: "#{Person.last_name()}-#{Person.last_name()}"

  defp name(2) do
    "#{Person.last_name()}, #{Person.last_name()} and #{Person.last_name()}"
  end

  @doc """
  Returns a random type of business entity

  ## Examples

      iex> Faker.Company.En.suffix()
      "Inc"
      iex> Faker.Company.En.suffix()
      "and Sons"
      iex> Faker.Company.En.suffix()
      "Inc"
      iex> Faker.Company.En.suffix()
      "Ltd"
  """
  @spec suffix() :: String.t()
  sampler(:suffix, [
    "Inc",
    "and Sons",
    "LLC",
    "Group",
    "Ltd"
  ])
end
