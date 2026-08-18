module Main exposing (main)

import Browser
import Element exposing (Text(..), center, column, row, text)
import Element.Input
import Json.Decode as D
import Json.Decode.Parsing as DP


-- TYPE DEFINITIONS

type alias JsonData =
    { title : String
    , items : List String
    }

type ComponentState
    = Idle
    | Loading
    | Rendered ComponentData

type alias ComponentData =
    { id : String
    , label : String
    , visible : Bool
    }

type Msg
    = LoadData JsonData
    | ToggleComponent String
    | ResetComponent
    | UpdateVisibility ComponentData


-- MODEL

type alias Model =
    { data : Maybe JsonData
    , components : List ComponentData
    , state : ComponentState
    }

initialModel : Model
initialModel =
    { data = Nothing
    , components = []
    , state = Idle
    }


-- UPDATE

update : Msg -> Model -> Model
update msg model =
    case msg of
        LoadData jsonData ->
            let
                newComponents =
                    jsonData.items
                        |> List.indexedMap (\idx item -> { id = String.fromInt idx, label = item, visible = True })
            in
            { model
                | data = Just jsonData
                , components = newComponents
                , state = Rendered { id = "init", label = "Ready", visible = True }
            }

        ToggleComponent compId ->
            let
                updatedComponents =
                    List.map (\c ->
                        if c.id == compId then
                            { c | visible = not c.visible }
                        else
                            c
                    ) model.components
            in
            { model | components = updatedComponents }

        ResetComponent ->
            { model
                | data = Nothing
                , components = []
                , state = Idle
            }

        UpdateVisibility newComp ->
            let
                updatedComponents =
                    List.map (\c ->
                        if c.id == newComp.id then
                            newComp
                        else
                            c
                    ) model.components
            in
            { model | components = updatedComponents }


-- VIEW

view : Model -> Browser.Document Msg
view model =
    { title = "Elm UI Component Generator"
    , body =
        [ case model.state of
            Idle ->
                column [ center ]
                    [ text "No data loaded. Use the LoadData command to start."
                    , Element.Input.button [ Element.Input.onUpdate (always ResetComponent) ] [] text "Reset"
                    ]

            Loading ->
                column [ center ] [ text "Loading data..." ]

            Rendered _ ->
                column [ center ]
                    [ model.data
                        |> Maybe.map (\d -> text d.title |> Element.width (Element.px 400))
                        |> Maybe.withDefault (text "")
                    , row [] (model.components |> List.map renderComponent)
                    , Element.Input.button [ Element.Input.onUpdate (always ResetComponent) ] [] text "Reset Generator"
                    ]
        ]
    }

renderComponent : ComponentData -> Element Element.EventMsg
renderComponent comp =
    row [ Element.spacer ]
        [ text comp.label
        , Element.Input.button
            [ Element.Input.onUpdate (ToggleComponent comp.id)
            , if comp.visible then
                Element.css [ Element.Border.color Element.red, Element.Border.width 2 ]
              else
                Element.css []
            ]
            []
            (if comp.visible then text "Hide" else text "Show")
        ]


-- PROGRAM

main : Program () Model Msg
main =
    Browser.application
        { init = ( initialModel, LoadData { title = "Test Component", items = [ "Item 1", "Item 2", "Item 3" ] } )
        , update = update
        , view = view
        , subscriptions = always Sub.none
        , onUrlRequest = always (\_ -> Cmd.none)
        , onUrlChange = always (\_ -> Cmd.none)
        }
