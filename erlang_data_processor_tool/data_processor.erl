-module(data_processor).
-export([init/0, filter_scores/2, transform_data/1, calculate_average/1]).

-define(DEFAULT_THRESHOLD, 80).

%% @doc Initialize the data processor state.
%% In a real-world scenario, this might start a GenServer or process dictionary.
init() ->
    % Here we simply return ok. In a full application, we might start a GenServer
    % to hold state or register a name for the process.
    ok.

%% @doc Filter data list based on a score threshold.
%% @param Data List of maps containing 'score' key.
%% @param Threshold Numeric threshold.
%% @returns List of maps where score >= threshold.
filter_scores(Data, Threshold) ->
    lists:filter(
        fun(Map) ->
            Score = maps:get(score, Map, 0),
            Score >= Threshold
        end,
        Data
    ).

%% @doc Transform data: convert names to uppercase and double scores.
%% @param Data List of maps containing 'name' and 'score' keys.
%% @returns List of transformed maps.
transform_data(Data) ->
    lists:map(
        fun(Map) ->
            Name = maps:get(name, Map, "Unknown"),
            Score = maps:get(score, Map, 0),
            Map#{
                name := string:uppercase(Name),
                score := Score * 2
            }
        end,
        Data
    ).

%% @doc Calculate the average score of the provided data list.
%% @param Data List of maps containing 'score' key.
%% @returns Float average of scores, or 0 if list is empty.
calculate_average(Data) ->
    case Data of
        [] ->
            0.0;
        _ ->
            Total = lists:sum(
                lists:map(
                    fun(Map) -> maps:get(score, Map, 0) end,
                    Data
                )
            ),
            Count = length(Data),
            Total / Count
    end.
