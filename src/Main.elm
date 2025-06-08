port module Main exposing (main)

import Browser
import Html exposing (Html, div, text)
import Html.Attributes exposing (id, style)
import Html.Events



-- 定义一个类型


type Msg
    = ClickEv String
    | SendMsgToReact
    | GotMessageFromReact String


type alias Item =
    { id : String
    , name : String
    }


type alias Model =
    { message : { id : String }, items : List Item }


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
      }
    , Cmd.none
    )



-- 主视图函数


view : Model -> Html Msg
view model =
    div []
        (List.map itemToDiv model.items)



-- 单个 item 转换为 div


itemToDiv : Item -> Html Msg
itemToDiv item =
    div [ id item.id, style "width" "100%", style "border" "1px solid red", Html.Events.onClick <| ClickEv item.id ] [ text ("这是 " ++ item.name) ]


port sendToReact : { id : String, data : String } -> Cmd msg


port receiveFromReact : (String -> msg) -> Sub msg



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

        _ ->
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
