defmodule BatchEcommerceWeb.CartItemJSON do
  alias BatchEcommerce.ShoppingCart.CartItem
  alias BatchEcommerce.ShoppingCart

  def index(%{cart_items: cart_items}) do
    %{data: for(cart_item <- cart_items, do: data(cart_item))}
  end

  @doc """
  Renders a single cart_item.
  """
  def show(%{cart_item: cart_item}) do
    %{data: data(cart_item)}
  end

  defp data(%CartItem{} = cart_item) do
    %{
      id: cart_item.id,
      product_id: cart_item.product_id,
      price_when_carted: cart_item.price_when_carted,
      quantity: cart_item.quantity,
      product:
        BatchEcommerceWeb.ProductJSON.show(%{
          product: ShoppingCart.preload_product(cart_item).product
        })
    }
  end
end
