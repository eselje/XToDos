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

BEGIN NAMESPACE XSharpToDoNUnitTestClasses
	[TestFixture];
	CLASS TestClass
	CONSTRUCTOR() STRICT  
		RETURN
	[Test];
	METHOD openToDo AS VOID STRICT
        VAR oAccess := XSharpToDo.XToDos{}
        VAR lReturn := oAccess.openTodos()
		Assert.IsTrue(lReturn, "Could not open ToDos.dbf")
	RETURN
	[Test];
	METHOD closeToDo AS VOID STRICT
       VAR oAccess := XSharpToDo.XToDos{}
       VAR lReturn := oAccess.closeTodos()
		Assert.IsTrue(lReturn, "Could not close ToDos.dbf")
	RETURN
    [Test];
	METHOD getToDo AS VOID STRICT
       VAR oAccess := XSharpToDo.XToDos{}
       IF oAccess.openTodos()
            VAR oTodo := oAccess.getToDo("1")
            VAR cExpected := "Load up sailing gear"
	        Assert.AreEqual(cExpected, oTodo.descript, "Did not get the right TODO")
        else
            Assert.Fail("Could not open TODOS.dbf")
       ENDIF 
	RETURN
    [Test];
	METHOD addToDo AS VOID STRICT
		Assert.Inconclusive("This test is not implemented yet.")
	RETURN
	[Test];
	METHOD deleteToDo AS VOID  STRICT
		Assert.Inconclusive("This test is not implemented yet.")
    RETURN 
	[Test];
   	METHOD completeTodo AS VOID  STRICT
		Assert.Inconclusive("This test is not implemented yet.")
       RETURN 
END CLASS

END NAMESPACE
