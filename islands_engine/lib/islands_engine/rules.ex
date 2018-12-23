defmodule IslandsEngine.Rules do

    # t is for transition
    def t("add_player", %{state: "init_game"}), do: %{state: "players_set"}
end