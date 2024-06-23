defmodule Finance.ExpensesTest do
  use Finance.DataCase

  alias Finance.Expenses

  describe "categories" do
    alias Finance.Expenses.Category

    import Finance.ExpensesFixtures

    @invalid_attrs %{name: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Expenses.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Expenses.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Category{} = category} = Expenses.create_category(valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Category{} = category} = Expenses.update_category(category, update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenses.update_category(category, @invalid_attrs)
      assert category == Expenses.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Expenses.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Expenses.change_category(category)
    end
  end

  describe "balances" do
    alias Finance.Expenses.Balance

    import Finance.ExpensesFixtures

    @invalid_attrs %{name: nil, balance: nil}

    test "list_balances/0 returns all balances" do
      balance = balance_fixture()
      assert Expenses.list_balances() == [balance]
    end

    test "get_balance!/1 returns the balance with given id" do
      balance = balance_fixture()
      assert Expenses.get_balance!(balance.id) == balance
    end

    test "create_balance/1 with valid data creates a balance" do
      valid_attrs = %{name: "some name", balance: 120.5}

      assert {:ok, %Balance{} = balance} = Expenses.create_balance(valid_attrs)
      assert balance.name == "some name"
      assert balance.balance == 120.5
    end

    test "create_balance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_balance(@invalid_attrs)
    end

    test "update_balance/2 with valid data updates the balance" do
      balance = balance_fixture()
      update_attrs = %{name: "some updated name", balance: 456.7}

      assert {:ok, %Balance{} = balance} = Expenses.update_balance(balance, update_attrs)
      assert balance.name == "some updated name"
      assert balance.balance == 456.7
    end

    test "update_balance/2 with invalid data returns error changeset" do
      balance = balance_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenses.update_balance(balance, @invalid_attrs)
      assert balance == Expenses.get_balance!(balance.id)
    end

    test "delete_balance/1 deletes the balance" do
      balance = balance_fixture()
      assert {:ok, %Balance{}} = Expenses.delete_balance(balance)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_balance!(balance.id) end
    end

    test "change_balance/1 returns a balance changeset" do
      balance = balance_fixture()
      assert %Ecto.Changeset{} = Expenses.change_balance(balance)
    end
  end

  describe "expenses" do
    alias Finance.Expenses.Expense

    import Finance.ExpensesFixtures

    @invalid_attrs %{date: nil, currency: nil, price: nil, account_id: nil, category_id: nil, notes: nil, receipt_image_url: nil}

    test "list_expenses/0 returns all expenses" do
      expense = expense_fixture()
      assert Expenses.list_expenses() == [expense]
    end

    test "get_expense!/1 returns the expense with given id" do
      expense = expense_fixture()
      assert Expenses.get_expense!(expense.id) == expense
    end

    test "create_expense/1 with valid data creates a expense" do
      valid_attrs = %{date: ~N[2024-06-18 07:24:00], currency: "some currency", price: 120.5, account_id: 42, category_id: 42, notes: "some notes", receipt_image_url: "some receipt_image_url"}

      assert {:ok, %Expense{} = expense} = Expenses.create_expense(valid_attrs)
      assert expense.date == ~N[2024-06-18 07:24:00]
      assert expense.currency == "some currency"
      assert expense.price == 120.5
      assert expense.account_id == 42
      assert expense.category_id == 42
      assert expense.notes == "some notes"
      assert expense.receipt_image_url == "some receipt_image_url"
    end

    test "create_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_expense(@invalid_attrs)
    end

    test "update_expense/2 with valid data updates the expense" do
      expense = expense_fixture()
      update_attrs = %{date: ~N[2024-06-19 07:24:00], currency: "some updated currency", price: 456.7, account_id: 43, category_id: 43, notes: "some updated notes", receipt_image_url: "some updated receipt_image_url"}

      assert {:ok, %Expense{} = expense} = Expenses.update_expense(expense, update_attrs)
      assert expense.date == ~N[2024-06-19 07:24:00]
      assert expense.currency == "some updated currency"
      assert expense.price == 456.7
      assert expense.account_id == 43
      assert expense.category_id == 43
      assert expense.notes == "some updated notes"
      assert expense.receipt_image_url == "some updated receipt_image_url"
    end

    test "update_expense/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenses.update_expense(expense, @invalid_attrs)
      assert expense == Expenses.get_expense!(expense.id)
    end

    test "delete_expense/1 deletes the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{}} = Expenses.delete_expense(expense)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_expense!(expense.id) end
    end

    test "change_expense/1 returns a expense changeset" do
      expense = expense_fixture()
      assert %Ecto.Changeset{} = Expenses.change_expense(expense)
    end
  end
end
