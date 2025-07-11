# defmodule BatchEcommerce.ShoppingCartFixtures do
#   import BatchEcommerce.CatalogFixtures
#   alias BatchEcommerce.ShoppingCart

#   @moduledoc """
#   This module defines test helpers for creating
#   entities via the `BatchEcommerce.ShoppingCart` context.
#   """

#   @doc """
#   Generate a unique cart user_uuid.
#   """
#   def unique_cart_user_uuid do
#     UUID.uuid4()
#   end

#   @doc """
#   Generate a cart.
#   """
#   # def cart_fixture(attrs \\ %{}) do
#   #   {:ok, cart} =
#   #     attrs
#   #     |> Enum.into(%{
#   #       user_uuid: unique_cart_user_uuid()
#   #     })

#   #   cart
#   # end

#   @doc """
#   Generate a cart_item.
#   """
#   # def cart_item_fixture(attrs, conn) when not is_nil(conn) do
#   #   cart_item_params =
#   #     attrs
#   #     |> Enum.into(%{
#   #       "product_id" => product_fixture().id,
#   #       "quantity" => "10"
#   #     })

#   #   cart_item
#   # end

#   def cart_item_fixture(attrs \\ %{}) do
#     cart_item_params =
#       attrs
#       |> Enum.into(%{
#         "product_id" => product_fixture().id,
#         "quantity" => "10"
#       })

#     cart_item
#   end
# end
