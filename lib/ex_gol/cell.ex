defmodule ExGol.Cell do
  @grid_size 10
  @row_size 10

  # def start_link(cell_index) do
  #   initial_state = case Enum.random(0..1) do
  #     0 -> {:ok, %{state: :alive}}
  #     1 -> {:ok, %{state: :dead}}
  #   end

  #   Agent.start_link(fn -> initial_state end, name: cell_index)
  # end

  # def get_state(pid), do: Agent.get(pid, fn (%{ state: state }) -> state end)

  # def die(pid), do: Agent.update(pid, &(%{&1 | state: :dead}))

  # def awake(pid), do: Agent.update(pid, &(%{&1 | state: :awake}))

  @spec get_neighbours(number) :: list(number)
  def get_neighbours(index) do
    []
    |> get_neighbours(:above, index)
    |> get_neighbours(:left, index)
    |> get_neighbours(:right, index)
    |> get_neighbours(:below, index)
  end

  @spec get_neighbours(list, atom, number) :: list(number)
  def get_neighbours(cells, :above, index) when index <= @row_size, do: cells

  def get_neighbours(cells, :above, index) do
    median_index = Kernel.trunc(index - @grid_size / @row_size)

    IO.inspect "above"
    IO.inspect [(median_index - 1), median_index, (median_index + 1) | cells]

    [(median_index - 1), median_index, (median_index + 1) | cells]
  end

  def get_neighbours(cells, :left, @grid_size), do: cells
  def get_neighbours(cells, :left, index) when (@grid_size / index) == 1.0, do: cells
  def get_neighbours(cells, :left, index), do: [index + 1 | cells]

  def get_neighbours(cells, :right, 1), do: cells
  def get_neighbours(cells, :right, index) when (@grid_size / (index - 1)) == 1.0, do: cells
  def get_neighbours(cells, :right, index), do: [index - 1 | cells]

  def get_neighbours(cells, :below, index) when index >= (@grid_size - @row_size), do: cells
  def get_neighbours(cells, :below, index) do
    median_index = Kernel.trunc(index + @grid_size / @row_size)

    IO.inspect "below"
    IO.inspect index
    IO.inspect [(median_index - 1), median_index, (median_index + 1) | cells]

    [(median_index - 1), median_index, (median_index + 1) | cells]
  end
end
