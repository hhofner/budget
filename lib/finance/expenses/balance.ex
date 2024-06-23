defmodule Finance.Expenses.Balance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "balances" do
    field :name, :string
    field :balance, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(balance, attrs) do
    balance
    |> cast(attrs, [:name, :balance])
    |> validate_required([:name, :balance])
  end
end
