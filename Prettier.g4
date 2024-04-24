grammar Prettier;

prog: (inline | block)*;

inline: DOLLAR body DOLLAR ;

block: DOLLAR DOLLAR body DOLLAR DOLLAR;

body
    : arithmetic_stat
    ;

// Stat -> combines expr
arithmetic_stat
    : arithmetic_expr (COMPARATOR arithmetic_expr)*;

// Expr -> without comparator
arithmetic_expr 
    : LPAREN arithmetic_expr RPAREN
    | arithmetic_expr operator arithmetic_expr
    | arithmetic_sum 
    | arithmetic_prod
    | arithmetic_limit
    | function
    | power
    | index
    | signed_id_number_infinity
    ;

// TODO - resolve, important
// Very tought to check for lenght of 1, so always use {}
power
    : '{' arithmetic_expr '}^{' arithmetic_expr '}'
    ;

index
    : '{' arithmetic_expr '}_{' NUMBER '}'
    ;

// Kind of arithmetic_expr
arithmetic_sum
    : SUM'_{'arithmetic_stat'}^{'signed_id_number_infinity'}' arithmetic_expr
    ;

// Kind of arithmetic_expr
arithmetic_prod
    : PROD'_{'arithmetic_stat'}^{'signed_id_number_infinity'}' arithmetic_expr
    ;

arithmetic_limit
    : LIM '_{' ID '\\to' signed_id_number_infinity '}' arithmetic_expr
    ;

function
    : ID LPAREN arithmetic_expr RPAREN
    ;


signed_id_number_infinity
    : '-'? (ID | NUMBER | INFINITY)
    ;

// positive_id_number_infinity
//     : ID | NUMBER | INFINITY
//     ;

// negative_id_number_infinity
//     : '-'(ID | NUMBER | INFINITY)
//     ;

signed_id_number
    : '-'? (ID | NUMBER)
    ;

// positive_id_number
//     : ID | NUMBER
//     ;

// negative_id_number
//     : '-'(ID | NUMBER)
//     ;

operator : PLUS | MIN | MULT | DIV;



// Arithmetic
COMPARATOR: '=' | '\\neq' | '\\pm' | '\\mp' | '\\geq' | '\\leq' | '>' | '<' | '\\approx';
PLUS : '+' ;
MIN : '-' ;
MULT : '*' | '\\cdot' | '\\times' ;
DIV : '/' | '\\div' ;
LPAREN: '(';
RPAREN: ')';
SUM: '\\sum';
PROD: '\\prod';
LIM: '\\lim';

// Sets
BIGCUP: '\\bigcup'; // Union of multiple
CUP: '\\cup';       // Union of two
BIGCAP: '\\bigcap'; // Intersection of multiple
CAP: '\\cap';       // Intersection of two
SET_OPERATOR: '\\in' | '\\ni' | '\\notin' | '\\notni';
SUBSET: '\\subset' | '\\subseteq' | '\\nsubseteq';
SUPSET: '\\supset' | '\\supseteq' | '\\nsupseteq';

// Logic
LOGIC_OP: '\\land' | '\\lor' | '\\lnot' | '\\implies' | '\\Leftrightarrow' ;
FORALL:  '\\forall';
EXISTS: '\\exists';

// Calculus
PARTIAL: '\\partial';

// Trigonometry
// TODO - change to parser rule
TRIGONOMETRY : SIN | ARCSIN | SINH | SEC | COS | ARCCOS | COSH | CSC | TAN | ARCTAN | TANH | COT | ARCCOT | COTH ;

SIN : '\\sin' ;
ARCSIN : '\\arcsin' ;
SINH : '\\sinh' ;
SEC : '\\sec' ;
COS : '\\cos' ;
ARCCOS : '\\arccos' ;
COSH : '\\cosh' ;
CSC : '\\csc' ;
TAN : '\\tan' ;
ARCTAN : '\\arctan' ;
TANH : '\\tanh' ;
COT : '\\cot' ;
ARCCOT : '\\arccot' ;
COTH : '\\coth' ;

// Text and symbols || when 2 lexer rules matches the same amount of characters, the first one is used
ID : [a-zA-Z]+[0-9]* ;
NUMBER : ([0-9]*[.])?[0-9]+ ;
INFINITY: '\\infty';
GREECE : '\\alpha' | '\\beta' | '\\gamma' | '\\delta' | '\\epsilon' | '\\zeta' | '\\eta' | '\\theta' | '\\iota' | '\\kappa' | '\\lambda' | '\\mu' | '\\nu' | '\\xi' | '\\pi' | '\\rho' | '\\sigma' | '\\tau' | '\\upsilon' | '\\phi' | '\\chi' | '\\psi' | '\\omega' | '\\Alpha' | '\\Beta' | '\\Gamma' | '\\Delta' | '\\Epsilon' | '\\Zeta' | '\\Eta' | '\\Theta' | '\\Iota' | '\\Kappa' | '\\Lambda' | '\\Mu' | '\\Nu' | '\\Xi' | '\\Pi' | '\\Rho' | '\\Sigma' | '\\Tau' | '\\Upsilon' | '\\Phi' | '\\Chi' | '\\Psi' | '\\Omega';
DOLLAR: '$';
WS: [ \t\r\n]+ -> skip;