defmodule IslandEngine.Island do

    @enforce_keys [:coordinates, :hit_coordinates]
    defstruct [:coordinates, :hit_coordinates]
    def new(type, initial_coordinate) do
        
    end

    def types(): [:atoll, :square, :l_shape, :s_shape]

    def get_coordinates(:atoll, initial_coordinate), do
        [{0, 0}]
        |> generate_coordinates_from_transformations()
    end

    defp generate_coordinates_from_transformations()
end