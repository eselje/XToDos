USING System

FUNCTION Start() AS VOID STRICT
    SET DEFAULT TO "C:\DEV\XTODOS"
    Var oToDo := createObject("XToDo")
    oToDo.Load("1CA98324-14A4-4708-87E4-9330117757E7")
    ? oToDo.descript
    WAIT
	RETURN	
