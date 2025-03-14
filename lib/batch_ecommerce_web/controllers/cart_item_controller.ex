defmodule BatchEcommerceWeb.CartItemController do
  use BatchEcommerceWeb, :controller

  alias BatchEcommerce.ShoppingCart
  alias BatchEcommerce.ShoppingCart.{CartItem, Cart}

  action_fallback BatchEcommerceWeb.FallbackController

  def create(conn, %{"cart_item" => cart_item_params}) do
    with %Cart{} = cart <-
           ShoppingCart.get_cart_by_user_uuid(conn.private.guardian_default_resource.id),
         {:ok, %CartItem{} = cart_item} <- ShoppingCart.add_item_to_cart(cart, cart_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/cart_items/#{cart_item}")
      |> render(:show, cart_item: cart_item)
    else
      nil -> {:error, :not_found}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
    end
  end

  def update(conn, %{"id" => id, "cart_item" => cart_item_params}) do
    with %CartItem{} = cart_item <- ShoppingCart.get_cart_item(id),
         {:ok, %CartItem{} = cart_item} <-
           ShoppingCart.update_cart_item(cart_item, cart_item_params) do
      conn
      |> put_status(:ok)
      |> render(:show, cart_item: cart_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    with %CartItem{} = cart_item <- ShoppingCart.get_cart_item(id),
         {:ok, %CartItem{}} <- ShoppingCart.delete_cart_item(cart_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
