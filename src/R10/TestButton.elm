module R10.TestButton exposing (main)

import Browser
import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Html
import Html.Attributes
import Html.Events exposing (onClick)
import R10.Button
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Color.Svg
import R10.Context
import R10.Device
import R10.DropDown
import R10.FontSize
import R10.Language
import R10.Libu exposing (..)
import R10.Mode
import R10.Paragraph
import R10.Svg.Icons
import R10.Svg.Logos
import R10.Svg.LogosExtra
import R10.Theme


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { count : Int }


type Msg
    = Increment
    | Decrement


init : () -> ( Model, Cmd msg )
init _ =
    ( { count = 1 }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    layout R10.Context.default [ R10.Color.AttrsBackground.background, padding 20, R10.FontSize.normal ] <|
        row [] <|
            -- htmlAttribute (Html.Events.onClick Increment)
            [ R10.Button.primary []
                { label = text "+"
                , libu = R10.Libu.Bu (Just Increment)
                , -- , libu = R10.Libu.Li "https://r10.netlify.app",
                  -- , theme =
                  --     { mode = R10.Mode.Light
                  --     , primaryColor = R10.Color.primary.crimsonRed ,
                  --     }
                  translation = { key = "example" }
                }
            , R10.Button.primary
                [ htmlAttribute (Html.Attributes.style "margin-left" "10px"), htmlAttribute (Html.Events.onClick Decrement) ]
                { label = text "-"
                , libu = R10.Libu.Li "https://r10.netlify.app"
                , -- , libu = R10.Libu.Li "https://r10.netlify.app",
                  -- , theme =
                  --     { mode = R10.Mode.Light
                  --     , primaryColor = R10.Color.primary.crimsonRed ,
                  --     }
                  translation = { key = "example" }
                }
            , text (String.fromInt model.count)
            ]
