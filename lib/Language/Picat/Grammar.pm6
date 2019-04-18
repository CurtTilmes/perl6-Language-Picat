# use Grammar::Debugger;
# no precompilation;
grammar Language::Picat::Grammar
  {
  token period { '.' }
  token comma { ',' }

  token module-name
    {
    \w+
    }
  token function-name
    {
    \w+
    }
  token variable-name
    {
    \w+
    }

  rule import-declaration
    {
    'import' <module-name> <period>
    }
  token comment
    {
    | '/*' .*? '*/' \s*
    | '%' .*? $$ \s*
    }

  rule function-definition
    {
    <function-name> '=>'
      <expression>+ %% <comma>
    <period>
    }

  rule array
    {
    '['
    <argument>+ %% <comma>
    ']'
    }

  rule argument
    {
    | <function-call>
    | \w+
    | \d+
    }

  rule function-call
    {
    | <function-name> '(' <argument>+ %% <comma> ')'
    | <function-name>
    }

  rule assignment-expression
    {
    <variable-name> '=' <function-call>
    }

  rule expression
    {
    | <assignment-expression>
    | <function-call>
    }

  rule thingie
    {
    | <comment> <expression> <comment> <comma> <comment> # 1 1 1 1 1
    | <comment> <expression> <comment> <comma>           # 1 1 1 1 0
    | <comment> <expression> <comment>         <comment> # 1 1 1 0 1
    | <comment> <expression> <comment>                   # 1 1 1 0 0
    | <comment> <expression>           <comma> <comment> # 1 1 0 1 1
    | <comment> <expression>           <comma>           # 1 1 0 1 0
    | <comment> <expression>                   <comment> # 1 1 0 0 1
    | <comment> <expression>                             # 1 1 0 0 0
    | <comment>              <comment> <comma> <comment> # 1 0 1 1 1
    | <comment>              <comment> <comma>           # 1 0 1 1 0
    | <comment>              <comment>         <comment> # 1 0 1 0 1
    | <comment>              <comment>                   # 1 0 1 0 0
    | <comment>                        <comma> <comment> # 1 0 0 1 1
    | <comment>                        <comma>           # 1 0 0 1 0
    | <comment>                                <comment> # 1 0 0 0 1
    | <comment>                                          # 1 0 0 0 0
    |           <expression> <comment> <comma> <comment> # 0 1 1 1 1
    |           <expression> <comment> <comma>           # 0 1 1 1 0
    |           <expression> <comment>         <comment> # 0 1 1 0 1
    |           <expression> <comment>                   # 0 1 1 0 0
    |           <expression>           <comma> <comment> # 0 1 0 1 1
    |           <expression>           <comma>           # 0 1 0 1 0
    |           <expression>                   <comment> # 0 1 0 0 1
    |           <expression>                             # 0 1 0 0 0
    |                        <comment> <comma> <comment> # 0 0 1 1 1
    |                        <comment> <comma>           # 0 0 1 1 0
    |                        <comment>         <comment> # 0 0 1 0 1
    |                        <comment>                   # 0 0 1 0 0
    |                                  <comma> <comment> # 0 0 0 1 1
    |                                  <comma>           # 0 0 0 1 0
    |                                          <comment> # 0 0 0 0 1
    |                                                    # 0 0 0 0 0
    }

  rule TOP
    {
    ^ <comment>* <import-declaration>? <program-body> $
    }

  rule program-body
    {
      [
      <comment>+

<function-definition>

<function-definition>

<comment>
<function-call> '=>'
   <thingie>
   'foreach(I in 1..N)' 'Doors[I] := 0' 'end' <comma>
   'foreach(I in 1..N)'
     'foreach(J in I..I..N)'
        'Doors[J] := 1^Doors[J]'
     'end' <comma>
     'if N <= 10 then'
       <thingie>
     'end'
   'end' <comma>
   <thingie>
   <thingie>
   <thingie>
<period>

<function-call> '=>'
   'writeln([I : I in 1..Doors.length, Doors[I] == 1])'
<period>
  
<comment>
<function-call> '=>'
  'foreach(I in 1..N)'
     <thingie>
     'writeln([I, cond(' <variable-name> '== 1.0*' <function-call> ', open, closed)])'
  'end' <comma>
  <thingie>
<period>

<comment>
<function-call> '=>'
  'writeln([I**2 : I in 1..N, I**2 <= N])'
<period>

    ||

<function-definition>

<function-name> '=>'
   <thingie>
   <thingie>
   <thingie>
   <thingie>
   <thingie>
   'write(' <expression> ')' <comma>
   <thingie>
<period>

<function-name> '=>'
   'foreach(Len in 1..15)'
      <thingie>
      'write(' <expression> ')' <comma>
      <thingie>
      <thingie>
      'time(' <variable-name> '=' 'findall(L, $plan(L)))' <comma>
      <thingie>
      'writeln(' <variable-name> '=' 'All.length'')'
   'end'
<period>

<function-name> '=>'
  <thingie>
  <variable-name> '=' 'findall(L,$plan(L))' <comma>
  <thingie>
  'writeln(' <variable-name> '=' 'All.length' ')' <comma>
  <thingie>
<period>

<function-name> '=>'
   <thingie>
   'time(' <function-call> ')' <comma>
   <thingie>
   <thingie>
   'writeln(' <variable-name> '=' 'L.length' ')' <comma>
   'writeln(' <expression> ')' <comma>
   <thingie>
<period>

<function-name> '=>'
   <thingie>
   'time(plan3(Init,L,Cost,[]))' <comma>
   <thingie>
   <thingie>
   'writeln(' <variable-name> '=' 'L.length' ')' <comma>
   'writeln(' <expression> ')' <comma>
   <thingie>
<period>

<comment>+

'index(-)'
<comment>
'initial_state(' <array> ')' <period>
<comment>+

'table'
'legal_move(' <array> ',M,To)' '?=>'
   <thingie>
   <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
   <thingie>
   <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
   <thingie>
  <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
   <thingie>
   <variable-name> '=' <array>
<period>
<comment>
<function-name> '(' <array> ',M,To)' '=>'
  <thingie>
  <variable-name> '=' <array>
<period>
<comment>

<function-call> '=>'
  <variable-name> '=' <array>
<period>

<comment>+
'table'
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <thingie>
  <variable-name> '=' <array> <comma>
  <thingie>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <thingie>
  <variable-name> '=' <array> <comma>
  <expression>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <thingie>
  <variable-name> '=' <array> <comma>
  <thingie>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <thingie>
  <variable-name> '=' <array> <comma>
  <thingie>
<period>
<comment>
<function-name> '(' <array> ',M,To,Cost)' '=>'
  <thingie>
  <variable-name> '=' <array> <comma>
  <thingie>
<period>
<comment>+

      ]
    }
  }
