defmodule FinanceWeb.ExpenseControllerTest do
  use FinanceWeb.ConnCase

  import Finance.ExpensesFixtures

  @create_attrs %{date: ~N[2024-06-18 07:24:00], currency: "some currency", price: 120.5, account_id: 42, category_id: 42, notes: "some notes", receipt_image_url: "some receipt_image_url"}
  @update_attrs %{date: ~N[2024-06-19 07:24:00], currency: "some updated currency", price: 456.7, account_id: 43, category_id: 43, notes: "some updated notes", receipt_image_url: "some updated receipt_image_url"}
  @invalid_attrs %{date: nil, currency: nil, price: nil, account_id: nil, category_id: nil, notes: nil, receipt_image_url: nil}

  describe "index" do
    test "lists all expenses", %{conn: conn} do
      conn = get(conn, ~p"/expenses")
      assert html_response(conn, 200) =~ "Listing Expenses"
    end
  end

  describe "new expense" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/expenses/new")
      assert html_response(conn, 200) =~ "New Expense"
    end
  end

  describe "create expense" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/expenses", expense: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/expenses/#{id}"

      conn = get(conn, ~p"/expenses/#{id}")
      assert html_response(conn, 200) =~ "Expense #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/expenses", expense: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Expense"
    end
  end

  describe "edit expense" do
    setup [:create_expense]

    test "renders form for editing chosen expense", %{conn: conn, expense: expense} do
      conn = get(conn, ~p"/expenses/#{expense}/edit")
      assert html_response(conn, 200) =~ "Edit Expense"
    end
  end

  describe "update expense" do
    setup [:create_expense]

    test "redirects when data is valid", %{conn: conn, expense: expense} do
      conn = put(conn, ~p"/expenses/#{expense}", expense: @update_attrs)
      assert redirected_to(conn) == ~p"/expenses/#{expense}"

      conn = get(conn, ~p"/expenses/#{expense}")
      assert html_response(conn, 200) =~ "some updated currency"
    end

    test "renders errors when data is invalid", %{conn: conn, expense: expense} do
      conn = put(conn, ~p"/expenses/#{expense}", expense: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Expense"
    end
  end

  describe "delete expense" do
    setup [:create_expense]

    test "deletes chosen expense", %{conn: conn, expense: expense} do
      conn = delete(conn, ~p"/expenses/#{expense}")
      assert redirected_to(conn) == ~p"/expenses"

      assert_error_sent 404, fn ->
        get(conn, ~p"/expenses/#{expense}")
      end
    end
  end

  defp create_expense(_) do
    expense = expense_fixture()
    %{expense: expense}
  end
end
