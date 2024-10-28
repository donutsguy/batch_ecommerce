defmodule BatchEcommerceWeb.CartJSON do
  alias BatchEcommerce.ShoppingCart.Cart

  @doc """
  Renders a list of carts.
  """
  def index(%{carts: carts}) do
    %{data: for(cart <- carts, do: data(cart))}
  end

  @doc """
  Renders a single cart.
  """
  def show(%{cart: cart}) do
    %{data: data(cart)}
  end

  defp data(%Cart{} = cart) do
    %{
      id: cart.id,
      user_uuid: cart.user_id,
      total: BatchEcommerce.ShoppingCart.total_cart_price(cart),
      cart_items: BatchEcommerceWeb.CartItemJSON.index(cart.items)
    }
  end
end
