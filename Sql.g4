
grammar Sql;

//tokeny
WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines

Id: [a-zA-Z] [a-zA-Z0-9_]*;
Liczba: [0-9]+ ('.' [0-9]+)?;

Select: 'Select';
From: 'From';
Where: 'Where';
And: 'And';
Or: 'Or';
In: 'In';
Not: 'Not';
Order: 'Order';
By: 'By';
Descending: 'Descending';
Update: 'Update';
Set: 'Set';
Delete: 'Delete';
Like: 'Like';
Join: 'Join';
Inner: 'Inner';
Outer: 'Outer';
Left: 'Left';
Right: 'Right';
Full: 'Full';

//Operacje
Plus: '+';
Minus: '-';
Star: '*';
Divide: '/';

//Porównania
Equals: '=';
Lesser: '<';
Greater: '>';
Greater_Equal: '>=';
Leser_Equal: '<⇐';
Not_Equal: '<>';




BracketL: '(';
BracketR: ')';
SColon: ';';
Coma: ',';
String: ('"' .*? '"' | '\'' .*? '\''); // Non-greedy -> .*? dopasowuje wszystko do następnego " lub '    https://github.com/antlr/antlr4/blob/master/doc/wildcard.md

//Start - token Startowy



//Produkcje


r
    : (select | update | delete) SColon
    ;
select
    : Select columns From table whereStatement? (Order By Id Descending? )?
    ;
update
    : Update Id Set columnsSetEq whereStatement?
    ;
delete
    : Delete From Id whereStatement?
    ;
columns
    : Star
    | Id (Coma Id)*
    ;
table
    : Id (join Id)*
    ;
join
    : (Inner | Outer | Left | Right | Full)? Join
    ;
condition
    : BracketL condition BracketR
    | condition operatorL condition
    | var
    ;
var
    : formula
    | String
    ;
formula
    : BracketL formula BracketR
    | formula operatorM formula
    | Liczba
    | Id
    ;
columnsSetEq
    : Id Equals var (Coma Id Equals var)*
    ;
whereStatement
    : Where (condition | Id Like var)
    ;
operatorL
    : And | In |Not | Or
    ;
operatorM
    :Equals | Leser_Equal | Lesser | Greater | Greater_Equal | Not_Equal
    ;



















