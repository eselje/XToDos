USING System
USING XSharpToDo

FUNCTION Start() AS VOID STRICT
    LOCAL oToDo AS XToDo, cTestId AS String, cDescript As String 
    cTestId = "EDF53AEF-5C29-4DC4-A"
    oToDo = createObject("XToDo")
    IF oToDo.openToDos()
        SET DELETE ON
        SCAN
            Console.Write("{0:00}: ID: {1}, {2}",  RECNO(), ToDos.id, ToDos.descript)
            Console.WriteLine(" - Status: {0}", IIF(ToDos.Completed, "Complete", "Incomplete"))
        ENDSCAN
        
        oToDo.Load(cTestId)
        ? "Loaded " + cTestId + "? " + iif(oToDo.id = cTestId, "Yes", "No")
        ? oToDo.id +": " + oToDo.Descript + ' - Status: ' + IIF(oToDo.Completed, "Complete", "Incomplete")
        oToDo.closeToDos()
    ELSE
        ? "Could not open ToDos.dbf"
        ? "Default folder is " + SET("DEFAULT")
    ENDIF
    WAIT
	RETURN	
