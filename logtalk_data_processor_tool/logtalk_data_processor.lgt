% ==============================================================================
% Logtalk Data Processor Tool
% ==============================================================================
% This module implements a high-level data processing engine utilizing Logtalk's
% logical programming capabilities, object-oriented meta-programming, and
% higher-order predicates.
% ==============================================================================

:- module(logtalk_data_processor).

% ==============================================================================
% Imports
% ==============================================================================

:- object(logtalk_data_processor,
    extends(list_util)).

    % --------------------------------------------------------------------------
    % Exported Interface
    % --------------------------------------------------------------------------
    :- public([
        process_data/2,
        filter_records/3,
        transform_records/3,
        sort_records/3,
        aggregate_data/3
    ]).
    :- mode(process_data(+list, -list), one).
    :- mode(filter_records(+list, +predicate, -list), one).
    :- mode(transform_records(+list, +predicate, -list), one).
    :- mode(sort_records(+list, +comparator, -list), one).
    :- mode(aggregate_data(+list, +aggregate_type, -result), one).

    % --------------------------------------------------------------------------
    % Initialization
    % --------------------------------------------------------------------------
    :- initialization(
        write('Logtalk Data Processor Tool Initialized.'), nl
    ).

    % =============================================================================
    % Core Processing Engine
    % =============================================================================

    %% process_data(+Records:list, -ProcessedData:list) is det.
    %
    % Main entry point for the data processing pipeline.
    % Applies validation, normalization, and basic transformation.
    %
    % @param Records   Input list of records (prologs or terms).
    % @param ProcessedData Output list of processed records.
    
    process_data(Records, ProcessedData) :-
        log:filter_truthy(Records, ValidRecords),
        normalize_records(ValidRecords, NormalizedRecords),
        transform_records(NormalizedRecords, standard_transform, ProcessedData).

    %% normalize_records(+Records:list, -Normalized:list) is det.
    %
    % Ensures all records follow a standard structure (e.g., dict or property list).
    % Converts tuples to property lists if necessary.
    
    normalize_records(Input, Output) :-
        maplist(normalize_record, Input, Output).

    normalize_record(Term, Dict) :-
        (   dict(Term) ->
            Dict = Term
        ;   is_list(Term) ->
            term_to_dict(Term, Dict)
        ;   Dict = dict(id=Term, type=unknown)
        ).

    %% standard_transform(+Record:term, -Transformed:term) is det.
    %
    % A default transformation predicate used by transform_records.
    % Adds metadata fields to the record.
    %
    standard_transform(Record, Transformed) :-
        get_time(CurrentTime),
        dict_create(Record, Dict0),
        Dict1 = Dict0.put(timestamp, CurrentTime),
        Dict2 = Dict1.put(processed_by, 'logtalk_data_processor'),
        Transformed = Dict2.

    % =============================================================================
    % Filtering Utilities
    % =============================================================================

    %% filter_records(+Records:list, +Predicate:callable, -Filtered:list) is det.
    %
    % Filters a list of records based on a dynamic predicate or lambda.
    %
    % @param Records     Input list.
    % @param Predicate   A callable predicate of arity 1.
    % @param Filtered    List of records satisfying the predicate.
    
    filter_records(Records, Predicate, Filtered) :-
        findall(Record,
            (   member(Record, Records),
                call(Predicate, Record)
            ),
            Filtered
        ).

    % =============================================================================
    % Transformation Utilities
    % =============================================================================

    %% transform_records(+Records:list, +Transform:callable, -Transformed:list) is det.
    %
    % Applies a transformation function to each record in the list.
    %
    % @param Records     Input list.
    % @param Transform   A callable predicate of arity 2 (Input, Output).
    % @param Transformed Output list.
    
    transform_records(Records, Transform, Transformed) :-
        maplist(Transform, Records, Transformed).

    % =============================================================================
    % Sorting Utilities
    % =============================================================================

    %% sort_records(+Records:list, +Comparator:callable, -Sorted:list) is det.
    %
    % Sorts records based on a custom comparator.
    % The comparator should unify two terms to determine order or fail.
    %
    % @param Records  Input list.
    % @param Comparator Callable predicate taking two arguments.
    % @param Sorted   Sorted output list.
    
    sort_records(Records, Comparator, Sorted) :-
        sort(2, Comparator, Records, Sorted).

    % =============================================================================
    % Aggregation Utilities
    % =============================================================================

    %% aggregate_data(+Records:list, +Type:atom, -Result:term) is det.
    %
    % Computes an aggregate value over the list.
    % Supported types: count, sum, average.
    % Assumes records are numeric or have a 'value' field.
    %
    % @param Records Input list.
    % @param Type    Aggregation type.
    % @param Result  Result of the aggregation.
    
    aggregate_data(Records, count, Count) :-
        length(Records, Count).

    aggregate_data(Records, sum, Sum) :-
        findall(Value,
            (   member(Record, Records),
                (   get_dict(value, Record, Value)
                ;   float(Record) -> Value = Record
                ;   integer(Record) -> Value = Record
                ;   Value = 0
                ),
                nonvar(Value)
            ),
            Values
        ),
        sum_list(Values, Sum).

    aggregate_data(Records, average, Average) :-
        aggregate_data(Records, sum, Sum),
        aggregate_data(Records, count, Count),
        (   Count > 0 ->
            Average is Sum / Count
        ;   Average = 0
        ).

    % =============================================================================
    % Helper Predicates
    % =============================================================================

    %% term_to_dict(+Term:term, -Dict:dict) is det.
    %
    % Converts a property list or tuple-like structure into a dict.
    % Used for normalization.
    
    term_to_dict(PropertyList, Dict) :-
        is_list(PropertyList),
        maplist(key_value, PropertyList, Dict).

    key_value(Key=Value, Dict).

:- end_object.
