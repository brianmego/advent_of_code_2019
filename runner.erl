-module(runner).
-export([main/1]).
-import(code, [load_abs/1]).

main([Name, Part]) ->
    {_,Module} = load_abs(Name),
    run(Module, Part).

run(Module, "1") ->
    io:format("~w\n", [Module:solve()]);

run(Module, "2") ->
    io:format("~w\n", [Module:solve_2()]).
