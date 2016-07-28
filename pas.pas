program Expert;
								// p.46
Const

WORD_MAX=40;					// max name length
LINE_MAX=80;					// max textline length

								// lexemes
COLON	=':';
PERIOD	='.'; 
COMMA	=',';
SPACE	=' ';
EQUALS	='=';
DEFINETE='100';

Type
								// user types
word_string	=string[WORD_MAX];
line_string	=string[LINE_MAX];

value_ptr	=^val;//ue
object_ptr	=^obj;//ect
								// p.47

begin
	writeln('Hello World!');
end.
