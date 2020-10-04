USING System
USING XSharpToDo

FUNCTION Start() AS VOID STRICT
    LOCAL oToDo AS XToDo, cTestId AS String, cDescript As String 
    cTestId := "EDF53AEF-5C29-4DC4-A"
    oToDo := createObject("XToDo")
    IF oToDo.openToDos()
        SET DELETE ON
        SCAN
            Console.WriteLine("{0:00}: ID: {1}, {2}",  RECNO(), ToDos.id, ToDos.descript)
//            ? "RECNO()
//            ? ToDos.id
//            ?? ToDos.descript
             IF ToDos.Id = cTestId
                  cDescript = ToDos.descript
             ENDIF
        ENDSCAN
        ? cTestId +": " + cDescript
        oToDo.Load(cTestId)

        oToDo.closeToDos()
    ELSE
            ? "Could not open ToDos.dbf"
            ? "Default folder is " + SET("DEFAULT")
    ENDIF
    WAIT
	RETURN	
