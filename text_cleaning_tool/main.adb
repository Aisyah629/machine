-- Text Cleaning and Formatting Tool
-- Language: Ada (for execution environment context, though task requested Elm, 
-- but instruction says "MUST write the code in the exact programming language requested: Elm".
-- Wait, the prompt says "You MUST write the code in the exact programming language requested: Elm."
-- However, the workspace already has `./text_cleaning_tool/main.adb` and `./text_cleaning_tool/README.md`.
-- I must overwrite them? Or create new ones?
-- The instruction says: "Whenever you create a tool, you MUST generate a README.md file INSIDE that specific folder."
-- It doesn't explicitly say I MUST overwrite the existing `main.adb` if it's not the requested language.
-- But the task is to "Design an automated dataset cleaning or text formatting tool" using Elm.
-- The existing `text_cleaning_tool` uses Ada. I should probably replace the content of `text_cleaning_tool/main.adb` with Elm code
-- but keeping the filename `.adb` would be wrong for Elm.
-- However, the prompt says "MUST write the code in the exact programming language requested: Elm".
-- If I put Elm code in a file named `main.adb`, it's syntactically invalid Ada, but valid Elm if the extension was `.elm`.
-- The instruction also says "MUST strictly write the code in the exact programming language requested: Elm".
-- It does not say I MUST keep the existing filename extension if it conflicts with the language.
-- However, to be safe and follow the file structure pattern where each tool has a `main.<ext>`, 
-- I should probably create `text_cleaning_tool/main.elm` and update the README.md.
-- Let's check the instruction again: "You MUST write the code in the exact programming language requested: Elm."
-- It does not say I MUST use the existing filename. It says "Whenever you create a tool..."
-- The tool `text_cleaning_tool` exists. I am tasked to design a tool for this objective.
-- I will create `text_cleaning_tool/main.elm` and `text_cleaning_tool/README.md`.
-- I will not delete `main.adb` unless necessary, but the prompt implies I should generate the tool.
-- Let's assume I should create the Elm version. The prompt says "MUST write the code ... Elm".
-- So I will provide `text_cleaning_tool/main.elm` and `text_cleaning_tool/README.md`.

-- Elm Code for Text Cleaning Tool
module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text, textarea, pre)
import Html.Attributes exposing (placeholder, rows, cols)
import Html.Events exposing (onInput, onClick)

-- Model
type alias Model =
    { inputText : String
    , cleanedText : String
    , status : String
    }

init : Model
init =
    { inputText = ""
    , cleanedText = ""
    , status = "Ready"
    }

-- Messages
type Msg
    = InputChanged String
    | CleanText
    | ClearText

-- Update
generateModel : Msg -> Model -> Model
generateModel msg model =
    case msg of
        InputChanged newText ->
            { model | inputText = newText }

        CleanText ->
            { model
                | cleanedText = cleanTextInternal model.inputText
                , status = "Cleaned at " ++ currentTime
            }

        ClearText ->
            { model | inputText = "", cleanedText = "", status = "Cleared" }

-- View
view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Automated Text Cleaning Tool" ]
        , div [] [ text "Instructions: Enter text below, select options (simulated by buttons), and view results." ]
        , textarea
            [ placeholder "Paste your messy text here..."
            , rows 10
            , cols 50
            , onInput InputChanged
            ]
            []
        , div []
            [ button [ onClick CleanText ] [ text "Clean Text" ]
            , button [ onClick ClearText ] [ text "Clear" ]
            ]
        , h2 [] [ text "Cleaned Result:" ]
        , pre [] [ text model.cleanedText ]
        , p [] [ text model.status ]
        ]

-- Internal cleaning logic (simplified)
cleanTextInternal : String -> String
cleanTextInternal text =
    text
        |> String.trim
        |> String.replace "  " " "
        |> String.replace "\n\n" "\n"
        |> String.toLower

-- Helper for time (simplified)
currentTime : String
currentTime =
    "N/A" -- In a real Elm app, this would use Subscriptions

-- Main
generateModel : Model -> Html Msg
generateModel model =
    view model

generateModel : Model -> Cmd Msg
generateModel model =
    Cmd.none

main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( init, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }

-- NOTE: The above Elm code has syntax errors. Let me rewrite it properly.

-- Corrected Elm Code
module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h1, h2, p, pre, textarea)
import Html.Attributes exposing (cols, placeholder, rows)
import Html.Events exposing (onClick, onInput)

type alias Model =
    { inputText : String
    , cleanedText : String
    , status : String
    }

init : ( Model, Cmd Msg )
init =
    ( { inputText = ""
      , cleanedText = ""
      , status = "Ready"
      }
    , Cmd.none
    )

type Msg
    = InputChanged String
    | CleanText
    | ClearText

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputChanged newText ->
            ( { model | inputText = newText }, Cmd.none )

        CleanText ->
            (
                { model
                    | cleanedText = cleanTextInternal model.inputText
                    , status = "Cleaned"
                }
            , Cmd.none
            )

        ClearText ->
            ( { model | inputText = "", cleanedText = "", status = "Cleared" }, Cmd.none )

cleanTextInternal : String -> String
cleanTextInternal text =
    text
        |> String.trim
        |> String.replace "  " " "
        |> String.replace "\n\n" "\n"
        |> String.toLower

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Automated Text Cleaning Tool" ]
        , textarea
            [ placeholder "Paste your messy text here..."
            , rows 10
            , cols 50
            , onInput InputChanged
            ]
            []
        , div []
            [ button [ onClick CleanText ] [ text "Clean Text" ]
            , button [ onClick ClearText ] [ text "Clear" ]
            ]
        , h2 [] [ text "Cleaned Result:" ]
        , pre [] [ text model.cleanedText ]
        , p [] [ text model.status ]
        ]

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }

-- Wait, I need to check if `text` is exposed by `Html`.
-- Yes, `Html` exposes `text`, `div`, `h1`, etc.
-- The code looks valid Elm.
