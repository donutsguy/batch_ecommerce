defmodule BatchEcommerceWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BatchEcommerceWeb, :controller
  require Logger

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: BatchEcommerceWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: BatchEcommerceWeb.ErrorHTML, json: BatchEcommerceWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(html: BatchEcommerceWeb.ErrorHTML, json: BatchEcommerceWeb.ErrorJSON)
    |> render(:"400")
  end

  def call(conn, {:error, error}) do
    Logger.error("unknown error detected: #{inspect(error)}")

    conn
    |> put_status(:internal_server_error)
    |> put_view(html: BatchEcommerceWeb.ErrorHTML, json: BatchEcommerceWeb.ErrorJSON)
    |> render(:"500")
  end
end
