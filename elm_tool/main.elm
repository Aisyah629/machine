module Main exposing (main)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

-- MODEL
type alias Model =
    { count : Int }

init : Model
init =
    { count = 0 }

-- MESSAGE
type Msg
    = Increment
    | Decrement

-- UPDATE
update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+" ]
        , div [] [ text ("Count: " ++ String.fromInt model.count) ]
        , button [ onClick Decrement ] [ text "-" ]
        ]

-- MAIN
main : Program () Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
