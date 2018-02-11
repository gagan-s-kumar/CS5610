defmodule Memory.Game do
  def new do
    %{
      word: next_word(),
      guesses: [],
      cardlist: [
              %{value: 'A', face: false, match: false, pos: 0}, 
              %{value: 'B', face: false, match: false, pos: 1}, 
              %{value: 'C', face: false, match: false, pos: 2}, 
              %{value: 'D', face: false, match: false, pos: 3}, 
              %{value: 'E', face: false, match: false, pos: 4}, 
              %{value: 'F', face: false, match: false, pos: 5}, 
              %{value: 'G', face: false, match: false, pos: 6}, 
              %{value: 'H', face: false, match: false, pos: 7}, 
              %{value: 'H', face: false, match: false, pos: 8}, 
              %{value: 'G', face: false, match: false, pos: 9}, 
              %{value: 'F', face: false, match: false, pos: 10}, 
              %{value: 'E', face: false, match: false, pos: 11}, 
              %{value: 'D', face: false, match: false, pos: 12}, 
              %{value: 'C', face: false, match: false, pos: 13}, 
              %{value: 'B', face: false, match: false, pos: 14}, 
              %{value: 'A', face: false, match: false, pos: 15}]
    }
    #IO.puts("new called")
  end

  def client_view(game) do
    ws = String.graphemes(game.word)
    gs = game.guesses
    cards = game.cardlist
    #clicks = game.clicks
    #score = game.score
    
    %{
      skel: skeleton(ws, gs, cards),
      goods: Enum.filter(gs, &(Enum.member?(ws, &1))),
      bads: Enum.filter(gs, &(!Enum.member?(ws, &1))),
      extras: Enum.filter(gs, &(!Enum.member?(ws, &1))),
      max: max_guesses(),
      cards: game.cardlist
    }
    #IO.puts("client_view called")
  end

  def skeleton(word, guesses, cards) do
    #IO.puts("skeleton called")
    Enum.map word, fn cc ->
      if Enum.member?(guesses, cc) do
        cc
      else
        "_"
      end
   end
  end

  def guess(game, letter) do
    if letter == "z" do
      raise "That's not a real letter"
    end

    gs = game.guesses
    |> MapSet.new()
    |> MapSet.put(letter)
    |> MapSet.to_list

    Map.put(game, :guesses, gs)
  end

  def max_guesses do
    10
  end

  def next_word do
    words = ~w(
      horse snake jazz violin
      muffin cookie pizza sandwich
      house train clock
      parsnip marshmallow
    )
    Enum.random(words)
  end
end

