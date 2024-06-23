defmodule FinanceWeb.PageController do
  use FinanceWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: ~p"/expenses/new")
  end
end
