// XToDo.prg
// Created by    : EricSelje
// Creation Date : 09/19/2020 7:42:20 PM
// Created for   : Virtual Fox Fest 2020
// WorkStation   : WIWP-ES-BC6SBY1


USING System
USING System.Collections.Generic
USING System.Text

BEGIN NAMESPACE XSharpToDo

    DEFINE CLASS XToDo as Custom
    private id as string
    private title as string
    public descript as string
    private entered as datetime
    private completed as boolean
    private isEditing as boolean
    
    public FUNCTION Constructor() // No Parameter. New Task.
    This.clear()
    
    public FUNCTION Constructor(cId AS String) // Parameter. Existing Task
    This.load(cId)
    
    public PROCEDURE clear    
        This.id = ""
        This.title = ""
        This.descript = ""
        This.completed = False
    end procedure 
    
    public FUNCTION load(cId) AS Boolean
        var lReturn := False
        SELECT ToDos
        LOCATE FOR id = cId
        lReturn = FOUND()
        IF lReturn
                This.id = ToDos.id
                This.title = ToDos.title
                This.descript = ToDos.descript
                This.entered = Todos.entered
            This.completed = ToDos.completed
        else
            This.clear()
        ENDIF         
        return lReturn
    END FUNCTION
    
    PUBLIC FUNCTION SAVE() AS STRING
        VAR LRETURN := FALSE
        LOCATE FOR ID = THIS.ID
        LRETURN = FOUND()
        IF NOT LRETURN
            VAR G = GUID.NEWGUID()
            VAR CNEWID = G.TOSTRING()
            // INSERT INTO TODOS (ID) VALUES (CNEWID)
            APPEND BLANK
            REPLACE ID WITH CNEWID, ISEDITING WITH TRUE
        ENDIF 
        REPLACE TITLE WITH THIS.TITLE, DESCRIPT WITH THIS.DESCRIPT = TODOS.DESCRIPT, COMPLETED WITH THIS.COMPLETED, ENTERED WITH DATETIME.NOW, ISEDITING WITH FALSE
        RETURN TODOS.ID
    END FUNCTION
    
    PUBLIC FUNCTION Complete() AS Boolean
        LOCAL cId
        cId = This.SAVE()
        This.Completed = not empty(cId)
        RETURN This.Completed
        
    end define
    
END NAMESPACE // XSharpToDo