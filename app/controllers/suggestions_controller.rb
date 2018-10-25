require "pry"
class SuggestionsController < ApplicationController

  def create
    @suggestion = Suggestion.new()

    card_pack = false
    holiday = false
    subtotal = 0
    full_greeting_total = 0
    greeting_cards = []
    params["cart"]["lineItems"].each{|card|
      if !holiday && card["tags"].include?('holiday')
        holiday = card
      end
      if card["type"]=="Greeting Card" && !card["tags"].include?('licensed')
        card["quantity"].to_i.times do |greeting_card|
          greeting_cards.push(card)
        end
      end
      if !card_pack && card["type"]=="Card Pack"
        card_pack=card
      end
      if card["type"]=="Greeting Card" && !card["tags"].include?('licensed')
          full_greeting_total += card["price"].to_f * card["quantity"].to_i
      else
          subtotal += card["price"].to_f * card["quantity"].to_i
      end
    }

      if greeting_cards.length >= 5
        subtotal += greeting_cards.length * 1000
      else
        subtotal += full_greeting_total
      end
      if card_pack
        @suggestion.card_pack={"item":card_pack,"upsell":"Lovepop Note 5-Pack","discount":""}
      end
      if holiday
        @suggestion.holiday={"item":holiday,"upsell":"Santa Biker T-Shirt","discount":""}
      end
      ## Maybe the freeShipping discount should occur before discounting the greeting cards?
      if subtotal > 10000
        @suggestion.free_shipping={"item":'',"upsell":"","discount":"Free Shipping"}
      end
      if greeting_cards.length >= 5
        @suggestion.discount={"item":greeting_cards,"upsell":"","discount":"5 for $50"}
      end

      if @suggestion.save
        options = {}
          options[:meta] = { subtotal: subtotal }
        render json: SuggestionSerializer.new(@suggestion, options).serialized_json
      else
        render json: @suggestion.errors, status: :unprocessable_entity
      end

    end


end
