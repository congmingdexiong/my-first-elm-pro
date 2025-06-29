module Main_interactive%20copy exposing (..)port module Main_interactive exposing (main)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, div, text)
import Html.Attributes exposing (id, style)
import Html.Events
import Json.Decode as Decode



-- 定义一个类型


type Msg
    = ClickEv String
    | SendMsgToReact String
    | GotMessageFromReact Decode.Value


type alias Item =
    { id : String
    , name : String
    }


type alias Model =
    { message : { id : String }, items : List Item, inputs : Dict String String }


init : () -> ( Model, Cmd msg )
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



-- 主视图函数


view : Model -> Html Msg
view model =
    div []
        [ div
            []
            (List.map itemToDiv model.items)
        , div
            [ Html.Events.onClick <| SendMsgToReact "!23" ]
            [ text "click me" ]
        ]



-- 单个 item 转换为 div


itemToDiv : Item -> Html Msg
itemToDiv item =
    div [ id item.id, style "width" "100%", style "border" "1px solid red", Html.Events.onClick <| ClickEv item.id ] [ text ("这是 " ++ item.name) ]


port sendToReact : () -> Cmd msg


port receiveFromReact : (Decode.Value -> msg) -> Sub msg



-- PORT：定义 JS 可以调用的方法名


port callWindowFunction : String -> Cmd msg


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ClickEv id ->
            let
                _ =
                    Debug.log "123" id
            in
            ( model, callWindowFunction id )

        SendMsgToReact id ->
            let
                _ =
                    Debug.log "123" id
            in
            ( model, sendToReact () )

        GotMessageFromReact inputVal ->
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


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveFromReact GotMessageFromReact



-- 主程序入口


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
