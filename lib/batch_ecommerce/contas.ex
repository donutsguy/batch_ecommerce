defmodule BatchEcommerce.Contas do
  @moduledoc """
  The Contas context.
  """

  import Ecto.Query, warn: false
  alias BatchEcommerce.Repo

  alias BatchEcommerce.Contas.Responsavel

  @doc """
  Returns the list of responsaveis.

  ## Examples

      iex> list_responsaveis()
      [%Responsavel{}, ...]

  """
  def list_responsaveis do
    Repo.all(Responsavel)
  end

  @doc """
  Gets a single responsavel.

  Raises `Ecto.NoResultsError` if the Responsavel does not exist.

  ## Examples

      iex> get_responsavel!(123)
      %Responsavel{}

      iex> get_responsavel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_responsavel!(id), do: Repo.get!(Responsavel, id)

  @doc """
  Creates a responsavel.

  ## Examples

      iex> create_responsavel(%{field: value})
      {:ok, %Responsavel{}}

      iex> create_responsavel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_responsavel(attrs \\ %{}) do
    %Responsavel{}
    |> Responsavel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a responsavel.

  ## Examples

      iex> update_responsavel(responsavel, %{field: new_value})
      {:ok, %Responsavel{}}

      iex> update_responsavel(responsavel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_responsavel(%Responsavel{} = responsavel, attrs) do
    responsavel
    |> Responsavel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a responsavel.

  ## Examples

      iex> delete_responsavel(responsavel)
      {:ok, %Responsavel{}}

      iex> delete_responsavel(responsavel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_responsavel(%Responsavel{} = responsavel) do
    Repo.delete(responsavel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking responsavel changes.

  ## Examples

      iex> change_responsavel(responsavel)
      %Ecto.Changeset{data: %Responsavel{}}

  """
  def change_responsavel(%Responsavel{} = responsavel, attrs \\ %{}) do
    Responsavel.changeset(responsavel, attrs)
  end

  def authenticate_user(email, plain_text_password) do
    query = from(u in Responsavel, where: u.email == ^email)

    case Repo.one(query) do
      nil ->
        {:error, :invalid_credentials}

      user ->
        if Bcrypt.verify_pass(plain_text_password, user.senha_hash) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
