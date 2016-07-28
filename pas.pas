PROGRAM Expert;
								// ======================================= p.46
CONST

WORD_MAX=40;					// max name length
LINE_MAX=80;					// max textline length

								// lexemes
COLON	=':';
PERIOD	='.';
COMMA	=',';
SPACE	=' ';
EQUALS	='=';
DEFINITE=100;

TYPE
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

legal_ptr	=^legal_val;
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

								// ======================================= p.48
prem_ptr=^prem;
con_ptr=^con;
rule_ptr=^rule;
prem=record
	next	:prem_ptr;
	obj		:word_string;
	value	:word_string;
end;
con=record
	next	:con_ptr;
	obj		:word_string;
	value	:word_string;
	cert	:integer;
end;
rule=record
	next	:rule_ptr;
	name	:word_string;
	prem	:prem_ptr;
	con		:con_ptr;
end;

VAR

max_choice, choice_lim, choice	:integer;
last_try, top_fact				:object_ptr;
s_word, s_object, s_value		:word_string;
s_line							:line_string;
s_cf							:integer;
top_rule						:rule_ptr;
rules							:Text;
explain							:boolean;

BEGIN
	writeln('Hello World!');
END.
