defmodule FinanceWeb.ExpenseController do
  use FinanceWeb, :controller

  alias Finance.Expenses
  alias Finance.Expenses.Expense

  def index(conn, _params) do
    expenses = Expenses.list_expenses()
    render(conn, :index, expenses: expenses)
  end

  def new(conn, _params) do
    changeset = Expenses.change_expense(%Expense{})
    categories = Expenses.list_categories()
    balances = Expenses.list_balances()
    render(conn, :new, changeset: changeset, categories: categories, balances: balances)
  end

  def create(conn, %{"expense" => expense_params}) do
    IO.inspect(expense_params)
    categories = Expenses.list_categories()
    balances = Expenses.list_balances()
    image_struct = Map.get(expense_params, "receipt_image_url", nil)
    IO.inspect(image_struct)

    expense_params =
      if image_struct do
        image_url = "https://s3.amazonaws.com/your-bucket-name/your-image.jpg"
        Map.put(expense_params, "receipt_image_url", image_url)
      else
        expense_params
      end

    case Expenses.create_expense(expense_params) do
      {:ok, expense} ->
        # update balances
        balance = Expenses.get_balance!(expense.balance_id)
        new_balance = balance.balance - expense.price

        case Expenses.update_balance(balance, %{balance: new_balance}) do
          {:ok, _balance} -> IO.puts("Balance updated successfully.")
          {:error, _changeset} -> IO.puts("Something went wrong.")
        end

        conn
        |> put_flash(:info, "Expense created successfully.")
        |> redirect(to: ~p"/expenses/#{expense}")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Something went wrong.")
        |> render(:new, changeset: changeset, categories: categories, balances: balances)
    end
  end

  def show(conn, %{"id" => id}) do
    expense = Expenses.get_expense!(id)
    render(conn, :show, expense: expense)
  end

  def edit(conn, %{"id" => id}) do
    expense = Expenses.get_expense!(id)
    changeset = Expenses.change_expense(expense)
    categories = Expenses.list_categories()
    balances = Expenses.list_balances()

    render(conn, :edit,
      expense: expense,
      changeset: changeset,
      categories: categories,
      balances: balances
    )
  end

  def update(conn, %{"id" => id, "expense" => expense_params}) do
    expense = Expenses.get_expense!(id)
    categories = Expenses.list_categories()
    balances = Expenses.list_balances()

    case Expenses.update_expense(expense, expense_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Expense updated successfully.")
        |> redirect(to: ~p"/expenses/#{expense}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit,
          expense: expense,
          changeset: changeset,
          categories: categories,
          balances: balances
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    expense = Expenses.get_expense!(id)
    {:ok, _expense} = Expenses.delete_expense(expense)

    conn
    |> put_flash(:info, "Expense deleted successfully.")
    |> redirect(to: ~p"/expenses")
  end
end
