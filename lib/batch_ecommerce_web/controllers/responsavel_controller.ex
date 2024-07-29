defmodule BatchEcommerceWeb.ResponsavelController do
  use BatchEcommerceWeb, :controller

  alias BatchEcommerce.Contas.Guardian
  alias BatchEcommerce.Contas
  alias BatchEcommerce.Contas.Responsavel

  action_fallback BatchEcommerceWeb.FallbackController

  def index(conn, _params) do
    responsaveis = Contas.list_responsaveis()
    render(conn, :index, responsaveis: responsaveis)
  end

  def create(conn, %{"responsavel" => responsavel_params}) do
    with {:ok, %Responsavel{} = responsavel} <- Contas.create_responsavel(responsavel_params) do
      {:ok, token, _claims} = Guardian.encode_and_sign(responsavel)

      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/responsaveis/#{responsavel}")
      |> render(:create, responsavel: responsavel, token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    responsavel = Contas.get_responsavel!(id)
    render(conn, :show, responsavel: responsavel)
  end

  def update(conn, %{"id" => id, "responsavel" => responsavel_params}) do
    responsavel = Contas.get_responsavel!(id)

    with {:ok, %Responsavel{} = responsavel} <-
           Contas.update_responsavel(responsavel, responsavel_params) do
      render(conn, :show, responsavel: responsavel)
    end
  end

  def delete(conn, %{"id" => id}) do
    responsavel = Contas.get_responsavel!(id)

    with {:ok, %Responsavel{}} <- Contas.delete_responsavel(responsavel) do
      send_resp(conn, :no_content, "")
    end
  end
end
