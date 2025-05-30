defmodule BatchEcommerceWeb.Live.CompanyLive.Edit do
  use BatchEcommerceWeb, :live_view
  alias BatchEcommerce.Accounts.Company
  alias BatchEcommerce.Accounts
  alias BatchEcommerceWeb.Live.CompanyLive.FormComponent

  def mount(%{"id" => id}, _session, socket) do
    company = Accounts.get_company!(id)
    IO.inspect(Accounts.list_companies())
    {:ok, assign(socket, company: company)}
  end

    def render(assigns) do
    ~H"""
    <div class="pt-20 px-4">
      <div class="max-w-2xl mx-auto">
        <h1 class="text-3xl font-bold text-gray-900 mb-8">Criar Nova Empresa</h1>
        
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