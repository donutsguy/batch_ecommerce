defmodule BatchEcommerce.ContasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BatchEcommerce.Contas` context.
  """

  @doc """
  Generate a responsavel.
  """
  def responsavel_fixture(attrs \\ %{}) do
    {:ok, responsavel} =
      attrs
      |> Enum.into(%{
        cpf: "some cpf",
        email: "some email",
        endereco_id: 42,
        nome: "some nome",
        senha: "some senha_hash",
        telefone: "some telefone",
        tipo_id: 42
      })
      |> BatchEcommerce.Contas.create_responsavel()

    responsavel
  end
end
