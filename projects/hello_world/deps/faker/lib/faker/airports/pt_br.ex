defmodule Faker.Airports.PtBr do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for generating airports related data in Portuguese
  """

  @doc """
  Returns a random airport name

  ## Examples

      iex> Faker.Airports.PtBr.name()
      "Aeroporto de Alcântara (QAH/SNCW)"
      iex> Faker.Airports.PtBr.name()
      "Aeroporto Internacional Presidente Castro Pinto (JPA/SBJP)"
      iex> Faker.Airports.PtBr.name()
      "Aeroporto Internacional Pinto Martins (FOR/SBFZ)"
      iex> Faker.Airports.PtBr.name()
      "Aeroporto Internacional Salgado Filho (POA/SBPA)"
  """

  @spec name() :: String.t()
  sampler(:name, [
    "Aeroporto Auaris (SWBV)",
    "Aeroporto Brigadeiro Camarão (BVH/SBVH)",
    "Aeroporto Campo de Marte (MAE/SBMT)",
    "Aeroporto Carlos Prates (SBPR)",
    "Aeroporto César Bombonato (UDI/SBUL)",
    "Aeroporto da Pampulha (PLU/SBBH)",
    "Aeroporto de Alcântara (QAH/SNCW)",
    "Aeroporto de Altamira (ATM/SBHT)",
    "Aeroporto de Bacacheri (BFH/SBBI)",
    "Aeroporto de Bom Jesus da Lapa (LAZ/SBLZ)",
    "Aeroporto de Cacoal (OAL/SWKK)",
    "Aeroporto de Caldas Novas (CLV/SBCN)",
    "Aeroporto de Campos dos Goytacazes (CAW/SBCP)",
    "Aeroporto de Caracaraí (**/SBQI)",
    "Aeroporto de Carajás (CKS/SBCJ)",
    "Aeroporto de Congonhas/São Paulo (CGH/SBSP)",
    "Aeroporto de Costa Marques (SWCQ)",
    "Aeroporto de Forquilhinha (CCM/SBCM)",
    "Aeroporto de Guajará-Mirim (GJM/SBGM)",
    "Aeroporto de Imperatriz (IMP/SBIZ)",
    "Aeroporto de Jacarepaguá (***/SBJR)",
    "Aeroporto de Ji-Paraná (JPR/SWJI)",
    "Aeroporto de Londrina (LDB/SBLO)",
    "Aeroporto de Macaé (MEA/SBME)",
    "Aeroporto de Marabá (MAB/SBMA)",
    "Aeroporto de Montes Claros (MOC/SBMK)",
    "Aeroporto de Mucajaí (SWMV)",
    "Aeroporto de Pacaraima (SWMU)",
    "Aeroporto de Palmas (PMW/SBPJ)",
    "Aeroporto de Paulo Afonso (PAV/SBUF)",
    "Aeroporto de Petrolina (PNZ/SBPL)",
    "Aeroporto de Pimenta Bueno (SWPM)",
    "Aeroporto de Santarém/Maestro Wilson Fonseca (STM/SBSN)",
    "Aeroporto de São José dos Campos (SJK/SBSJ)",
    "Aeroporto de Tefé (TFF/SBTF)",
    "Aeroporto Embaixador Walther Moreira Salles (POO/SBPC)",
    "Aeroporto Eurico de Aguiar Salles (VIX/SBVT)",
    "Aeroporto Internacional Afonso Pena (CWB/SBCT)",
    "Aeroporto Internacional Augusto Severo (NAT/SBNT)",
    "Aeroporto Internacional Cataratas (IGU/SBFI)",
    "Aeroporto Internacional Comandante Gustavo Kraemer (BGX/SBBG)",
    "Aeroporto Internacional de Aracaju (AJU/SBAR)",
    "Aeroporto Internacional de Belém/Val de Cans (BEL/SBBE)",
    "Aeroporto Internacional de Boa Vista (BVB/SBBV)",
    "Aeroporto Internacional de Campo Grande (CGR/SBCG)",
    "Aeroporto Internacional de Corumbá (CMG/SBCR)",
    "Aeroporto Internacional de Cruzeiro do Sul (CZS/SBCZ)",
    "Aeroporto Internacional de Macapá (MCP/SBMQ)",
    "Aeroporto Internacional de Pelotas (PET/SBPK)",
    "Aeroporto Internacional de Ponta Porã (PMG/SBPP)",
    "Aeroporto Internacional de São Paulo-Guarulhos (GRU/SBGR)",
    "Aeroporto Internacional de Tabatinga (TBT/SBTT)",
    "Aeroporto Internacional de Viracopos-Campinas (VCP/SBKP)",
    "Aeroporto Internacional Dep. Luís Eduardo Magalhães (SSA/SBSV)",
    "Aeroporto Internacional do Rio de Janeiro",
    "Aeroporto Internacional dos Guararapes Gilberto Freyre (REC/SBRF)",
    "Aeroporto Internacional Eduardo Gomes (MAO/SBEG)",
    "Aeroporto Internacional Governador Jorge Teixeira (PVH/SBPV)",
    "Aeroporto Internacional Hercílio Luz (FLN/SBFL)",
    "Aeroporto Internacional Juscelino Kubitschek (BSB/SBBR)",
    "Aeroporto Internacional Marechal Cunha Machado (SLZ/SBSL)",
    "Aeroporto Internacional Marechal Rondon (CGB/SBCY)",
    "Aeroporto Internacional Ministro Victor Konder (NVT/SBNF)",
    "Aeroporto Internacional Pinto Martins (FOR/SBFZ)",
    "Aeroporto Internacional Prefeito Dr.João Silva Filho (PHB/SBPB)",
    "Aeroporto Internacional Presidente Castro Pinto (JPA/SBJP)",
    "Aeroporto Internacional Presidente Médici (RBR/SBRB)",
    "Aeroporto Internacional Rubem Berta (URG/SBUG)",
    "Aeroporto Internacional Salgado Filho (POA/SBPA)",
    "Aeroporto Internacional Tancredo Neves (CNF/SBCF)",
    "Aeroporto Internacional Zumbi dos Palmares (MCZ/SBMO)",
    "Aeroporto Jorge Amado (IOS/SBIL)",
    "Aeroporto Júlio Cesar (SBJC)",
    "Aeroporto Lauro Carneiro de Loyola (JOI/SBJV)",
    "Aeroporto Mário de Almeida Franco (UBA/SBUR)",
    "Aeroporto Nova Vida (SWNI)",
    "Aeroporto Presidente João Suassuna (CPV/SBKG)",
    "Aeroporto Regional do Cariri (JDO/SBJU)",
    "Aeroporto Santa Genoveva (GYN/SBGO)",
    "Aeroporto Santos Dumont (SDU/SBRJ)",
    "Aeroporto Senador Petrônio Portella (THE/SBTE)",
    "Aeroporto Surucucu (SWUQ)",
    "Aeroporto Tabajara (SWTB)",
    "Aeroporto Uaicas (SWAE)"
  ])
end
