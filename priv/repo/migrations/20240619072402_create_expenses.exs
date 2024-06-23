defmodule Finance.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :price, :float
      add :currency, :string
      add :balance_id, references(:balances)
      add :category_id, references(:categories)
      add :date, :naive_datetime
      add :notes, :string
      add :receipt_image_url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
