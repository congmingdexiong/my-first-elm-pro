port module Main exposing (main)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (id, style)
import Html.Events exposing (onClick)
import Json.Decode as Decode



-- MODEL


type alias Model =
    { message : { id : String }, items : List Item, inputs : Dict String String }


type alias Item =
    { id : String
    , name : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { message = { id = "" }
      , items =
            [ { id = "item1", name = "苹果" }
            , { id = "item2", name = "香蕉" }
            , { id = "item3", name = "橘子" }
            , { id = "item4", name = "橘子2" }
            , { id = "item5", name = "橘子3" }
            , { id = "item6", name = "橘子4" }
            , { id = "item7", name = "橘子5" }
            ]
      , inputs = Dict.empty
      }
    , Cmd.none
    )


itemToDiv : Item -> Html Msg
itemToDiv item =
    div [ id item.id, style "width" "100%", style "border" "1px solid red", Html.Events.onClick <| ClickEv item.id ] [ text ("这是 " ++ item.name) ]



-- UPDATE


type Msg
    = RenderReact
    | GotReact String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RenderReact ->
            ( model, renderReact { divId = "react-target", initialValue = "" } )

        GotReact inputVal ->
            case Decode.decodeValue (Decode.dict Decode.string) inputVal of
                Ok dict ->
                    let
                        _ =
                            Debug.log "dict" dict
                    in
                    ( { model | inputs = dict }, Cmd.none )

                Err err ->
                    -- 解码失败时，你可以打印或记录错误信息
                    ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick RenderReact ] [ text "Render React" ]
        , div [ id "react-target" ] []
        , div [] [ text ("Input: " ++ model.value) ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveFromReact GotReact



-- PORTS


port renderReact : { divId : String, initialValue : String } -> Cmd msg


port receiveFromReact : (String -> msg) -> Sub msg


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
