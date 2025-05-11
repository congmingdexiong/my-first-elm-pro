module Router.Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, div, text)
import Json.Decode as Decode exposing (Value)
import Router.Header
import Router.HomeRoute
import Test exposing (Model)
import Url exposing (Url)


type Route
    = HeaderRouter
    | HomeRoute


type Msg
    = UrlChanged Url
    | None


parseUrl : Url -> Route
parseUrl url =
    case url.path of
        "/" ->
            HomeRoute

        "/header" ->
            HeaderRouter

        _ ->
            HomeRoute


view : Route -> Browser.Document msg
view route =
    case route of
        HomeRoute ->
            { title = "Home"
            , body = [ Router.HomeRoute.view ]
            }

        HeaderRouter ->
            { title = "Header"
            , body = [ Router.HomeRoute.view ]
            }


main : Program Value Model Msg
main =
    Browser.application
        { init = \flags url navKey -> ( parseUrl url, Cmd.none )
        , view = \model -> view model
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = \model -> Sub.none
        , onUrlRequest = \_ -> HomeRoute
        , onUrlChange = parseUrl
        }
