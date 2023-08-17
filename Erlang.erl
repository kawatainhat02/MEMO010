-module(fact).
 -export([fac/1]).
 
 fac(0) -> 1;
 fac(N) when N > 0 -> N *fac(N-1).

 -module(quicksort).
 -export([qsort/1]).
 
 qsort([]) -> [];
 qsort([Pivot|Rest]) ->
     qsort([ X||X <- Rest, X < Pivot]) ++ [Pivot] ++ qsort([ Y||Y <- Rest, Y >=Pivot]).

 -module(listsort).
 -export([by_length/1]).

 by_length(Lists) ->
     F=fun(A,B) when is_list(A), is_list(B) ->
             length(A) < length(B)
         end,
     qsort(Lists, F).
 
  qsort([], _) -> [];
  qsort([Pivot|Rest], Smaller) ->
      qsort([ X||X <- Rest, Smaller(X, Pivot)], Smaller)
      ++ [Pivot] ++
      qsort([ Y||Y <- Rest, not(Smaller(Y, Pivot))], Smaller).

Pid=spawn(Mod, Func, Args)       % execute function Func as new process
  Pid=spawn(Node, Mod, Func, Args) % execute function Func in remote node Node
 
  Pid ! a_message      % send message to the process (asynchronously)
 
  receive              % receive message sent to this process
    a_message -> do_something;
    {data, Data_content} -> do_something_else();% This is a tuple of a type atom and some data
    {hello, Text} -> io:format("Got hello message:~s", [Text]);
    {goodbye, Text} -> io:format("Got goodbye message:~s", [Text])
  end.
