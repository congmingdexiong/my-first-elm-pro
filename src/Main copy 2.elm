module Main exposing (..)

-- import Element exposing (Element, el, text, row, alignRight, fill, width, rgb255, spacing, centerY, padding)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html, div)


blue =
    Element.rgb255 238 238 238


myButton =
    Input.button
        [ Background.color blue
        , Element.focused
            [ Background.color blue ]
        ]
        { onPress = Just ClickMsg
        , label = text "My Button"
        }


main =
    Element.layout []
        myRowOfStuff


type Msg
    = ClickMsg



-- myElement1 =
--     div
--         [ Background.color (rgb 0 0.5 0)
--         , Border.color (rgb 0 0.7 0)
--         ]
--         (Element.text "You've made a stylish element!")


myRowOfStuff : Element msg
myRowOfStuff =
    column
        [ spacing 20
        , padding 20
        , Background.color (rgb255 240 240 240)
        ]
        [ row
            [ spacing 20
            , padding 10
            , Background.color (rgb255 200 230 255)
            ]
            [ el
                [ width (px 100)
                , height (px 50)
                , Background.color (rgb255 180 200 255)
                , Border.rounded 5
                , centerX
                , centerY
                ]
                (text "Row 1 - Item 1")
            , paragraph []
                [ text "lots of text ...."
                , el [ Font.bold ] (text "this is bold")
                , text "lots of text ...."
                ]
            ]
        , row
            [ spacing 20
            , padding 10
            , Background.color (rgb255 255 200 200)
            ]
            [ el
                [ width (px 100)
                , height (px 50)
                , Background.color (rgb255 255 180 180)
                , Border.rounded 5
                , centerX
                , centerY
                ]
                (text "Row 2 - Item 1")
            , el
                [ width (px 100)
                , height (px 50)
                , Background.color (rgb255 255 180 180)
                , Border.rounded 5
                , centerX
                , centerY
                ]
                (text "Row 2 - Item 2")
            ]
        ]


myElement : Element msg
myElement =
    el
        [ Background.color (rgb255 240 0 245)
        , Font.color (rgb255 255 255 255)
        , Border.rounded 3
        , padding 30
        ]
        (text "stylish!")
