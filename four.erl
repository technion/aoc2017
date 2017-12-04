-module(four).

-compile([export_all]).

firststar() ->
    % Careful - this reads data as binary
    {ok, Data} = file:read_file("four.txt"),
    Lines = lists:droplast(binary:split(Data, <<"\n">>, [global])),
    WLines = lists:map(fun(X) -> binary:split(X, <<" ">>, [global]) end, Lines),
    SetList = lists:filter(fun(X) -> length(X) ==
            sets:size(sets:from_list(X)) end, WLines),
    length(SetList).

secondstar() ->
    {ok, Data} = file:read_file("four.txt"),
    Lines = lists:droplast(binary:split(Data, <<"\n">>, [global])),
    WLines = lists:map(fun(X) -> binary:split(X, <<" ">>, [global]) end, Lines),
    SetList = lists:filter(fun(X) -> length(X) ==
            sets:size(make_sorted_set(X)) end, WLines),
    length(SetList).

bin_to_sorted_list(Bin) ->
    lists:sort(
            erlang:binary_to_list(Bin)).

make_sorted_set(Bin) ->
    sets:from_list( [ bin_to_sorted_list(X) || X <- Bin ] ).
