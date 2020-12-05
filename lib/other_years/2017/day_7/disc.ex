defmodule Disc do
  defstruct [:name, :weight, children: []]

  def balanced?(%__MODULE__{children: []}), do: true

  def balanced?(%__MODULE__{children: [%__MODULE__{weight: first_weight} | _rest] = children}) do
    Enum.all?(children, fn %__MODULE__{} = this_disc ->
      first_weight == total_weight(this_disc)
    end)
  end

  def total_weight(%__MODULE__{weight: weight, children: children}) do
    weight +
      Enum.reduce(children, 0, fn %__MODULE__{} = child, sum ->
        sum + total_weight(child)
      end)
  end
end
