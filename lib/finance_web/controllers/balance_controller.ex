defmodule FinanceWeb.BalanceController do
  use FinanceWeb, :controller

  alias Finance.Expenses
  alias Finance.Expenses.Balance

  def index(conn, _params) do
    balances = Expenses.list_balances()
    render(conn, :index, balances: balances)
  end

  def new(conn, _params) do
    changeset = Expenses.change_balance(%Balance{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"balance" => balance_params}) do
    case Expenses.create_balance(balance_params) do
      {:ok, balance} ->
        conn
        |> put_flash(:info, "Balance created successfully.")
        |> redirect(to: ~p"/balances/#{balance}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    balance = Expenses.get_balance!(id)
    render(conn, :show, balance: balance)
  end

  def edit(conn, %{"id" => id}) do
    balance = Expenses.get_balance!(id)
    changeset = Expenses.change_balance(balance)
    render(conn, :edit, balance: balance, changeset: changeset)
  end

  def update(conn, %{"id" => id, "balance" => balance_params}) do
    balance = Expenses.get_balance!(id)

    case Expenses.update_balance(balance, balance_params) do
      {:ok, balance} ->
        conn
        |> put_flash(:info, "Balance updated successfully.")
        |> redirect(to: ~p"/balances/#{balance}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, balance: balance, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    balance = Expenses.get_balance!(id)
    {:ok, _balance} = Expenses.delete_balance(balance)

    conn
    |> put_flash(:info, "Balance deleted successfully.")
    |> redirect(to: ~p"/balances")
  end
end
