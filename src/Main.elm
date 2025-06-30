module Main exposing (..)

import Browser
import Dict exposing (Dict)
import Element.WithContext exposing (..)
import Element.WithContext.Font as Font
import Html
import Html.Attributes exposing (maxlength, minlength)
import Html.Events as Events
import R10.Button
import R10.Card
import R10.Color.AttrsBackground
import R10.Color.Svg
import R10.Context
import R10.FontSize
import R10.Form exposing (Validation, ValidationMessage, validationCodes)
import R10.FormTypes
import R10.Libu
import R10.Paragraph
import R10.Svg.LogosExtra
import Set


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { form : R10.Form.Form }


type Msg
    = MsgForm R10.Form.Msg
    | SendMsgToReact
    | BtnClick
    | FieldChanged R10.Form.Key String -- key, new value


init : () -> ( Model, Cmd msg )
init _ =
    ( { form =
            { conf =
                [ R10.Form.entity.withTabs "2"
                    [ ( "Tab1"
                      , R10.Form.entity.field
                            { id = "cardNumber"
                            , idDom = Nothing
                            , type_ = R10.FormTypes.TypeText R10.FormTypes.TextEmail
                            , label = "Email1"
                            , clickableLabel = False
                            , helperText = Just "Helper text for Email1"
                            , requiredLabel = Just "(required)"
                            , validationSpecs =
                                Just
                                    { pretendIsNotValidatedIfValid = True
                                    , showAlsoPassedValidation = False
                                    , validationIcon = R10.FormTypes.NoIcon
                                    , validation =
                                        [-- minlength 1,
                                         --   R10.Form.validation.minLength 3
                                         --   R10.Form.validation.withMsg
                                         --     { ok = "ok111"
                                         --     , err = "error"
                                         --     }
                                         --   <|
                                         --     R10.Form.validation.minLength 3
                                         -- R10.Form.validation.required
                                         --   R10.Form.validation.minLength 3
                                         -- maxlength 5
                                         --   R10.Form.validationCodes
                                        ]
                                    }
                            , minWidth = Nothing
                            , maxWidth = Nothing
                            , autocomplete = Nothing
                            , placeholder = Nothing
                            , allowOverMaxLength = False
                            }
                      )
                    , ( "Tab2"
                      , R10.Form.entity.normal "xxx2" <|
                            [ R10.Form.entity.field <|
                                { id = "email"
                                , idDom = Nothing
                                , type_ = R10.FormTypes.TypeText R10.FormTypes.TextEmail
                                , label = "Email2"
                                , clickableLabel = False
                                , helperText = Just "Helper text for Email2"
                                , requiredLabel = Just "(required)"
                                , validationSpecs =
                                    Just
                                        { pretendIsNotValidatedIfValid = True
                                        , showAlsoPassedValidation = False
                                        , validationIcon = R10.FormTypes.NoIcon
                                        , validation =
                                            []
                                        }
                                , minWidth = Nothing
                                , maxWidth = Nothing
                                , autocomplete = Nothing
                                , placeholder = Nothing
                                , allowOverMaxLength = False
                                }

                            -- , R10.Form.entity.field <|
                            --     { id = "email"
                            --     , idDom = Nothing
                            --     , type_ = R10.FormTypes.TypeText R10.FormTypes.TextEmail
                            --     , label = "Email3"
                            --     , clickableLabel = False
                            --     , helperText = Just "Helper text for Email3"
                            --     , requiredLabel = Just "(required)"
                            --     , validationSpecs =
                            --         Just
                            --             { pretendIsNotValidatedIfValid = True
                            --             , showAlsoPassedValidation = False
                            --             , validationIcon = R10.FormTypes.NoIcon
                            --             , validation =
                            --                 []
                            --             }
                            --     , minWidth = Nothing
                            --     , maxWidth = Nothing
                            --     , autocomplete = Nothing
                            --     , placeholder = Nothing
                            --     , allowOverMaxLength = False
                            --     }
                            ]
                      )
                    ]
                ]

            --             type alias State =
            -- { fieldsState : Dict.Dict R10.Form.Internal.Key.KeyAsString R10.Form.Internal.FieldState.FieldState
            -- , multiplicableQuantities : Dict.Dict R10.Form.Internal.Key.KeyAsString Int
            -- , activeTabs : Dict.Dict R10.Form.Internal.Key.KeyAsString String
            -- , focused : Maybe R10.Form.Internal.Key.KeyAsString
            -- , active : Maybe R10.Form.Internal.Key.KeyAsString
            -- , removed : Set.Set R10.Form.Internal.Key.KeyAsString
            -- , qtySubmitAttempted : R10.Form.Internal.QtySubmitAttempted.QtySubmitAttempted
            -- , changesSinceLastSubmissions : Bool
            -- , lastKeyDownIsProcess : Bool
            -- }
            -- , state =
            --     { fieldsState = Dict.empty
            --     , multiplicableQuantities = Dict.empty
            --     , activeTabs = Dict.empty
            --     , focused = Nothing
            --     , active = Nothing
            --     , removed = Set.empty
            --     , qtySubmitAttempted = 0
            --     }
            , state = R10.Form.initState
            }
      }
    , Cmd.none
    )



