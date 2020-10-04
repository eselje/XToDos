// XToDos.prg
// Created by    : EricSelje
// Creation Date : 09/19/2020 7:42:20 PM
// Created for   : Virtual Fox Fest 2020
// WorkStation   : WIWP-ES-BC6SBY1USING System

USING System.Collections.Generic
USING System.Linq
USING System.Text

BEGIN NAMESPACE XSharpToDo
    
    DEFINE CLASS XToDos AS Custom
    private cTableName AS String 
    private cAlias AS String 
    private nTodos AS Int 
//  private aToDos AS ARRAY OF XToDo
    private aToDos AS List<XToDo>
    
    public Function Init()
    SET EXCLUSIVE OFF
        This.cTableName = "C:\DEV\XToDos\ToDos"
        This.cAlias = "ToDos"
        This.nToDos = 0
        RDDSetDefault("DBFVFP") // This is the default if dialect is FoxPro
        return 
    end function
    
    public FUNCTION openToDos() AS Boolean
 
        // Console.WriteLine(GetDefault())
        IF NOT used("TODOS")
            SELECT 0
            USE (This.cTableName) SHARED
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
    
    public PROCEDURE Load
        This.OpenTodos()
        SET DELETED ON 
        COUNT TO This.nToDos
        This.aToDo = {}
        SCAN 
           oTodo = CreateObject("XToDo", ToDos.id)
        // AAdd(This.aTodos, oTodo)
            aToDos.Add(oToDo)
        ENDSCAN
        This.CloseTodos()
    RETURN This.nToDos
    
    public Function New AS Int
        This.nTodos = This.nTodos + 1
        VAR  oTodo = CreateObject("XToDo")   // No ID
        oToDo.Save()
        // AAdd(This.aTodos, oTodo)
        aToDos.Add(oToDo)
        RETURN This.nToDos
        
        
    END DEFINE
    
    END NAMESPACE

