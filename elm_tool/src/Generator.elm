module Generator exposing (parseData, generateComponents, validateJson)

import Json.Decode as D
import Json.Decode.Parsing as DP


-- Parse incoming data structure into typed model
type alias ParsedData =
    { title : String
    , items : List String
    }

parseData : String -> Result String ParsedData
parseData rawJson =
    case D.decodeString dataDecoder rawJson of
        Ok data ->
            Ok data

        Err err ->
            Err (D.errorToString err)


-- Validate structure integrity
type alias ValidationResult =
    { isValid : Bool
    , errors : List String
    }

validateJson : ParsedData -> ValidationResult
validateJson data =
    let
        errors =
            List.filterMap (\check -> check data)
                [ \d -> if String.isEmpty d.title then Just "Title cannot be empty" else Nothing
                , \d -> if List.isEmpty d.items then Just "Items list cannot be empty" else Nothing
                , \d ->
                    case List.head d.items of
                        Just item ->
                            if String.isEmpty item then
                                Just "First item cannot be empty"
                            else
                                Nothing

                        Nothing ->
                            Nothing
                ]
    in
    { isValid = List.isEmpty errors, errors = errors }


-- Generate component configuration from data
generateComponents : ParsedData -> List { id : String, label : String, visible : Bool }
generateComponents data =
    data.items
        |> List.indexedMap (\idx item -> { id = String.fromInt idx, label = item, visible = True })


-- Data Decoders
dataDecoder : D.Decoder ParsedData
dataDecoder =
    D.map2 ParsedData
        (D.field "title" D.string)
        (D.field "items" (D.list D.string))
