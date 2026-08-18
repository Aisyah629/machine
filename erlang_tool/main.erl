%% main.erl
-module(main).
-behaviour(gen_server).

%% API
-export([start_link/0, submit_task/1, get_status/0, reload_code/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {
    task_queue = [],
    running_tasks = [],
    workers = [],
    supervisor_pid
}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

submit_task(Task) ->
    gen_server:call(?MODULE, {submit, Task}).

get_status() ->
    gen_server:call(?MODULE, status).

reload_code() ->
    gen_server:cast(?MODULE, reload).

init([]) ->
    process_flag(trap_exit, true),
    State = #state{},
    {
        ok,
        State,
        0
    }.

handle_call({submit, Task}, _From, #state{task_queue = Queue} = State) ->
    NewQueue = Queue ++ [Task],
    {
        reply,
        {ok, scheduled},
        State#state{task_queue = NewQueue}
    };

handle_call(status, _From, #state{task_queue = Q, running_tasks = R} = State) ->
    {
        reply,
        {ok, [{queued, length(Q)}, {running, length(R)}]},
        State
    };

handle_call(_Request, _From, State) ->
    {
        reply,
        {error, unknown_request},
        State
    }.

handle_cast(reload, State) ->
    code:purge(main),
    code:load_file(main),
    {
        noreply,
        State
    };

handle_cast(_Msg, State) ->
    {
        noreply,
        State
    }.

handle_info(timeout, State) ->
    %% Process pending tasks here in a real implementation
    {
        noreply,
        State
    };

handle_info(_Info, State) ->
    {
        noreply,
        State
    }.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {
        ok,
        State
    }.
