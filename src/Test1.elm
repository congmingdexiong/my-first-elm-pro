module Test1 exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, map4, field, int, string)



main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- init 


type alias Model = { content : String} 

type alias Quote =
  { quote : String
  , source : String
  , author : String
  , year : Int
  }


init : () -> (Model, Cmd Msg)
init _ =
  ({ content="Lion"}, getRandomQuote)



type  Msg
  = LoadData 
  | GotJson (Result Http.Error Quote)

type Result error value
  = Ok value
  | Err error

  


-- update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =  
  case msg of 
    LoadData ->
      (model, getRandomQuote)
    GotJson status ->
      case status of
        Ok quote ->
          ({ content = quote.quote }, Cmd.none)
        Err _ ->
          (model, Cmd.none)



getRandomQuote : Cmd Msg
getRandomQuote =  
  Http.get
    { url = "https://elm-lang.org/api/random-quotes"  
    , expect  = Http.expectJson GotJson  quoteDecoder   }

quoteDecoder : Decoder Quote
quoteDecoder =
  map4 Quote
    (field "quote" string)
    (field "source" string)
    (field "author" string)
    (field "year" int)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
--  view

view : Model -> Html Msg
view model =
  div [] [ text model.content ]