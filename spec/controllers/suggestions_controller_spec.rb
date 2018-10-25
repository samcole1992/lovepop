require 'rails_helper'

RSpec.describe SuggestionsController, type: :controller do
  describe "POST /suggestions" do
      context "with valid parameters" do
        let(:valid_params) do
          {
              'customer': {
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
                      },
                      {
                          "id": "10003",
                          "name": "X-wing Starfighter™",
                          "type": "Greeting Card",
                          "price": "1500",
                          "tags": [
                              "birthday",
                              "every day",
                              "licensed",
                              "star wars",
                              "fathers day"
                          ],
                          "quantity": 2
                      },
                      {
                          "id": "10009",
                          "name": "Release the Kraken",
                          "type": "Greeting Card",
                          "price": "1300",
                          "tags": [
                              "birthday",
                              "boat",
                              "animal",
                              "dad",
                              "fathers day",
                              "kraken"
                          ],
                          "quantity": 5
                      }
                  ]
              }
          }
        end
        let(:valid_params2) do
          {
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
                      },
                      {
                          "id": "10003",
                          "name": "X-wing Starfighter™",
                          "type": "Greeting Card",
                          "price": "1500",
                          "tags": [
                              "birthday",
                              "every day",
                              "licensed",
                              "star wars",
                              "fathers day"
                          ],
                          "quantity": 2
                      },
                      {
                          "id": "10001",
                          "name": "Christmas Fun 5 Pack",
                          "type": "Card Pack",
                          "price": "4900",
                          "tags": [
                              "holiday",
                              "card-pack",
                              "christmas"
                          ],
                          "quantity": 1
                      },
                      {
                          "id": "10002",
                          "name": "Santa Biker T-Shirt",
                          "type": "T-Shirt",
                          "price": "2000",
                          "tags": [
                              "holiday",
                              "christmas",
                              "t-shirt",
                              "apparel",
                              "santa"
                          ],
                          "quantity": 3
                      },
                      {
                          "id": "10009",
                          "name": "Release the Kraken",
                          "type": "Greeting Card",
                          "price": "1300",
                          "tags": [
                              "birthday",
                              "boat",
                              "animal",
                              "dad",
                              "fathers day",
                              "kraken"
                          ],
                          "quantity": 1
                      }
                  ]
              }
          }
        end
        let(:valid_params3) do
          {
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
          }

        end
        it "creates a new suggestion" do
          post :create, params: valid_params
          expect(response).to have_http_status :ok

          json = JSON.parse(response.body)
          expect(json["meta"]["subtotal"]).to eq(9000.0)
          expect(json["data"]["attributes"]["card_pack"]).to eq(nil)
          expect(json["data"]["attributes"]["holiday"]).to eq(nil)
          expect(json["data"]["attributes"]["free_shipping"]).to eq(nil)
          expect(json["data"]["attributes"]["discount"]["item"].length).to eq(6)
          expect(json["data"]["attributes"]["discount"]["upsell"]).to eq('')
          expect(json["data"]["attributes"]["discount"]["discount"]).to eq('5 for $50')

        end
        it "creates a new suggestion with many suggestions" do
          post :create, params: valid_params2
          expect(response).to have_http_status :ok

          json = JSON.parse(response.body)
          expect(json["meta"]["subtotal"]).to eq(16500.0)

          expect(json["data"]["attributes"]["free_shipping"]['discount']).to eq('Free Shipping')
          expect(json["data"]["attributes"]["discount"]).to eq(nil)

        end
        it "creates a new suggestion with no suggestions" do
          post :create, params: valid_params3
          expect(response).to have_http_status :ok

          json = JSON.parse(response.body)
          expect(json["meta"]["subtotal"]).to eq(1300.0)
          expect(json["data"]["attributes"]["card_pack"]).to eq(nil)
          expect(json["data"]["attributes"]["holiday"]).to eq(nil)
          expect(json["data"]["attributes"]["free_shipping"]).to eq(nil)
          expect(json["data"]["attributes"]["discount"]).to eq(nil)

        end

      end
    end
end
