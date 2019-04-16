# use Grammar::Tracer;
# no precompilation;
grammar Language::Picat::Grammar
  {
  token module-name
    {
    \w+
    }
  token function-name
    {
    \w+
    }

  rule import-declaration
    {
    'import' <module-name> '.'
    }
  token comment
    {
    | '/*' .*? '*/' \s*
    | '%' .*? $$ \s*
    }

  rule function-definition
    {
    <function-name> '=>'
      <statement>
    '.'
    }

  token argument
    {
    \d+
    }

  rule function-call
    {
    | <function-name> '(' <argument> ')'
    | <function-name>
    }

  rule statement
    {
    | <function-call>
    | <comment>
    }

  rule TOP
    {
    ^ <comment>* <import-declaration>? <program-body> $
    }

  rule program-body
    {
      [
      <statement>+

<function-definition>

<function-name> '=>'
   <statement> ','
   <statement> ','
   <statement> ','
   <statement> ','
   <statement> '.'

<statement>
<function-name> '(N)' '=>'
   'Doors = new_array(N)' ','
   'foreach(I in 1..N)' 'Doors[I] := 0' 'end' ','
   'foreach(I in 1..N)'
     'foreach(J in I..I..N)'
        'Doors[J] := 1^Doors[J]'
     'end' ','
     'if N <= 10 then'
        'print_open(Doors)'
     'end'
   'end' ','
   'writeln(Doors)' ','
   'print_open(Doors)' ','
   <statement> '.'

<function-name> '(Doors) => writeln([I : I in 1..Doors.length, Doors[I] == 1])' '.'
  
<statement>
<function-name> '(N)' '=>'
  'foreach(I in 1..N)'
     'Root = sqrt(I)' ','
     'writeln([I, cond(Root == 1.0*round(Root), open, closed)])'
  'end' ','
  <statement> '.'

<statement>
<function-name> '(N)' '=>'
  'writeln([I**2 : I in 1..N, I**2 <= N])' '.'

    ||

<function-definition>

<function-name> '=>'
   <statement>
   'time(bplan(L))' ','
   'write(L)' ',' <statement> ','
   'Len=length(L)' ','
   'write(len=Len)' ',' <statement> '.'

<function-name> '=>'
   'foreach(Len in 1..15)'
      <statement> ','
      'write(len=Len),' <statement> ','
      'L = new_list(Len)' ','
      'time(All=findall(L, $plan(L)))' ','
      <statement>
      'writeln(all_len=All.length)'
   'end' '.'

<function-name> '=>'
  'L =' <function-call> ','
  'All=findall(L,$plan(L))' ','
  'writeln(All)' ','
  'writeln(len=All.length)' ','
  <statement> '.'

<function-name> '=>'
   'initial_state(Init)' ','
   'time(plan2(Init,L,Cost))' ','
   'write(L)' ',' <statement> ','
   'writeln(len=L.length)' ','
   'writeln(cost=Cost)' ','
   <statement> '.'

<function-name> '=>'
   'initial_state(Init)' ','
   'time(plan3(Init,L,Cost,[]))' ','
   'write(L)' ',' <statement> ','
   'writeln(len=L.length)' ','
   'writeln(cost=Cost)' ','
   <statement> '.'

<statement>+

'index(-)'
<statement>
'initial_state([2,4,1,7,5,3,8,6])' '.' <statement>+

'table'
'legal_move([M4,M3,M2,M1,M5,M6,M7,M8],M,To)' '?=>' 'M=1,To=[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
'legal_move([M1,M5,M4,M3,M2,M6,M7,M8],M,To)' '?=>' 'M=2,To=[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
'legal_move([M1,M2,M6,M5,M4,M3,M7,M8],M,To)' '?=>' 'M=3,To=[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
'legal_move([M1,M2,M3,M7,M6,M5,M4,M8],M,To)' '?=>' 'M=4,To=[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
<function-name> '([M1,M2,M3,M4,M8,M7,M6,M5],M,To)' '=>' 'M=5,To=[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>

<function-name> '(Goal)' '=>' 'Goal = [1,2,3,4,5,6,7,8]' '.'

<statement>+
'table'
'legal_move([M4,M3,M2,M1,M5,M6,M7,M8],M,To,Cost)' '?=>' 'M=1,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1' '.' <statement>
'legal_move([M1,M5,M4,M3,M2,M6,M7,M8],M,To,Cost)' '?=>' 'M=2,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1' '.' <statement>
'legal_move([M1,M2,M6,M5,M4,M3,M7,M8],M,To,Cost)' '?=>' 'M=3,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1' '.' <statement>
'legal_move([M1,M2,M3,M7,M6,M5,M4,M8],M,To,Cost)' '?=>' 'M=4,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1' '.' <statement>
<function-name> '([M1,M2,M3,M4,M8,M7,M6,M5],M,To,Cost)' '=>' 'M=5,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1' '.' <statement>

<statement>+

      ]
    }
  }
