-- module Main exposing (main)
-- import Browser
-- import Html exposing (Html, button, div, text)
-- import Html.Events exposing (onClick)
-- -- MODEL
-- type alias Model =
--     Int
-- -- INIT
-- init : () -> ( Model, Cmd Msg )
-- init _ =
--     (0, Cmd.none)
-- -- UPDATE
-- type Msg
--     = Increment
--     | Decrement
-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     case msg of
--         Increment ->
--             (model + 1, Cmd.none)
--         Decrement ->
--             (model - 1, Cmd.none)
-- -- VIEW
-- view : Model -> Html Msg
-- view model =
--     div []
--         [ button [ onClick Decrement ] [ text "-" ]
--         , div [] [ text (String.fromInt model) ]
--         , button [ onClick Increment ] [ text "+" ]
--         ]
-- -- MAIN
-- main =
--     Browser.element
--         { init = init
--         , update = update
--         , view = view
--         , subscriptions = \_ -> Sub.none
--         }
-- Import the component


module Main exposing (Model, Msg(..), init, update, view)

import Ui.Ratings



-- Add it to your model


type alias Model =
    { ratings : Ui.Ratings.Model
    }



-- Add it's messages to your messages


type Msg
    = Ratings Ui.Ratings.Msg



-- Add it to your init function


init : Model
init =
    { ratings =
        Ui.Ratings.init ()
            |> Ui.Ratings.size 10

    -- set things on your component
    }



-- Update as usual


update : Msg -> Model -> ( Model, Cmd Msg )
update msg_ model =
    case msg_ of
        Ratings msg ->
            let
                ( ratings, cmd ) =
                    Ui.Ratings.update msg model.ratings
            in
            ( { model | ratings = ratings }, Cmd.map Ratings cmd )



-- Render it in your view


view : Model -> Html.Html Msg
view model =
    Html.map Ratings (Ui.Ratings.view model.ratings)
