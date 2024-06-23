defmodule Finance.Repo.Migrations.CreateBalances do
  use Ecto.Migration

  def change do
    create table(:balances) do
      add :name, :string
      add :balance, :float

      timestamps(type: :utc_datetime)
    end
  end
end
