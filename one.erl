-module(one).

% Compile and test:
% erlc -DTEST one.erl
% erl one -noshell -eval "eunit:test(one)" -s init stop

% Run from REPL:
% erl
% 1> c(one).
% {ok,one}
% one:captcha("82.. ").

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.
-export([captcha/1]).

-spec captcha(unicode:chardata()) -> non_neg_integer().
captcha(Input) ->
    Half = length(Input) div 2,
    {First, Second} = lists:split(Half, Input),
    captcha(First, Second, 0).

-spec captcha(unicode:chardata(), unicode:chardata(), non_neg_integer()) -> non_neg_integer().
captcha([], [], Accum) ->
    Accum;
captcha([Head1|T1], [Head2|T2], Accum) ->
    Head1i = erlang:list_to_integer([Head1]),
    Head2i = erlang:list_to_integer([Head2]),
    Add = Accum + 
    case Head1i =:= Head2i of
        true -> Head1i + Head2i;
        _ -> 0
    end,
    captcha(T1, T2, Add).

-ifdef(TEST).

captcha_test() ->
    ?assert(captcha("1212") =:= 6),
    ?assert(captcha("1221") =:= 0),
    ?assert(captcha("123425") =:= 4),
    ?assert(captcha("123123") =:= 12),
    ?assert(captcha("12131415") =:= 4).

-endif.
