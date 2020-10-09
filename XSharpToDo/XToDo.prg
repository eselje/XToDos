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
    id = ""
    title = ""
    descript = ""
    entered = DateTime.Now
    completed = .f.
    isEditing = .f. 
    isNew = .f.
    
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
    
    public function reload() AS Boolean
    RETURN This.load(This.id)
    
    public FUNCTION load(cId AS String) AS Boolean
        var lReturn = False
        This.openToDos()
    SET EXACT OFF
        GO TOP
        LOCATE FOR ToDos.id = cId
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
    
    PUBLIC FUNCTION SAVE() AS Boolean
        LOCAL lReturn AS Boolean
        LOCAL lSaved AS Boolean
        LOCAL cId AS String
        LOCAL cDescript AS String
        LOCAL cTitle AS String
        LOCAL lCompleted AS Boolean
        cId = This.id
        TRY 
                This.openToDos()
                LOCATE FOR ToDos.ID = cId
                lReturn = FOUND()
                IF NOT lReturn          
                    // INSERT INTO TODOS (ID) VALUES (CNEWID)
                    APPEND BLANK
                    REPLACE id WITH cId, isEditing WITH .t., Entered WITH DateTime.NOW
                ENDIF 
                cTitle = This.title
                cDescript = This.descript
                lCompleted = This.completed
                IF RLOCK()
                    REPLACE Title WITH cTitle, ;
                    Descript WITH cDescript, ;
                    Completed WITH lCompleted, ;
                    isEditing WITH .f.
                    UNLOCK
                ENDIF 
                This.isNew = .f.
            lSaved = .t.
            CATCH
        FINALLY
            This.closeToDos()
        END TRY        
        RETURN lSaved
    END FUNCTION
    
    PUBLIC FUNCTION New()
        This.New("")
    RETURN This.id
    
    PUBLIC FUNCTION New(cTitle AS STRING)
        LOCAL lUsed    
        This.Clear()
        VAR g = GUID.NEWGUID()
        This.id = g.TOSTRING()
        this.entered = DateTime.Now
        this.isEditing = true  
        This.isNew = .t. 
        This.title = cTitle
    RETURN This.id
    
    PUBLIC FUNCTION MarkCompleted(lComplete as Boolean) AS Boolean
        LOCAL lReturn as boolean 
        This.completed = lComplete
        lReturn = This.SAVE()        
    RETURN lReturn
    
    PUBLIC FUNCTION Delete AS Boolean
        LOCAL lReturn as boolean 
        LOCAL cId as string
        cId = This.id
        This.openToDos()
        LOCATE FOR ToDos.ID = cId
        IF FOUND() AND RLOCK()
            DELETE
            UNLOCK
            lReturn = deleted()
        ENDIF 
    RETURN lReturn
        
    public FUNCTION openToDos() AS Boolean
        //        XToDos:openToDos()
    IF NOT used("TODOS")
        SET DEFA TO "C:\DEV\XTODOS"
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