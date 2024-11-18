defmodule BatchEcommerceWeb.UploadController do
  use BatchEcommerceWeb, :controller
  action_fallback BatchEcommerceWeb.FallbackController

  alias BatchEcommerce.Catalog
  alias BatchEcommerce.Catalog.Minio

  # implementar erro de unprocessable_entity que é retornável de upload_file no futuro
  def create(conn, %{"image" => %Plug.Upload{} = image, "product_id" => product_id}) do
    with {:ok, image_url} <- Minio.upload_file(image),
         {:ok, _product} <- Catalog.put_image_url(product_id, image_url) do
      conn
      |> put_status(:ok)
      |> json(%{image_url: image_url})
    else
      {:error, :not_found} -> {:error, :not_found}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _unknown_error -> {:error, :internal_server_error}
    end
  end
end
