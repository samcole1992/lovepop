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

Example curl:
    
    curl -XPOST -H 'Content-Type: application/json' -d '{
    "customer": {
        "id": "90042",
        "firstName": "Joe",
        "lastName": "Smith",
        "emailAddress": "jsmith@fakeemail.com"
    },
    "cart": {
        "id": "guid-aXj48n09nd9anlLlenk4523",
        "lineItems": [
            {
                "id": "10000",
                "name": "Cherry Blossom 3D Greeting Card",
                "type": "Greeting Card",
                "price": "1300",
                "tags": [
                    "mothers-day",
                    "sympathy",
                    "romantic",
                    "every-day"
                ],
                "quantity": 1
            }
        ]
    }
}' http://localhost:3000/suggestions

This POST takes a JSON input requiring a customer and a cart

The response will be a JSON object containing suggestions.

Any suggestions contain the corresponding line item, upsell and applicable discount

Additions could include adding token verification for authorization, building out the routes to allow for building customers and their carts.

If I was going to make this a customer facing product I would do it in React


