defmodule BatchEcommerce.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :sales_quantity, :discount, :price, :stock_quantity, :image_url, :description, :company_id, :inserted_at, :updated_at]}

  @required_fields [:name, :price, :stock_quantity, :description, :company_id, :sales_quantity, :discount]
  @filename_regex ~r|^http://localhost:9000/batch-bucket/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}-.*\.jpg$|

  schema "products" do
    field :name, :string
    field :price, :decimal
    field :stock_quantity, :integer
    field :image_url, :string
    field :description, :string
    field :sales_quantity, :integer
    field :discount, :integer
    many_to_many :categories, BatchEcommerce.Catalog.Category, join_through: "products_categories", on_replace: :delete
    belongs_to :company, BatchEcommerce.Accounts.Company
    has_many :product_reviews, BatchEcommerce.Catalog.ProductReview

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:image_url | @required_fields])
    |> validate_required(@required_fields)
    |> validate_name()
    |> foreign_key_constraint(:company_id)
    |> validate_price()
    |> validate_stock_quantity()
    |> validate_description()
    |> put_products_categories(attrs)
  end

  defp put_products_categories(changeset, %{"categories" => category_ids}) when is_list(category_ids) do
      categories = Enum.map(category_ids, fn category_id -> BatchEcommerce.Catalog.get_category(category_id) end)
      put_assoc(changeset, :categories, categories)
  end

  defp put_products_categories(changeset, _), do: changeset

  defp validate_name(changeset),
    do:
      validate_length(changeset, :name,
        min: 2,
        max: 60,
        menssage: "Insira um nome de produto válido"
      )

  defp validate_discount(changeset),
    do:
      validate_length(changeset, :discount,
        min: 0,
        max: 100,
        menssage: "Insira um numero de desconto"
      )

  defp validate_description(changeset),
    do:
      validate_length(changeset, :description,
        min: 2,
        max: 200,
        menssage: "Insira uma descrição de produto válida"
      )

  defp validate_price(changeset),
    do: validate_number(changeset, :price, greater_than: 0)

  defp validate_stock_quantity(changeset),
    do: validate_number(changeset, :stock_quantity, greater_than: 0)

  def image_url_changeset(product, attrs) do
    product
    |> cast(attrs, [:image_url])
    |> validate_required([:image_url])
    |> validate_format(:image_url, @filename_regex,
      message: "Deve começar com o padrão correto e terminar com .jpg"
    )
  end
end
