defmodule IslandsEngine.Island do
  alias IslandsEngine.{Coordinate, Island}
  @enforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  def types(), do: [:point, :atoll, :square, :l_shape, :s_shape]

  def new(island_type, %Coordinate{} = initial_coordinate) do
    with [_ | _] = island_offsets <- offsets(island_type),
         %MapSet{} = coordinates <- generate_coordinates(island_offsets, initial_coordinate) do
      {:ok, %Island{coordinates: coordinates, hit_coordinates: MapSet.new()}}
    else
      error -> error
    end
  end

  defp generate_coordinates(offsets, initial_coordinate) do
    offsets
    |> Enum.reduce_while(MapSet.new(), fn offset, acc ->
      add_coordinate(acc, offset, initial_coordinate)
    end)
  end

  defp add_coordinate(coordinates, {r_offset, c_offset}, %Coordinate{row: row, col: col}) do
    case Coordinate.new(row + r_offset, col + c_offset) do
      {:ok, coordinate} ->
        {:cont, MapSet.put(coordinates, coordinate)}

      {:error, :invalid_coordinates} = error ->
        {:halt, error}
    end
  end

  defp offsets(:point), do: [{0, 0}]

  defp offsets(:atoll),
    do: [
      {0, 0},
      {0, 1},
      {1, 1},
      {2, 0},
      {2, 1}
    ]

  defp offsets(:square),
    do: [
      {0, 0},
      {0, 1},
      {1, 0},
      {1, 1}
    ]

  defp offsets(:l_shape),
    do: [
      {0, 0},
      {1, 0},
      {2, 0},
      {2, 1}
    ]

  defp offsets(:s_shape),
    do: [
      {0, 1},
      {0, 2},
      {1, 0},
      {1, 1}
    ]

  defp offsets(_), do: {:error, :invalid_island_type}
end
