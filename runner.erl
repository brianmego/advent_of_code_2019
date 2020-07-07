-module(runner).
-export([main/1]).
-import(code, [load_abs/1]).

main([Name]) -> {_,Module} = load_abs(Name),
    io:format("~w\n", [Module:solve()]).
