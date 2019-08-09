defmodule ExGol.Cell do
  def start_link(cell_index) do
    initial_state = case Enum.random(0..1) do
      0 -> {:ok, %{state: :alive}}
      1 -> {:ok, %{state: :dead}}
    end

    Agent.start_link(fn -> initial_state, name: cell_index)
  end

  def get_state(pid), do: Agent.get(pid, fn (%{ state: state }) -> state)

  def die(pid), do: Agent.update(pid, &(%{&1 | state: :dead}))

  def awake(pid), do: Agent.update(pid, &(%{&1 | state: :awake}))
end
