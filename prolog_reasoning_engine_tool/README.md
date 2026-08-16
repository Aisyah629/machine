# Prolog Reasoning Engine Tool

## Overview
The Prolog Reasoning Engine Tool is a robust logic programming engine built strictly in Prolog. It is designed for complex rule-based inference, backtracking search, and knowledge graph querying. This tool leverages the declarative nature of Prolog to solve problems defined by facts and rules, making it ideal for artificial intelligence, expert systems, and automated reasoning applications.

## Features
- **Complex Rule-Based Inference**: Define complex relationships and rules to infer new knowledge.
- **Backtracking Search**: Efficiently explore solution spaces using Prolog's built-in backtracking mechanism.
- **Knowledge Graph Querying**: Query and manipulate structured data represented as a knowledge graph.
- **Extensible**: Easily extend the knowledge base and rules to fit specific domain requirements.

## Usage
To use the Prolog Reasoning Engine Tool, place your knowledge base and rules in the `main.pl` file. You can then query the engine by calling predicates defined in the knowledge base.

## Example
% main.pl
facts:-
    parent(john, mary).
    parent(mary, ann).
    parent(john, tom).

rules:-
    grandparent(X, Z) :-
        parent(X, Y),
        parent(Y, Z).

% To query for grandparents, run the following in the Prolog interpreter:
% ?- grandparent(john, X).
% Expected output: X = ann.

## Installation
Ensure you have a Prolog interpreter installed on your system. This tool has been tested with SWI-Prolog.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for any enhancements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
