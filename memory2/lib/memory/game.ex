defmodule Memory.Game do
  def new do
    %{
      word: next_word(),
      guesses: [],
      cardlist: [
              %{value: "A", face: false, match: false, pos: 0}, 
              %{value: "B", face: false, match: false, pos: 1}, 
              %{value: "C", face: false, match: false, pos: 2}, 
              %{value: "D", face: false, match: false, pos: 3}, 
              %{value: "E", face: false, match: false, pos: 4}, 
              %{value: "F", face: false, match: false, pos: 5}, 
              %{value: "G", face: false, match: false, pos: 6}, 
              %{value: "H", face: false, match: false, pos: 7}, 
              %{value: "H", face: false, match: false, pos: 8}, 
              %{value: "G", face: false, match: false, pos: 9}, 
              %{value: "F", face: false, match: false, pos: 10}, 
              %{value: "E", face: false, match: false, pos: 11}, 
              %{value: "D", face: false, match: false, pos: 12}, 
              %{value: "C", face: false, match: false, pos: 13}, 
              %{value: "B", face: false, match: false, pos: 14}, 
              %{value: "A", face: false, match: false, pos: 15}],
     score: 0,
     clicks: 0,
     previous_card: "Z"
    }
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
      cards: game.cardlist,
      score: game.score,
      clicks: game.clicks,
      previous_card: game.previous_card
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

  def change_face(cards, pos) do
    Enum.map cards, fn card ->
      if Map.fetch!(card, :pos) == pos do
	Map.put(card, :face, true)
      else 
	card
      end
     end 
  end

  def close_face(cards, pos, clicks) do
    if rem(clicks, 2) != 0 do
       cards
    else Enum.map cards, fn card ->
      if Map.fetch!(card, :match) == false do
	Map.put(card, :face, false)
      else 
	card
      end
     end 
    end
  end

  # Return Char
  def set_previous_letter(cards, pos, clicks, previous_card) do
    Enum.map cards, fn card ->
      if Map.fetch!(card, :pos) == pos and rem(clicks, 2) != 0 do
        Map.get(card, :value)
      else if Map.fetch!(card, :pos) == pos and rem(clicks, 2) == 0 do
        "Z"
      else
        previous_card
      end
     end
    end
  end

  def flip(game, pos) do

    #Decrement the Score
    new_score = game.score - 5
    new_game = Map.put(game, :score, new_score)

    #Increment the Clicks
    new_clicks = new_game.clicks + 1
    new_game2 = Map.put(new_game, :clicks, new_clicks)

    #Change the face of the card
    cards = new_game2.cardlist
    new_cards = change_face(cards, pos)
    new_game3 = Map.put(new_game2, :cardlist, new_cards)


    #Set the Previous Card value for odd clicks
    #new_previous = set_previous_letter(new_game3.cardlist, pos, new_game3.clicks, new_game3.previous_card)
    #Map.put(new_game3, :previous_card, new_previous)  

    #For Even Clicks induce delay


    #Check for match and update cards

 

  end

  def flop(game, pos) do
    #Close the face of the card for even clicks
    if(rem(game.clicks, 2) == 0) do
      Process.sleep(1000)
    end
    cards = game.cardlist
    new_cards = close_face(cards, pos, game.clicks)
    Map.put(game, :cardlist, new_cards)
    
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

