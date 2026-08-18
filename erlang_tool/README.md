# erlang_tool

This tool implements a fault-tolerant distributed task scheduler with hot code reloading capabilities using Erlang.

## Features
- Distributed node communication and task distribution
- Supervisor tree for fault tolerance
- Hot code reloading support
- Real-time task monitoring and logging

## Usage
Compile the code using `rebar3 compile` or `erlc *.erl` and run with `erl -name scheduler@127.0.0.1`.
