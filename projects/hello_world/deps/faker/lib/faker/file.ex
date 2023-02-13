defmodule Faker.File do
  alias Faker.Lorem

  @moduledoc """
  Functions for generating file related data
  """

  @extensions %{
    image: ~w(bmp gif jpeg jpg png tiff),
    audio: ~w(flac mp3 wav),
    text: ~w(css csv html js json txt),
    video: ~w(mp4 avi mov webm),
    office: ~w(doc docx xls xlsx ppt pptx odt ods odp pages numbers key pdf)
  }

  @mimes %{
    application:
      ~w(application/atom+xml application/ecmascript application/EDI-X12 application/EDIFACT application/json application/javascript application/ogg application/pdf application/postscript application/rdf+xml application/rss+xml application/soap+xml application/font-woff application/xhtml+xml application/xml-dtd application/xop+xml application/zip application/gzip),
    audio:
      ~w(audio/basic audio/L24 audio/mp4 audio/mpeg audio/ogg audio/vorbis audio/vnd.rn-realaudio audio/vnd.wave audio/webm),
    image:
      ~w(image/gif image/jpeg image/pjpeg image/png image/svg+xml image/tiff image/vnd.microsoft.icon),
    message: ~w(message/http message/imdn+xml message/partial message/rfc822),
    model:
      ~w(model/example model/iges model/mesh model/vrml model/x3d+binary model/x3d+vrml model/x3d+xml),
    multipart:
      ~w(multipart/mixed multipart/alternative multipart/related multipart/form-data multipart/signed multipart/encrypted),
    text: ~w(text/cmd text/css text/csv text/html text/javascript text/plain text/vcard text/xml),
    video:
      ~w(video/mpeg video/mp4 video/ogg video/quicktime video/webm video/x-matroska video/x-ms-wmv video/x-flv)
  }

  @categories_extensions Map.keys(@extensions)
  @categories_mimes Map.keys(@mimes)

  @doc """
  Returns a random file extension

  ## Examples

      iex> Faker.File.file_extension()
      "wav"
      iex> Faker.File.file_extension()
      "wav"
      iex> Faker.File.file_extension()
      "doc"
      iex> Faker.File.file_extension()
      "mov"
  """
  @spec file_extension() :: String.t()
  def file_extension do
    @categories_extensions
    |> pick
    |> file_extension
  end

  @doc """
  Returns a random file extension from the category given
  Available categories: :audio, :image, :text, :video, :office

  ## Examples

      iex> Faker.File.file_extension(:video)
      "mov"
      iex> Faker.File.file_extension(:image)
      "tiff"
      iex> Faker.File.file_extension(:audio)
      "flac"
      iex> Faker.File.file_extension(:office)
      "xls"
  """
  @spec file_extension(atom) :: String.t()
  def file_extension(category) do
    category
    |> get_extensions_from_category()
    |> pick()
  end

  @doc """
  Returns a random file name

  ## Examples

      iex> Faker.File.file_name()
      "aliquam.jpg"
      iex> Faker.File.file_name()
      "deleniti.doc"
      iex> Faker.File.file_name()
      "qui.jpg"
      iex> Faker.File.file_name()
      "quibusdam.csv"
  """
  @spec file_name() :: String.t()
  def file_name do
    Lorem.word() <> "." <> file_extension()
  end

  @doc """
  Returns a random file name from the category given
  Available categories: :audio, :image, :text, :video, :office

  ## Examples

      iex> Faker.File.file_name(:text)
      "aliquam.txt"
      iex> Faker.File.file_name(:video)
      "sint.mp4"
      iex> Faker.File.file_name(:image)
      "consequatur.bmp"
      iex> Faker.File.file_name(:audio)
      "qui.wav"
  """
  @spec file_name(atom) :: String.t()
  def file_name(category) do
    Lorem.word() <> "." <> file_extension(category)
  end

  @doc """
  Returns a random mime type

  ## Examples

      iex> Faker.File.mime_type()
      "text/css"
      iex> Faker.File.mime_type()
      "message/http"
      iex> Faker.File.mime_type()
      "application/ogg"
      iex> Faker.File.mime_type()
      "model/x3d+xml"
  """
  @spec mime_type :: String.t()
  def mime_type do
    @categories_mimes
    |> pick
    |> mime_type
  end

  @doc """
  Returns a random mime type from the category given
  Available categories: :application, :audio, :image, :message, :model,
  :multipart, :text, :video

  ## Examples

      iex> Faker.File.mime_type(:image)
      "image/vnd.microsoft.icon"
      iex> Faker.File.mime_type(:audio)
      "audio/mp4"
      iex> Faker.File.mime_type(:application)
      "application/xop+xml"
      iex> Faker.File.mime_type(:video)
      "video/mpeg"
  """
  @spec mime_type(atom) :: String.t()
  def mime_type(category) do
    category
    |> get_mimes_from_category()
    |> pick()
  end

  defp get_mimes_from_category(category) do
    @mimes[category]
  end

  defp get_extensions_from_category(category) do
    @extensions[category]
  end

  defp pick(list) do
    list
    |> Enum.at(Faker.random_between(0, Enum.count(list) - 1))
  end
end
