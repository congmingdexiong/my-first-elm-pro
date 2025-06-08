module R10.FormExampleTable exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Dict
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Html.Attributes
import Markdown
import R10.Form
import R10.FormTypes
import R10.Theme


type alias Model =
    { formState : R10.Form.State }


init : Model
init =
    { formState = R10.Form.initState }


type Msg
    = MsgForm R10.Form.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgForm formMsg ->
            let
                ( newFormState_, formCmd ) =
                    R10.Form.update formMsg model.formState
            in
            ( { model | formState = newFormState_ }
            , Cmd.map MsgForm formCmd
            )


type alias Operation =
    { operationName : String
    , operationDate : String
    }


operations : List Operation
operations =
    List.indexedMap
        (\index _ ->
            { operationName = "Operation " ++ String.fromInt (index + 1)
            , operationDate = "2020.02.02"
            }
        )
        (List.repeat 20 ())


operationsTable : R10.Theme.Theme -> R10.Form.State -> Element Msg
operationsTable theme formState =
    let
        cellAttrs : List (Attribute msg)
        cellAttrs =
            [ Border.widthEach { bottom = 1, left = 1, right = 0, top = 0 }
            , padding 10
            , height fill
            ]

        headerAttrs : List (Attribute msg)
        headerAttrs =
            [ Border.widthEach { bottom = 1, left = 1, right = 0, top = 0 }
            , Font.bold
            , padding 10
            , height fill
            , Font.center
            ]

        tableAttrs : List (Attribute msg)
        tableAttrs =
            [ Border.widthEach { bottom = 0, left = 0, right = 1, top = 1 }
            , width fill
            , alignTop
            ]
    in
    indexedTable
        tableAttrs
        { data = operations
        , columns =
            [ { header = el headerAttrs none
              , width = px 46
              , view =
                    \index _ ->
                        row cellAttrs <| checkbox (R10.Form.themeToPalette theme) formState MsgForm index
              }
            , { header = el headerAttrs <| text "Name"
              , width = fill
              , view =
                    \_ person ->
                        el cellAttrs <| text person.operationName
              }
            , { header = el headerAttrs <| text "Date"
              , width = fill
              , view =
                    \_ person ->
                        el cellAttrs <| text person.operationDate
              }
            ]
        }


checkbox : R10.FormTypes.Palette -> R10.Form.State -> (R10.Form.Msg -> msg) -> Int -> List (Element msg)
checkbox palette state msgTransformer index =
    let
        initFieldConf : R10.Form.FieldConf
        initFieldConf =
            R10.Form.initFieldConf
    in
    R10.Form.viewWithPalette
        { conf =
            [ R10.Form.entity.field
                { initFieldConf
                    | id = String.fromInt index
                    , type_ = R10.FormTypes.inputField.binaryCheckbox
                }
            ]
        , state = state
        }
        msgTransformer
        palette


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    let
        checked : Dict.Dict String R10.Form.FieldState
        checked =
            Dict.filter (\_ value -> R10.Form.stringToBool value.value) model.formState.fieldsState
    in
    [ paragraph [] [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] ]
    , row [ width fill, spacing 20 ]
        [ operationsTable theme model.formState
        , column [ width fill, alignTop, Font.family [ Font.monospace ] ]
            [ paragraph []
                [ text <| "Touched: [" ++ String.join ", " (Dict.keys model.formState.fieldsState) ++ "]" ]
            , text "\n"
            , paragraph []
                [ text <| "Checked: [" ++ String.join ", " (Dict.keys checked) ++ "]" ]
            ]
        ]
    ]
