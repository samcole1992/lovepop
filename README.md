# README

This project is bootstrapped with rails new lovepop --api

  To start the project:
    
    rake db:create

    rake db:migrate

    bundle

    rails s
  
 To test:
 
    rake

At this stage there is ONE route

suggestions POST /suggestions(.:format) suggestions#create

This POST takes a JSON input requiring a customer and a cart

The response will be a JSON object containing suggestions.

Any suggestions contain the corresponding line item, upsell and applicable discount

Additions could include adding token verification for authorization, building out the routes to allow for building customers and their carts.
