defmodule ExGol.Grid do
  ##  use GenServer
  ##
  alias ExGol.Cell

  @grid_size 10
  ##
  ##  def start_link do
  ##
  ##  end
  ##
  ##  # Callbacks
  ##
  ##  def init() do
  ##    # assemble the grid
  ##    grid = generate_grid()
  ##
  ##    # setup the stepper
  ##    {:ok, %{}}
  ##  end
  ##
  ##  def handle_cast({:add_cell, index}, state) do
  ##    {:ok, cell_pid} = Cell.start_link(index)
  ##
  ##    state = Cell.get_state(cell_pid)
  ##
  ##    {:noreply, Map.put(state, "cell:#{cell_pid}", state)}
  ##  end
  ##
  ##  def handle_cast({:step, cell_id}, %{cells: cells}) do
  ##  end
  ##
  ##  # private functions
  ##
  ##  def generate_grid() do
  ##    number_of_cells = @grid_size * @grid_size
  ##    add_cells(number_of_cells)
  ##  end
  ##
  ##  def add_cells(0), do: :ok
  ##  def add_cells(i) do
  ##    GenServer.cast(__MODULE__, {:add_cell, i})
  ##    add_cells(i - 1)
  ##  end
  ##
  ##  def check_cells([], cells_map), do: :ok
  ##  def check_cells([cell | tail], cells_map) do
  ##    index = get_cell_index(cell)
  ##
  ##    surrounding_cells = get_surrounding_cells(index, cells_map)
  ##
  ##    check_cells(tail, cells_map)
  ##  end
  ##
  ##  def get_cell_index(<<"cell:", index>>), do: index
  ##
  ##  def get_surrounding_cells(index, cells_map) do
  ##    first_cell_index = index - (@grid_size + 1)
  ##
  ##    left_cell_index = 
  ##      case {:left, rem(@grid_size / index)} do
  ##        {:left, 1} -> :far_left_cell
  ##        {:left, _} -> index - 1
  ##      end
  ##
  ##    right_cell_index = 
  ##      case {:right, rem(@grid_size / index)} do
  ##        {:right, 0} -> :far_right_cell
  ##        {:right, _} -> index + 1
  ##      end
  ## 
  ##    last_cell_index = index + (@grid_size + 1)
  ##    # get all the cells surrounding the current cell
  ##  end

  @spec step(map) :: map
  def step(grid), do: step(@grid_size, %{}, grid)

  @spec step(number, map, map) :: map
  def step(0, new_grid, _), do: new_grid
  def step(index, new_grid, old_grid) do
    active_neighbour_cells = 
      Cell.get_neighbours(index) 
      |> number_alive(old_grid)

    cell_state = case active_neighbour_cells do
      3 -> 1
      2 -> 
        IO.inspect "=========================================="
        IO.inspect index
        IO.inspect Map.get(old_grid, "cell:#{index}:")
        IO.inspect "=========================================="
        Map.get(old_grid, "cell:#{index}:")
      _ -> 0
    end

    step(index - 1, Map.put(new_grid, "cell:#{index}:", cell_state), old_grid)
  end

  def generate_grid(), do: generate_grid(@grid_size, %{})

  def generate_grid(0, cells), do: cells
  def generate_grid(index, cells) do
    generate_grid(index - 1, Map.put(cells, "cell:#{index}:", Enum.random(0..1)))
  end

  @spec number_alive(list(number), map) :: number
  def number_alive(cells, grid) do
    List.foldl(cells, 0, fn i, acc ->
      case Map.get(grid, "cell:#{i}:") do
        1 -> acc + 1
        _ -> acc
      end
    end)
  end
end
