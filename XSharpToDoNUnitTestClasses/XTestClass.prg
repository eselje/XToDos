//
// Note 1: If this does not compile then you need to restore the Nuget Packages for NUnit
// You can do that by right clicking on the project item in the solution explorer
// and choosing 'Manage Nuget packages' 
// You can also set a setting inside Visual Studio to make sure the Nuget Packages get restored
// automatically. See: Tools - Nuget Package Manager - Package Manager Settings
//
// Note 2: Inside Visual Studio you should open the Test - Windows - Test Explorer Window
// From there you can run the tests and see which tests succeeded and which tests failed
//
USING System
USING System.Collections.Generic
USING System.Linq
USING System.Text
USING NUnit.Framework
USING XSharpToDo
USING XSharp.VFP
USING XSharp.Core

BEGIN NAMESPACE XSharpToDoNUnitTestClasses
    [TestFixture];
        PUBLIC CLASS TestClass
        CONSTRUCTOR() STRICT  
            RETURN
        [Test];
            METHOD openToDo AS VOID STRICT
            VAR oToDos := XToDos{}
            // LOCAL oToDos AS XToDos
            // oToDos = CreateObject("XToDos")
            // VAR oToDos = XSharp.VFP.CreateObject("XToDos")
            VAR lReturn := oToDos.openTodos()
            Assert.IsTrue(lReturn, "Could not open ToDos.dbf")
        RETURN
        [Test];
            METHOD closeToDo AS VOID STRICT
            VAR oToDos := XSharpToDo.XToDos{}
            VAR lReturn := oToDos.closeTodos()
            Assert.IsTrue(lReturn, "Could not close ToDos.dbf")
        RETURN
        [Test];
            METHOD getToDo AS VOID STRICT
            LOCAL cExpected AS String 
            VAR oToDos := XSharpToDo.XToDos{}
            VAR oTodo := oToDos.getToDo("EDF53AEF-5C29-4DC4-A")
            VAR cActual := oTodo.title
            cExpected := "Finish paper"
            Assert.AreEqual(cExpected, cActual, "Did not get the right TODO")
        RETURN
        [Test];
            METHOD getToDos AS VOID STRICT
            LOCAL nTasks AS int
            VAR oToDos := XSharpToDo.XToDos{}
            nTasks := oToDos.Load()
            IF nTasks > 0
                Assert.AreEqual(nTasks, oTodos.aToDos.Count, "Did not get the ToDos")
            else
                Assert.Fail("Did not load tasks correctly.")
            ENDIF
        RETURN
        [Test];
            METHOD addToDo AS VOID STRICT
            LOCAL nTasks AS int
            LOCAL oToDos AS XToDos
            oToDos := XSharpToDo.XToDos{}
            nTasks := oToDos.Load()
            oToDos.New("Finish writing unit tests") 
            Assert.AreEqual(nTasks+1, oTodos.aToDos.Count, "Did not add the Task")		
        RETURN
        
        [Test];
            METHOD getLastToDo AS VOID STRICT
            LOCAL oToDos AS XToDos
            LOCAL oToDo AS XToDo
            oToDos = XSharpToDo.XToDos{}
            oToDo = oToDos.getLast()
        Assert.IsNotNull(oToDo.id,"Did not instantiate the last task")
        
        [Test];
        METHOD deleteToDo AS VOID  STRICT
            LOCAL oToDos AS XToDos
            LOCAL oLastTask AS XToDo
            LOCAL lDeleted AS Boolean
            oToDos = XSharpToDo.XToDos{}
            oLastTask = oToDos.getLast()
            lDeleted = oToDos.deleteTask(oLastTask)
            Assert.IsTrue(lDeleted, "Task was not deleted.")
            RETURN 
        
        [Test];
            METHOD toggleCompleted AS VOID  STRICT
            LOCAL oToDos AS XToDos
            LOCAL oTask AS XToDo
            LOCAL lCompleted AS Boolean
            oToDos = XSharpToDo.XToDos{}
            oTask = oToDos.getLast()
            lCompleted = ! oTask.Completed
            oToDos.toggleCompleted(oTask)
            oTask.Reload()
            Assert.IsTrue( (lCompleted = oTask.Completed) , "Task was not completed.")
            RETURN 
        END CLASS
        
END NAMESPACE
