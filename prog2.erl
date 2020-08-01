-module(prog2).
-export([solve/0, solve_2/0]).
-import(lists,[nthtail/2, nth/2]).

-define(Input, [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,19,6,23,
                1,23,6,27,1,13,27,31,2,13,31,35,1,5,35,39,2,39,13,43,
                1,10,43,47,2,13,47,51,1,6,51,55,2,55,13,59,1,59,10,
                63,1,63,10,67,2,10,67,71,1,6,71,75,1,10,75,79,1,79,
                9,83,2,83,6,87,2,87,9,91,1,5,91,95,1,6,95,99,1,99,9,
                103,2,10,103,107,1,107,6,111,2,9,111,115,1,5,115,119,
                1,10,119,123,1,2,123,127,1,127,6,0,99,2,14,0,0]).

solve() ->
    Input = [nth(1, ?Input), 12, 2 | nthtail(3, ?Input)],
    [H|_] = solve(Input),
    12490719 = H.

solve(L) -> handle(1, L).

solve_2() ->
    Input = [nth(1, ?Input), 1, 1 | nthtail(3, ?Input)],
    {Noun, Verb} = solve_2(Input, 19690720),
    (100 * Noun) + Verb.

solve_2(L, Target) ->
    [Output|_] = solve(L),
    [OpCode, Noun, Verb | T] = L,
    LoopSize = length(L) - 1,
    if
        Output == Target -> {Noun, Verb};
        Verb rem LoopSize /= 0 -> solve_2([OpCode, Noun, Verb+1 | T], Target);
        Verb rem LoopSize == 0 -> solve_2([OpCode, Noun+1, 1 | T], Target)
    end.


-record(instruction, {
     opCode,
     xIndex,
     yIndex,
     outPos
    }
  ).

handle(Index, Integers) ->
    Size=4,
    [OpCode, XIndex, YIndex, OutPos] = lists:sublist(Integers, Index, Size),
    Instruction = #instruction{opCode=OpCode, xIndex=XIndex, yIndex=YIndex, outPos=OutPos},
    handle_opcode(Instruction, Integers, Index).


handle_opcode(#instruction{opCode=99}, Integers, _) -> Integers;
handle_opcode(#instruction{opCode=1} = Instruction, Integers, Index) -> handle_opcode(Instruction, Integers, Index, add);
handle_opcode(#instruction{opCode=2} = Instruction, Integers, Index) -> handle_opcode(Instruction, Integers, Index, mult).

handle_opcode(Instruction, Integers, Index, Operation) ->
    X = lists:nth(Instruction#instruction.xIndex + 1, Integers),
    Y = lists:nth(Instruction#instruction.yIndex + 1, Integers),
    NumToUpdate = get_num_to_update(X, Y, Operation),
    NewIntegers=lists:sublist(Integers, Instruction#instruction.outPos) ++
    [NumToUpdate] ++
    lists:nthtail(Instruction#instruction.outPos + 1, Integers),
    handle(Index + 4, NewIntegers).

get_num_to_update(X, Y, add) -> X + Y;
get_num_to_update(X, Y, mult) -> X * Y.
