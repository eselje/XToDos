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
    public id as string
    public title as string
    public descript as string
    public entered as datetime
    public completed as boolean
    private isEditing as boolean
    private isNew as boolean
    
    public FUNCTION Constructor() // No Parameter. New Task.
        This.new()
    
    public FUNCTION Constructor(cId AS String) // Parameter. Existing Task
        This.id = cId
        This.load(cId)
    
    public PROCEDURE clear    
        This.id = ""
        This.title = ""
        This.descript = ""
        This.completed = False
    end procedure 
    
    public FUNCTION load(cId AS String) AS Boolean
        var lReturn = False
        This.openToDos()
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
        This.CloseToDos()
        return lReturn
    END FUNCTION
    
    PUBLIC FUNCTION SAVE() AS STRING
        VAR LRETURN := FALSE
        LOCATE FOR ID = THIS.ID
        LRETURN = FOUND()
        IF NOT LRETURN          
            // INSERT INTO TODOS (ID) VALUES (CNEWID)
            APPEND BLANK
            REPLACE ID WITH CNEWID, ISEDITING WITH TRUE
        ENDIF 
        REPLACE TITLE WITH THIS.TITLE, DESCRIPT WITH THIS.DESCRIPT = TODOS.DESCRIPT, COMPLETED WITH THIS.COMPLETED, ENTERED WITH DATETIME.NOW, ISEDITING WITH FALSE
        This.isNew = false
        RETURN TODOS.ID
    END FUNCTION
    
   	PROCEDURE New
    LOCAL lUsed
    This.clear()
    VAR g = GUID.NEWGUID()
    This.id = g.TOSTRING()
    this.entered = DateTime.Now
    this.isEditing = true  
	This.isNew = .t. 
	RETURN This.oData

    PUBLIC FUNCTION Complete() AS Boolean
        LOCAL cId
        cId = This.SAVE()
        This.Completed = not empty(cId)
        RETURN This.Completed       
   
   public FUNCTION openToDos() AS Boolean
        IF NOT used("TODOS")
            SELECT 0
            USE "TODOS" ALIAS "ToDos" SHARED
        ENDIF
        return used("TODOS")
    END FUNCTION
    
    public FUNCTION closeToDos() AS Boolean
        USE IN (CoreDb.SymSelect("ToDos"))
        return not used("Todos")
    END FUNCTION
   end define
    
END NAMESPACE // XSharpToDo