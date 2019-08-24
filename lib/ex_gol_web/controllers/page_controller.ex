defmodule ExGolWeb.PageController do
  use ExGolWeb, :controller
  alias ExGol.Grid

  def index(conn, _params) do
    # get grid as a map
    grid = Grid.generate_grid()
    new_grid = Grid.step(grid)
    render(conn, "index.html", %{ grid: grid, new_grid: new_grid })
  end

  def generate_demo_map(), do: generate_demo_map(100, %{})

  def generate_demo_map(0, cells), do: cells
  def generate_demo_map(index, cells) do
    generate_demo_map(index - 1, Map.put(cells, "cell:#{index}:", Enum.random(0..1)))
  end
end
