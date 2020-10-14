// XToDos.prg
// Created by    : EricSelje
// Creation Date : 09/19/2020 7:42:20 PM
// Created for   : Virtual Fox Fest 2020
// WorkStation   : WIWP-ES-BC6SBY1USING System

USING System.Collections.Generic
USING System.Collections.ObjectModel
USING System.Linq
USING System.Text

BEGIN NAMESPACE XSharpToDo
    
    DEFINE CLASS XToDos AS Custom
    cTableName AS String 
    cAlias AS String
    cLastId AS String
    nTodos AS Int 
    aToDos AS ObservableCollection<XToDo>
    //  private aToDos AS ARRAY OF XToDo
    
    PROCEDURE Init() 
        SET EXCLUSIVE OFF
        This.cTableName = "C:\DEV\XToDos\ToDos.dbf"
        This.cAlias = "ToDos"
        This.nToDos = 0
        This.aToDos = ObservableCollection<XToDo>{}
        RDDSetDefault("DBFVFP") // This is the default if dialect is FoxPro
        return 
    end function
    
    public FUNCTION openToDos() AS Boolean
        LOCAL cTableName
        cTableName = This.cTableName
        // Console.WriteLine(GetDefault())
        IF NOT used("TODOS")
            SELECT 0
            USE (cTableName) SHARED
        ENDIF
        return used("TODOS")
    END FUNCTION
    
    public FUNCTION closeToDos() AS Boolean
        USE IN (CoreDb.SymSelect("ToDos"))
        return not used("Todos")
    END FUNCTION
    
    PUBLIC FUNCTION getToDo(cId as string) as XToDo
        VAR oToDo = createObject("XToDo")
        oToDo.Load(cId)
    return oToDo
    
    public FUNCTION Load() as Int
        LOCAL nToDos
        LOCAL oToDo AS XToDo
        This.OpenTodos()
        SET DELETED ON 
        COUNT TO nToDos
        This.aToDos.Clear()
        SCAN 
            oTodo = CreateObject("XToDo", ToDos.id)
            // AAdd(This.aTodos, oTodo)
            This.aToDos.Add(oToDo)
        ENDSCAN
        This.CloseTodos()
        This.nToDos = nToDos
    RETURN This.nToDos
    
    public Function New(cTitle AS String)  AS Int
        This.nTodos = This.nTodos + 1
        VAR  oTodo = CreateObject("XToDo")   // No ID
        oToDo.New(cTitle)
        oToDo.Save()
        This.cLastId = oToDo.Id
        aToDos.Add(oToDo)
        RETURN This.nToDos
        
    public function toggleCompleted(oTask as XToDo) as boolean
        // oTask = This.aToDos.Find(x => x.id = cId)
        oTask.completed = ! oTask.completed
        oTask.SAVE()
        This.Load()
        return oTask.completed
        
     public function deleteTask(oTask as XToDo) as boolean
        LOCAL lDeleted AS boolean   
        lDeleted = oTask.Delete()
        This.Load()
        return lDeleted
   
    public Function GetLast() AS XToDo
        VAR  oTodo = CreateObject("XToDo")   // No ID
        LOCAL cId AS String
        IF EMPTY(This.cLastId)
            * Go to the bottom of the ToDos table and get that ID
            This.openToDos()
            SET ORDER TO
            SET DELETED ON
            GO BOTTOM
            cId = ToDos.id
        ELSE
            cId = This.cLastId
        ENDIF
        oTodo.Load(cId)
        RETURN oToDo
    END DEFINE


END NAMESPACE
    
    