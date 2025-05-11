module Router.Header exposing (view)

import Html exposing (Html, button, div, h1, header, text)


view : Html msg
view =
    header [] [ h1 [] [ text "My Site" ] ]
