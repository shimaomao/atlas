defmodule Atlas.Database.Client do

  def query(string) do
    :gen_server.call :db_server, {:query, string}
  end

  def query_to_kwlist(query_string) do
    {:ok, count, columns, rows} = query(query_string)

    keyword_lists_from_query(columns, rows)
  end

  def keyword_lists_from_query(columns, rows) do
    Enum.map rows, Enum.zip(columns, &1)
  end

  def keyword_lists_to_records(kwlists, record) do
    Enum.map kwlists, fn row -> record.new(row) end
  end
end