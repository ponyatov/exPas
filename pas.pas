program Expert;
								// ======================================= p.46
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
								// ======================================= p.47
val=record
	next	:value_ptr;			// next value in list
	name	:word_string;		// value name
	setby	:word_string;		// ???
	cert	:integer;			// ???
end;

legal_ptr	=^legal_val;//^val in book (?)
legal_val=record
	next	:legal_ptr;
	name	:word_string;
end;

obj=record
	next		:object_ptr;	// next object in list
	name		:word_string;	// object name
	value_list	:value_ptr;		// list of values
	question	:word_string;	// ???
	multivald	:boolean;		// ???
	legal_list	:legal_ptr;		// ???
	sought		:boolean;		// ???
end;

begin
	writeln('Hello World!');
end.
