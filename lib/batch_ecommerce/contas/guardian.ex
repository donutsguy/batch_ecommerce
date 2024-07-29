defmodule BatchEcommerce.Contas.Guardian do
  use Guardian, otp_app: :batch_ecommerce
  alias BatchEcommerce.Contas

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Contas.get_responsavel!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
