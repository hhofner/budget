defmodule Finance.Expenses.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expenses" do
    field :date, :naive_datetime
    field :currency, :string
    field :price, :float
    belongs_to :balance, Finance.Expenses.Balance
    belongs_to :category, Finance.Expenses.Category
    field :notes, :string
    field :receipt_image_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [
      :price,
      :currency,
      :balance_id,
      :category_id,
      :date,
      :notes,
      :receipt_image_url
    ])
    |> validate_required([
      :price,
      :currency,
      :balance_id,
      :category_id,
      :date
    ])
  end
end
