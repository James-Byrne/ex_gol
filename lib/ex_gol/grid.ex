defmodule ExGol.Grid do
  use GenServer

  alias ExGol.Cell

  @grid_size 100

  def start_link do

  end

  # Callbacks

  def init() do
    # assemble the grid
    grid = generate_grid(@grid_size * @grid_size)

    # setup the stepper
    {:ok, %{}}
  end

  def handle_cast({:add_cell, index}, state) do
    {:ok, pid} = Cell.start_link(index)

    state = Cell.get_state(cell_pid)

    {:noreply, Map.put(state, "cell:#{pid}", state)}
  end

  def handle_cast({:step, cell_id}, %{cells: cells}) do
  end

  # private functions

  defp generate_grid() do
    number_of_cells = @grid_size * @grid_size
    add_cells(number_of_cells)
  end

  defp add_cells(0), do: ok
  defp add_cells(i) do
    GenServer.cast(__MODULE__, {:add_cell, i})
    add_cell(i - 1)
  end

  defp check_cells([], cells_map), do: :ok
  defp check_cells([cell | tail], cells_map) do
    index = get_cell_index(head)

    surrounding_cells = get_surrounding_cells(index)

    check_cells(tail)
  end

  defp get_cell_index(<<"cell:", index>>), do: index

  defp get_surrounding_cells(index, cells_map) do
    first_cell_index = index - (@grid_size + 1)
    left_cell_index = 
      case {:left, rem(@grid_size / index)} do
        {:left, 1} -> :far_left_cell
        {:left, _} -> index - 1
      end
    right_cell_index = 
      case {:right, rem(@grid_size / index)} do
        {:right, 0} -> :far_right_cell
        {:right, _} -> index + 1
      end
 
    last_cell_index = index + (@grid_size + 1)
    # get all the cells surrounding the current cell
  end
end
