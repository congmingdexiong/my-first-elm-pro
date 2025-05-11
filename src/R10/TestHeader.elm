module R10.TestHeader exposing (Msg, main)

-- import R10.Header

import Browser
import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events
import Element.WithContext.Font as Font
import Html exposing (header)
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
import R10.Header
import R10.Language
import R10.Libu exposing (..)
import R10.Mode
import R10.Paragraph
import R10.Svg.Icons
import R10.Svg.IconsExtra
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
    { count : Int, headerOption : R10.Header.Header }


type Msg
    = Increment
    | Decrement
    | HeaderMsg R10.Header.Msg
    | None


init : () -> ( Model, Cmd msg )
init _ =
    ( { count = 1
      , headerOption =
            { sideMenuOpen = True
            , userMenuOpen = True
            , maxWidth = 1000
            , padding = 20
            , supportedLanguageList = [ R10.Language.EN_US, R10.Language.DE_DE, R10.Language.FR_FR, R10.Language.ES_ES, R10.Language.IT_IT ]
            , urlLogin = ""
            , urlLogout = ""
            , session = R10.Header.SessionNotRequired
            , debuggingMode = True
            , backgroundColor = Nothing
            }
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        HeaderMsg headerMsg ->
            case headerMsg of
                R10.Header.ToggleSideMenu ->
                    let
                        _ =
                            Debug.log "ToggleSideMenu" model.count

                        headerOpt =
                            R10.Header.update
                                R10.Header.ToggleSideMenu
                            <|
                                model.headerOption
                    in
                    ( { model | headerOption = headerOpt }
                    , Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )

        Increment ->
            -- let
            --     _ =
            --         Debug.log "Increment" model.count
            -- in
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- ToggleSideMenu ->
--     let
--         -- send ToggleSideMenu
--         newModel =
--             { model
--                 | count = model.count + 1
--             }
--     in
--     ( model, Cmd.none )


view : Model -> Html.Html Msg
view model =
    layout R10.Context.default [ R10.Color.AttrsBackground.background, padding 20, R10.FontSize.normal ] <|
        row [ htmlAttribute (Html.Attributes.style "border" "1px solid blue"), htmlAttribute (Html.Attributes.style "width" "100%") ]
            [ R10.Header.view
                model.headerOption
              <|
                { extraContent = []
                , extraContentRightSide = []
                , from = "R10"
                , msgMapper = HeaderMsg
                , isTop = True
                , isMobile = False
                , onClick = \_ -> None
                , urlTop = ""
                , languageSystem = R10.Header.LanguageInModel
                , logoOnDark =
                    R10.Button.primary []
                        { label = text "+"
                        , libu = R10.Libu.Bu (Just Increment)
                        , -- , libu = R10.Libu.Li "https://r10.netlify.app",
                          -- , theme =
                          --     { mode = R10.Mode.Light
                          --     , primaryColor = R10.Color.primary.crimsonRed ,
                          --     }
                          translation = { key = "example" }
                        }
                , logoOnLight =
                    R10.Button.primary []
                        { label = text "-"
                        , libu = R10.Libu.Bu (Just Decrement)
                        , -- , libu = R10.Libu.Li "https://r10.netlify.app",
                          -- , theme =
                          --     { mode = R10.Mode.Light
                          --     , primaryColor = R10.Color.primary.crimsonRed ,
                          --     }
                          translation = { key = "example" }
                        }
                , darkHeader = True
                , theme =
                    { mode = R10.Mode.Light
                    , primaryColor = R10.Color.primary.blueSky
                    }
                }
            , text (String.fromInt model.count)
            , column
                (R10.Card.high
                    ++ [ centerX
                       , centerY
                       , width (fill |> maximum 460)
                       , height shrink
                       , spacing 30
                       , R10.Color.AttrsBackground.surface2dp
                       , Element.WithContext.Events.onClick Increment

                       --    , Element.WithContext.Events.onClick (HeaderMsg R10.Header.ToggleSideMenu)
                       ]
                )
                [ withContext <| \c -> R10.Svg.LogosExtra.r10 [ centerX ] (R10.Color.Svg.logo c.contextR10.theme) 32

                -- , map MsgForm <|
                --     R10.Button.primary []
                --         { label = text "Submit"
                --         , libu = R10.Libu.Bu <| Just <| R10.Form.msg.submit model.form.conf
                --         , translation = { key = "example" }
                --         }
                ]
            ,el
                [ Element.WithContext.Events.onClick Increment ]
                (withContext <| \c -> R10.Svg.LogosExtra.r10 [ centerX ] (R10.Color.Svg.logo c.contextR10.theme) 32)

                -- , map MsgForm <|
                --     R10.Button.primary []
                --         { label = text "Submit"
                --         , libu = R10.Libu.Bu <| Just <| R10.Form.msg.submit model.form.conf
                --         , translation = { key = "example" }
                --         }
            ]



--         { extraContent : List (Element (R10.Context.ContextInternal z) msg)
-- , extraContentRightSide : List (Element (R10.Context.ContextInternal z) msg)
-- , from : String
-- , msgMapper : Msg -> msg
-- , isTop : Bool
-- , isMobile : Bool
-- , onClick : String -> msg
-- , urlTop : String
-- , languageSystem : LanguageSystem route
-- , logoOnDark : Element (R10.Context.ContextInternal z) msg
-- , logoOnLight : Element (R10.Context.ContextInternal z) msg
-- , darkHeader : Bool
-- , theme : R10.Theme.Theme
-- }
