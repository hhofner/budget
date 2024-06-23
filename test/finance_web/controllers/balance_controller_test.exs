defmodule FinanceWeb.BalanceControllerTest do
  use FinanceWeb.ConnCase

  import Finance.ExpensesFixtures

  @create_attrs %{name: "some name", balance: 120.5}
  @update_attrs %{name: "some updated name", balance: 456.7}
  @invalid_attrs %{name: nil, balance: nil}

  describe "index" do
    test "lists all balances", %{conn: conn} do
      conn = get(conn, ~p"/balances")
      assert html_response(conn, 200) =~ "Listing Balances"
    end
  end

  describe "new balance" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/balances/new")
      assert html_response(conn, 200) =~ "New Balance"
    end
  end

  describe "create balance" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/balances", balance: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/balances/#{id}"

      conn = get(conn, ~p"/balances/#{id}")
      assert html_response(conn, 200) =~ "Balance #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/balances", balance: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Balance"
    end
  end

  describe "edit balance" do
    setup [:create_balance]

    test "renders form for editing chosen balance", %{conn: conn, balance: balance} do
      conn = get(conn, ~p"/balances/#{balance}/edit")
      assert html_response(conn, 200) =~ "Edit Balance"
    end
  end

  describe "update balance" do
    setup [:create_balance]

    test "redirects when data is valid", %{conn: conn, balance: balance} do
      conn = put(conn, ~p"/balances/#{balance}", balance: @update_attrs)
      assert redirected_to(conn) == ~p"/balances/#{balance}"

      conn = get(conn, ~p"/balances/#{balance}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, balance: balance} do
      conn = put(conn, ~p"/balances/#{balance}", balance: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Balance"
    end
  end

  describe "delete balance" do
    setup [:create_balance]

    test "deletes chosen balance", %{conn: conn, balance: balance} do
      conn = delete(conn, ~p"/balances/#{balance}")
      assert redirected_to(conn) == ~p"/balances"

      assert_error_sent 404, fn ->
        get(conn, ~p"/balances/#{balance}")
      end
    end
  end

  defp create_balance(_) do
    balance = balance_fixture()
    %{balance: balance}
  end
end
