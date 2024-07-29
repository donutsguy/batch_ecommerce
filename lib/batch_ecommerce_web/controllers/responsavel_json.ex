defmodule BatchEcommerceWeb.ResponsavelJSON do
  alias BatchEcommerce.Contas.Responsavel

  @doc """
  Renders a list of responsaveis.
  """
  def index(%{responsaveis: responsaveis}) do
    %{data: for(responsavel <- responsaveis, do: data(responsavel))}
  end

  @doc """
  Renders a create responsavel.
  """
  def create(%{responsavel: responsavel, token: token}) do
    %{data: data(responsavel, token)}
  end

  @doc """
  Renders a single responsavel.
  """
  def show(%{responsavel: responsavel}) do
    %{data: data(responsavel)}
  end

  defp data(%Responsavel{} = responsavel) do
    %{
      id: responsavel.id,
      nome: responsavel.nome,
      cpf: responsavel.cpf,
      senha_hash: responsavel.senha_hash,
      email: responsavel.email,
      telefone: responsavel.telefone,
      endereco_id: responsavel.endereco_id,
      tipo_id: responsavel.tipo_id
    }
  end

  defp data(%Responsavel{} = responsavel, token) do
    %{
      id: responsavel.id,
      nome: responsavel.nome,
      cpf: responsavel.cpf,
      senha_hash: responsavel.senha_hash,
      email: responsavel.email,
      telefone: responsavel.telefone,
      endereco_id: responsavel.endereco_id,
      tipo_id: responsavel.tipo_id,
      token: token
    }
  end
end