-- init _ =
-- ( { form =
--         { conf =
--             [ R10.Form.entity.field
--                 { id = "email"
--                 , idDom = Nothing
--                 , type_ = R10.FormTypes.TypeText R10.FormTypes.TextEmail
--                 , label = "Email"
--                 , clickableLabel = False
--                 , helperText = Just "Helper text for Email"
--                 , requiredLabel = Just "(required)"
--                 , validationSpecs =
--                     Just
--                         { pretendIsNotValidatedIfValid = True
--                         , showAlsoPassedValidation = False
--                         , validationIcon = R10.FormTypes.NoIcon
--                         , validation =
--                             [ R10.Form.commonValidation.email
--                             , R10.Form.validation.minLength 5
--                             , R10.Form.validation.maxLength 50
--                             , R10.Form.validation.required
--                             ]
--                         }
--                 , minWidth = Nothing
--                 , maxWidth = Nothing
--                 , autocomplete = Nothing
--                 , placeholder = Nothing
--                 , allowOverMaxLength = False
--                 }
--             , R10.Form.entity.field
--                 { id = "password"
--                 , idDom = Nothing
--                 , type_ = R10.FormTypes.TypeText (R10.FormTypes.TextPasswordNew "Show password")
--                 , label = "Password"
--                 , clickableLabel = False
--                 , helperText = Just "Helper text for Password"
--                 , requiredLabel = Just "(required)"
--                 , validationSpecs =
--                     Just
--                         { pretendIsNotValidatedIfValid = True
--                         , showAlsoPassedValidation = False
--                         , validationIcon = R10.FormTypes.NoIcon
--                         , validation =
--                             [ R10.Form.validation.minLength 8
--                             , R10.Form.validation.required
--                             ]
--                         }
--                 , minWidth = Nothing
--                 , maxWidth = Nothing
--                 , autocomplete = Nothing
--                 , placeholder = Nothing
--                 , allowOverMaxLength = False
--                 }
--             ]
--         , state = R10.Form.initState
--         }
--   }
-- , Cmd.none
-- )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        MsgForm msgForm ->
            let
                form : R10.Form.Form
                form =
                    model.form

                ( newState, cmd ) =
                    R10.Form.update (\_ a -> a) msgForm form.state

                newForm : R10.Form.Form
                newForm =
                    { form | state = newState }

                -- maybeFieldMsg =
                --     R10.Form.onValueChange
                --         (\key _ _ newVal ->
                --             FieldChanged key newVal
                --         )
                --         msgForm
                -- activeTab =
                --     R10.Form.getActiveTab (R10.Form.keyToString <| R10.Form.listToKey <| [ "Tab1" ]) model.form.state
                -- R10.Form.getActiveTab "Tab1" model.form.state
                -- counter =
                --     model.form.state
                --         |> R10.Form.getActiveTab "1"
                counter : Int
                counter =
                    model.form.state
                        |> R10.Form.getFieldValue "cardNumber"
                        |> Maybe.withDefault ""
                        |> String.length
                        |> modBy 3

                data =
                    R10.Form.getFieldValue "cardNumber" model.form.state

                maybeFieldMsg =
                    R10.Form.onValueChange
                        (\key _ _ newVal ->
                            FieldChanged key newVal
                        )
                        msgForm

                _ =
                    Debug.log "maybeFieldMsg" maybeFieldMsg

                -- _ =
                --     Debug.log "data cardNumber" data
                -- _ =
                --     Debug.log "datmodel.form.statea" model.form.state
            in
            ( { model | form = newForm }, Cmd.none )

        SendMsgToReact ->
            let
                data =
                    model.form.state
                        |> R10.Form.getFieldValue
                            "1/cardNumber"

                newState =
                    model.form.state

                -- upDateState =
                --     { newState | activeTabs = Dict.fromList [ ( "1", "Tab2" ) ] }
                -- form =
                --     model.form
                -- newForm =
                --     { form | state = upDateState }
                -- _ =
                --     Debug.log "data XXX" data
            in
            ( model, Cmd.none )

        BtnClick ->
            let
                -- state =
                --     R10.Form.setActiveTab "1" "xxx2" model.form.state
                state =
                    R10.Form.setActiveTab "1" "xxx2" model.form.state

                form =
                    model.form

                newForm =
                    { form | state = state }

                _ =
                    Debug.log "newForm" newForm.state

                updateCardNumberField field =
                    if field.id == "cardNumber" then
                        let
                            updatedValidation =
                                Just
                                    { pretendIsNotValidatedIfValid = True
                                    , showAlsoPassedValidation = False
                                    , validationIcon = R10.FormTypes.NoIcon
                                    , validation =
                                        [ R10.Form.validation.required
                                        ]
                                    }
                        in
                        { field | validationSpecs = updatedValidation }
                    else
                        field

                updatedForm =
                    { model.form
                        | conf =
                            List.map
                                (\tab ->
                                    case tab of
                                        R10.Form.EntityTab tabId fields ->
                                            R10.Form.F.EntityTab tabId (List.map updateCardNumberField fields)
                                        _ ->
                                            tab
                                )
                                model.form.conf
                    }
            in
            ( { model | form = newForm }, Cmd.none )

        FieldChanged key newValue ->
            let
                _ =
                    Debug.log "key" key

                _ =
                    Debug.log "newValue" newValue
            in
            ( model, Cmd.none )


view : Model -> Html.Html Msg
view model =
    layoutWith R10.Context.default
        { options =
            [ focusStyle
                { borderColor = Nothing
                , backgroundColor = Nothing
                , shadow = Nothing
                }
            ]
        }
        [ R10.Color.AttrsBackground.background, padding 20, R10.FontSize.normal ]
        (column
            (R10.Card.high
                ++ [ centerX
                   , centerY
                   , width (fill |> maximum 360)
                   , height shrink
                   , spacing 30
                   , htmlAttribute <| Events.onClick SendMsgToReact
                   ]
            )
            [ column [ spacing 20, width fill ] <| R10.Form.view model.form MsgForm
            , html <| Html.button [ Events.onClick BtnClick ] [ Html.text "123" ]
            ]
        )
