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
		find_object	:= NIL;			// default return value is nil
		last_try	:= NIL;			// clear cache
		WHILE ((curr_object<>NIL) and (last_try=NIL)) DO BEGIN
			IF (curr_object^.name=f_object) THEN BEGIN
				find_object	:= curr_object;
				last_try	:= curr_object;		// cache found object search
			END;
			curr_object := curr_object^.next;	// move to next object in list
		END;
	END;
END;

								// ======================================= p.52
PROCEDURE split(
	f_line	:line_string;		// input string in form 'object=value'
//	VAR
	f_object:word_string;		// 'object' part
	f_value	:word_string		// 'value' part
	);
VAR
	st_left, st_right	:integer;
BEGIN
	st_right := pos(PERIOD,f_line);		// get '.' position
	IF (st_right=length(f_line))		// if '.' @ end of f_line
		THEN f_line := copy(f_line,1,st_right-1);	// remove end '.'

	st_left	:= pos(EQUALS,f_line);
	st_right:= pos(COMMA ,f_line);
	
	IF ((st_left=0) and (st_right=0))
		THEN f_object := f_line;
		
	IF (st_right=0)
		THEN st_right := length(f_line)+1;	// move st_right to end of f_line
	
	IF (st_left>0) THEN BEGIN
		f_object := copy(f_line,1,st_left-1);	// copy left part
		IF (pos(')',f_object)=0) THEN			// if no closing )
			f_value := copy(f_line,st_left+1,st_right-st_left-1);	// right
	END;
	
	st_right := pos(')',f_object);			// scan for closing )
	IF (st_right>0) THEN
		f_object := copy(f_line,1,st_right-1); 
END;

BEGIN
	writeln('Hello World!');
END.
