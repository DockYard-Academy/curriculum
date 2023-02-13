defmodule Faker.Internet.StatusCode do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for generating HTTP status codes
  """

  @doc """
  Returns an information status code

  ## Examples

      iex> Faker.Internet.StatusCode.information()
      102
      iex> Faker.Internet.StatusCode.information()
      101
      iex> Faker.Internet.StatusCode.information()
      103
      iex> Faker.Internet.StatusCode.information()
      100
  """
  @spec information :: 100..103
  sampler(:information, [100, 101, 102, 103])

  @doc """
  Returns a success status code

  ## Examples

      iex> Faker.Internet.StatusCode.success()
      200
      iex> Faker.Internet.StatusCode.success()
      201
      iex> Faker.Internet.StatusCode.success()
      205
      iex> Faker.Internet.StatusCode.success()
      204
  """
  @spec success :: 200..208 | 226
  sampler(:success, [200, 201, 202, 203, 204, 205, 206, 207, 208, 226])

  @doc """
  Returns a redirect status code

  ## Examples

      iex> Faker.Internet.StatusCode.redirect()
      303
      iex> Faker.Internet.StatusCode.redirect()
      302
      iex> Faker.Internet.StatusCode.redirect()
      306
      iex> Faker.Internet.StatusCode.redirect()
      305
  """
  @spec redirect :: 300..308
  sampler(:redirect, [300, 301, 302, 303, 304, 305, 306, 307, 308])

  @doc """
  Returns a client error status code

  ## Examples

      iex> Faker.Internet.StatusCode.client_error()
      428
      iex> Faker.Internet.StatusCode.client_error()
      405
      iex> Faker.Internet.StatusCode.client_error()
      424
      iex> Faker.Internet.StatusCode.client_error()
      424
  """
  @spec client_error :: 400..418 | 421..426 | 428..429 | 431 | 451
  sampler(:client_error, [
    400,
    401,
    402,
    403,
    404,
    405,
    406,
    407,
    408,
    409,
    410,
    411,
    412,
    413,
    414,
    415,
    416,
    417,
    418,
    421,
    422,
    423,
    424,
    425,
    426,
    428,
    429,
    431,
    451
  ])

  @doc """
  Returns a server error status code

  ## Examples

      iex> Faker.Internet.StatusCode.server_error()
      503
      iex> Faker.Internet.StatusCode.server_error()
      506
      iex> Faker.Internet.StatusCode.server_error()
      506
      iex> Faker.Internet.StatusCode.server_error()
      506
  """
  @spec server_error :: 500..508 | 510..511
  sampler(:server_error, [500, 501, 502, 503, 504, 505, 506, 507, 508, 510, 511])
end
