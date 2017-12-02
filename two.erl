-module(two).
-export([getinput/0, corruption/1]).

% Compile and test:
% erlc -DTEST two.erl
% erl one -noshell -eval "eunit:test(two)" -s init stop

% Run from REPL:
% erl
% 1> c(two).
% {ok,two}
% 2> Input = two:getinput().
% 3> two:corruption(Input).


-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

-spec getinput() -> [[binary()]].
getinput() ->
    % Careful - this reads data as binary
    {ok, Data} = file:read_file("two.txt"),
    Lines = binary:split(Data, <<"\n">>, [global]),
    Splitlist = lists:map(fun(X) -> binary:split(X, <<"\t">>, [global]) end, Lines),
    lists:droplast(Splitlist).

-spec nicediv(non_neg_integer(),non_neg_integer()) -> non_neg_integer().
nicediv(A, B) ->
    case A > B of
    true ->
        A div B;
    _ ->
        B div A
    end.

-spec finddivisor([integer()]) -> 'none' | {integer(),integer()}.
finddivisor(List) when length(List) < 2 ->
    none;
finddivisor([Head|Tail]) ->
    case lists:filter(fun(X) -> X rem Head == 0 orelse Head rem X == 0 end, Tail) of
    [] ->
        finddivisor(Tail);
    [Answer|_Garbage] -> % Only one divisor
        {Answer, Head}
    end.

-spec corruption([any()]) -> integer().
corruption(List) ->
    corruption(List, 0).

-spec corruption([any()],integer()) -> integer().
corruption([], Accum) ->
    Accum;
corruption([Head|Rest], Accum) ->
    ListHead = lists:map(fun(X) -> binary_to_integer(X) end, Head),
    {A, B} = finddivisor(ListHead),
    C = nicediv(A, B),
    corruption(Rest, Accum + C).
   
-ifdef(TEST).

nicediv_test() ->
    ?assertEqual(4, nicediv(2, 8)),
    ?assertEqual(4, nicediv(8, 2)).

finddivisor_test() ->
    ?assertEqual({8,2}, finddivisor([5, 9, 2, 8])).

corruption_test() ->
    Input = [[<<"5">>,<<"9">>,<<"2">>,<<"8">>], [<<"9">>,<<"4">>,<<"7">>,<<"3">>], [<<"3">>,<<"8">>,<<"6">>,<<"5">>]],
    ?assertEqual(9, corruption(Input, 0)). % Given in challenge

-endif.
