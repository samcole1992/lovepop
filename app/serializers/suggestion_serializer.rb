class SuggestionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :card_pack, :holiday, :free_shipping, :discount
end
