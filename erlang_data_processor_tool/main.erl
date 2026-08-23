-module(main).
-export([start/0, start/1]).

%% @doc Starts the data processing application.
start() ->
    start([]).

%% @doc Starts the data processing application with options.
start(Args) ->
    io:format("Starting Erlang Data Processor...~n"),
    %% Initialize the data processor
    case data_processor:init() of
        ok ->
            io:format("Data Processor initialized successfully.~n"),
            process_sample_data(),
            io:format("Processing complete.~n");
        {error, Reason} ->
            io:format("Failed to initialize: ~p~n", [Reason])
    end,
    halt(0).

%% @doc Processes a sample dataset for demonstration.
process_sample_data() ->
    SampleData = [
        #{id => 1, name => "Alice", score => 85},
        #{id => 2, name => "Bob", score => 92},
        #{id => 3, name => "Charlie", score => 78},
        #{id => 4, name => "Diana", score => 95}
    ],
    io:format("Original Data: ~p~n", [SampleData]),
    
    %% Filter scores above 80
    FilteredData = data_processor:filter_scores(SampleData, 80),
    io:format("Filtered Data (Score > 80): ~p~n", [FilteredData]),
    
    %% Transform to uppercase names and double scores
    TransformedData = data_processor:transform_data(FilteredData),
    io:format("Transformed Data: ~p~n", [TransformedData]),
    
    %% Calculate average score
    AvgScore = data_processor:calculate_average(FilteredData),
    io:format("Average Score: ~p~n", [AvgScore]).
