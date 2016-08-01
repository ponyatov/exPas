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
val=RECORD
	next	:value_ptr;			// next value in list
	name	:word_string;		// value name
	setby	:word_string;		// ???
	cert	:integer;			// ???
END;

legal_ptr	=^legal_val;
legal_val=RECORD
	next	:legal_ptr;
	name	:word_string;
END;

obj=RECORD
	next		:object_ptr;	// next object in list
	name		:word_string;	// object name
	value_list	:value_ptr;		// list of values
	question	:word_string;	// ???
	multivald	:boolean;		// ???
	legal_list	:legal_ptr;		// ???
	sought		:boolean;		// ???
END;

								// ======================================= p.48
prem_ptr=^prem;
con_ptr=^con;
rule_ptr=^rule;
prem=RECORD
	next	:prem_ptr;
	obj		:word_string;
	value	:word_string;
END;
con=RECORD
	next	:con_ptr;
	obj		:word_string;
	value	:word_string;
	cert	:integer;
END;
rule=RECORD
	next	:rule_ptr;
	name	:word_string;
	prem	:prem_ptr;
	con		:con_ptr;
END;

VAR

max_choice, choice_lim, choice	:integer;
last_try, top_fact				:object_ptr;
s_word, s_object, s_value		:word_string;
s_line							:line_string;
s_cf							:integer;
top_rule						:rule_ptr;
rules							:Text;
explain							:boolean;

								// ======================================= p.50
PROCEDURE make_node(VAR curr_object:object_ptr);
// create new object node
VAR
	head	:object_ptr;
BEGIN
	new(curr_object);			// allocate memory for object
	head := top_fact;			// save current objec list head
	top_fact := curr_object;	// set object list to allocated (uninit) object
	WITH curr_object^ DO BEGIN
		next := head;			// set ptr to old object list head
		value_list := NIL;
		question := '';
		legal_list := NIL;
		multivald := FALSE;
		sought := FALSE;
	END;
END;

								// ======================================= p.51
FUNCTION find_object(f_object:word_string):object_ptr;
// find object by it's name (iterate over objects list)
VAR
	curr_object	:object_ptr;	// tmp objects list iterator 
BEGIN
	IF (last_try<>NIL) and (last_try^.name=f_object)	// hint: cached search
	THEN
		find_object	:= last_try
	ELSE BEGIN
		curr_object	:= top_fact;	// init with head of object list
		last_try	:= NIL;
		find_object	:= NIL;			// default return value is nil
		WHILE ((curr_object<>NIL) and (last_try=NIL)) DO BEGIN
			IF (curr_object^.name=f_object) THEN BEGIN
				find_object	:= curr_object;
				last_try	:= curr_object;
			END;
			curr_object := curr_object^.next;
		END;
	END;
END;

BEGIN
	writeln('Hello World!');
END.
