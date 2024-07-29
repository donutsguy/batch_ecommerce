defmodule BatchEcommerceWeb.SessionController do
  use BatchEcommerceWeb, :controller
  action_fallback BatchEcommerceWeb.FallbackController
  alias BatchEcommerce.{Contas, Contas.Guardian}

  def login(conn, %{"email" => email, "senha" => senha}) do
    case Contas.authenticate_user(email, senha) do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)

        conn
        |> put_status(:ok)
        |> render(:user_token, user: user, token: token)

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})
    end
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> put_status(:ok)
    |> json(%{msg: "Logged out"})
  end
end
