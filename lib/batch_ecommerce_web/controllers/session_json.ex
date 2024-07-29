defmodule BatchEcommerceWeb.SessionJSON do
  alias BatchEcommerce.Contas.Responsavel

  @doc """
  Renders a user and token.
  """
  def user_token(%{user: user, token: token}) do
    %{data: data(user, token)}
  end

  defp data(%Responsavel{} = user, token) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end
end
