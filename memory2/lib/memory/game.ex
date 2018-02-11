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
     previous_card: %{value: "Z", face: false, match: false, pos: 20}
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
    if(rem(clicks, 2) == 0) do
       %{value: "Z", face: false, match: false, pos: 20}
    else
    Enum.find cards, fn card ->
      if Map.fetch!(card, :pos) == pos do
	Map.get(card, :value)
      end
     end 
    end
  end

  def flip(game, pos) do

    #Decrement the Score
    new_score = game.score - 5
    new_game2 = Map.put(game, :score, new_score)


    #Change the face of the card
    cards = new_game2.cardlist
    new_cards = change_face(cards, pos)
    new_game3 = Map.put(new_game2, :cardlist, new_cards)

    #Card Match function Call goes here

    cards = match_cards2(new_game3.cardlist, game.previous_card, pos)

    new_game4 = Map.put(new_game3, :cardlist, cards)

    #Increment the Clicks
    new_clicks = new_game4.clicks + 1
    new_game5 = Map.put(new_game4, :clicks, new_clicks)

    #Set the Previous Card value for odd clicks
    new_previous = set_previous_letter(new_game5.cardlist, pos, new_game5.clicks, new_game5.previous_card)
    Map.put(new_game5, :previous_card, new_previous)  

  end

  def match_cards(cards, previous, clicks, pos) do
    IO.inspect("In match_cards")
      IO.inspect(cards)
      IO.inspect(previous)
      IO.inspect(clicks)
#    if rem(clicks, 2) != 0 do
#       IO.inspect("In If statement")
#       cards
      Enum.map cards, fn card ->
      IO.inspect(card)
      IO.inspect(previous)
      if Map.fetch!(card, :value) == Map.fetch!(previous, :value) and (Map.fetch!(card, :pos) == Map.fetch!(previous, :pos) or Map.fetch!(card, :pos) == pos) do
	Map.put(card, :match, true)
      else 
	card
      end
     #end 
    end

  end

  def match_cards2(cards, previous, pos) do
    current_card = Enum.find cards, fn card ->
                    if Map.fetch!(card, :pos) == pos do
	               card
                    end
                   end
    if Map.fetch!(current_card, :value) == Map.fetch!(previous, :value) do
       Enum.map cards, fn card ->
       if Map.fetch!(card, :value) == Map.fetch!(previous, :value) and Map.fetch!(card, :value) == Map.fetch!(current_card, :value) do
          Map.put(card, :match, true)
       else
         card
       end
      end
    else
      cards
    end
 
  end

  def flop(game, pos) do
    #Close the face of the card for even clicks
    if(rem(game.clicks, 2) == 0) do
      Process.sleep(1000)
    end


    cards = game.cardlist

    new_cards = close_face(cards, pos, game.clicks)
    new_game = Map.put(game, :cardlist, new_cards)



    if(rem(new_game.clicks, 2) == 0) do
      Map.put(new_game, :previous_card, %{value: "Z", face: false, match: false, pos: 20})
    else
      Map.put(new_game, :previous_card, new_game.previous_card)
    end
    
  end

  def reset(game, cardlist) do
	Map.put(game, :cardlist, cardlist)
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

