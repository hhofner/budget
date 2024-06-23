defmodule Finance.ExpensesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Finance.Expenses` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Finance.Expenses.create_category()

    category
  end

  @doc """
  Generate a balance.
  """
  def balance_fixture(attrs \\ %{}) do
    {:ok, balance} =
      attrs
      |> Enum.into(%{
        balance: 120.5,
        name: "some name"
      })
      |> Finance.Expenses.create_balance()

    balance
  end

  @doc """
  Generate a expense.
  """
  def expense_fixture(attrs \\ %{}) do
    {:ok, expense} =
      attrs
      |> Enum.into(%{
        account_id: 42,
        category_id: 42,
        currency: "some currency",
        date: ~N[2024-06-18 07:24:00],
        notes: "some notes",
        price: 120.5,
        receipt_image_url: "some receipt_image_url"
      })
      |> Finance.Expenses.create_expense()

    expense
  end
end
