defmodule Memory.Game do
  def new do
    %{
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
    
    %{
      cards: game.cardlist,
      score: game.score,
      clicks: game.clicks,
      previous_card: game.previous_card
    }
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

  def close_face(cards, clicks) do
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

  def set_previous_letter(cards, pos, clicks) do
    if(rem(clicks, 2) == 0) do
       %{value: "Z", face: false, match: false, pos: 20}
    else Enum.find cards, fn card ->
           if Map.fetch!(card, :pos) == pos do
	       Map.get(card, :value)
           end
     end 
     end
  end

  def flip(game, pos) do

    #Change the face of the card
    cards = game.cardlist
    new_cards = change_face(cards, pos)
    new_game3 = Map.put(game, :cardlist, new_cards)

    #Cards are matched
    cards = match_cards(new_game3.cardlist, game.previous_card, pos)

    new_game4 = Map.put(new_game3, :cardlist, cards)

    #Increment the Clicks
    new_clicks = new_game4.clicks + 1
    new_game5 = Map.put(new_game4, :clicks, new_clicks)

    #Set the Previous Card value for odd clicks
    new_previous = set_previous_letter(new_game5.cardlist, pos, new_game5.clicks)
    Map.put(new_game5, :previous_card, new_previous)  

  end

  def match_cards(cards, previous, pos) do
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

  def get_match_points(game) do
    Enum.reduce(game.cardlist, 0, fn(card, acc) ->
						if Map.fetch!(card, :match) == true do
							acc + 1 
						else
							acc
						end
    end)
  end

  def get_click_points(game) do
    game.clicks 
  end

  def get_score(game) do
    (get_match_points(game) * 10) - (get_click_points(game) * 2)
  end

  def flop(game, _pos) do
    #Close the face of the card for even clicks
    if(rem(game.clicks, 2) == 0) do
      Process.sleep(1000)
    end

    cards = game.cardlist
    new_cards = close_face(cards, game.clicks)
    closed_game = Map.put(game, :cardlist, new_cards)

    new_game = Map.put(closed_game, :score, get_score(closed_game))   

    if(rem(new_game.clicks, 2) == 0) do
      Map.put(new_game, :previous_card, %{value: "Z", face: false, match: false, pos: 20})
    else
      Map.put(new_game, :previous_card, new_game.previous_card)
    end
  end

  def reset(game, cardlist) do
    reset_map = Map.put(game, :cardlist, cardlist)
    reset_cards = game.cardlist
    new_cards = close_face(reset_cards, game.clicks)
    game_reset_cards = Map.put(game, :cardlist, new_cards)
    game_reset_clicks = Map.put(game_reset_cards, :clicks, 0)
    Map.put(game_reset_clicks, :score, 0)
  end

end

