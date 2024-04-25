grammar Prettier;

prog: (latex | component)* ;

latex: inline | block ;

component: 
      info
    | note
    | deep
    | warning
    | youtube
    ;

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
    | base POWER exponent
    | arithmetic_sum 
    | arithmetic_prod
    | arithmetic_limit
    | function
    | signed_id_number_infinity
    ;

base
    : signed_id_number_infinity
    | LCURLY arithmetic_expr RCURLY
    ;

exponent
    : signed_id_number_infinity
    | LCURLY arithmetic_expr RCURLY
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
    : '-'?INFINITY
    | signed_id_number
    ;

signed_id_number
    : '-'? (ID | indexed_id | NUMBER)
    ;

indexed_id
    : ('{' ID '}' | ID ) '_'
      ('{' NUMBER '}' | NUMBER)
    ;

operator : PLUS | MIN | MULT | DIV;

// Info component
info : open_info TEXT+ close_info;
open_info : '<Info title="' TEXT+ '">' ;
close_info : '</Info>';

// Note component
note : open_note TEXT+ close_note; 
open_note : '<Note title="' TEXT+ '">' ;
close_note : '</Note>';

// DeepDive component
deep : open_deep TEXT+ close_deep; 
open_deep : '<DeepDive title="' TEXT+ '">' ;
close_deep : '</DeepDive>';

// Warning  component
warning : open_warning TEXT+ close_warning; 
open_warning : '<Warning title="' TEXT+ '">' ;
close_warning : '</Warning>';

// YouTube  component
youtube : open_youtube yt_content close_youtube; 
open_youtube : '<YouTube title="' TEXT+ '" ' ;
close_youtube : '/>';
yt_content : 'linkOrId="' TEXT+ '" startSeconds="' NUMBER '" endSeconds="' NUMBER '" ' ;

// Arithmetic
COMPARATOR: '=' | '\\neq' | '\\pm' | '\\mp' | '\\geq' | '\\leq' | '>' | '<' | '\\approx';
PLUS : '+' ;
MIN : '-' ;
MULT : '*' | '\\cdot' | '\\times' ;
DIV : '/' | '\\div' ;
LPAREN: '(';
RPAREN: ')';
LCURLY: '{';
RCURLY: '}';
POWER: '^';
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
TEXT: ID;
ID : [a-zA-Z]+[0-9]* ;
NUMBER : ([0-9]*[.])?[0-9]+ ;
INFINITY: '\\infty';
GREECE : '\\alpha' | '\\beta' | '\\gamma' | '\\delta' | '\\epsilon' | '\\zeta' | '\\eta' | '\\theta' | '\\iota' | '\\kappa' | '\\lambda' | '\\mu' | '\\nu' | '\\xi' | '\\pi' | '\\rho' | '\\sigma' | '\\tau' | '\\upsilon' | '\\phi' | '\\chi' | '\\psi' | '\\omega' | '\\Alpha' | '\\Beta' | '\\Gamma' | '\\Delta' | '\\Epsilon' | '\\Zeta' | '\\Eta' | '\\Theta' | '\\Iota' | '\\Kappa' | '\\Lambda' | '\\Mu' | '\\Nu' | '\\Xi' | '\\Pi' | '\\Rho' | '\\Sigma' | '\\Tau' | '\\Upsilon' | '\\Phi' | '\\Chi' | '\\Psi' | '\\Omega';
DOLLAR: '$';
WS: [ \t\r\n]+ -> skip;