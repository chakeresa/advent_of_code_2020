defmodule Disc do
  defstruct [:name, :weight, children: []]

  def balanced?(%__MODULE__{children: []}), do: true

  def balanced?(%__MODULE__{children: [%__MODULE__{} = first_child | other_children]}) do
    first_total_weight = total_weight(first_child)

    Enum.all?(other_children, fn %__MODULE__{} = this_child ->
      first_total_weight == total_weight(this_child)
    end)
  end

  def total_weight(%__MODULE__{weight: weight, children: children}) do
    weight +
      Enum.reduce(children, 0, fn %__MODULE__{} = child, sum ->
        sum + total_weight(child)
      end)
  end
end
