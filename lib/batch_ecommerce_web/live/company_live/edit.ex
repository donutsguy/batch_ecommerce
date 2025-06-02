defmodule BatchEcommerceWeb.Live.CompanyLive.Edit do
  use BatchEcommerceWeb, :live_view
  alias BatchEcommerce.Accounts.Company
  alias BatchEcommerce.Accounts
  alias BatchEcommerceWeb.Live.CompanyLive.FormComponent
  alias BatchEcommerceWeb.Live.HeaderLive.HeaderDefault

  def mount(%{"id" => id}, _session, socket) do
    user = %{name: "ricardo", id: 1, image_url: ""}
    company = Accounts.get_company!(id)
    IO.inspect(Accounts.list_companies())
    {:ok, assign(socket, company: company, user: user)}
  end

    def render(assigns) do
    ~H"""
    <div class="pt-10 px-4">
      <div class="max-w-7xl mx-auto">
        <h1 class="text-4xl font-bold text-gray-100 mb-8 text-center pb-10">Criar Nova Empresa</h1>

        <.live_component
          module={FormComponent}
          id={@company.id}
          company={@company}
          action={@live_action}
          patch={~p"/companies"}
        />

        <.back navigate={~p"/companies"} class="mt-6 inline-block text-blue-600 hover:text-blue-800">
          ← Voltar para empresas
        </.back>
      </div>
    </div>
    """
  end
end
