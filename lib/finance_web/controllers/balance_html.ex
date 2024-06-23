defmodule FinanceWeb.BalanceHTML do
  use FinanceWeb, :html

  embed_templates "balance_html/*"

  @doc """
  Renders a balance form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def balance_form(assigns)
end
