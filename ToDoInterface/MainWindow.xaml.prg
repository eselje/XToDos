USING System
USING System.Collections.Generic
USING System.Linq
USING System.Text
USING System.Threading.Tasks
USING System.Windows
USING System.Windows.Controls
USING System.Windows.Data
USING System.Windows.Documents
USING System.Windows.Input
USING System.Windows.Media
USING System.Windows.Media.Imaging
USING System.Windows.Navigation
USING System.Windows.Shapes

BEGIN NAMESPACE ToDoInterface

    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    PUBLIC PARTIAL CLASS MainWindow INHERIT Window
    
        PUBLIC CONSTRUCTOR() STRICT
            InitializeComponent()
			RETURN
            
	
		METHOD TextBox_SelectionChanged(sender as TextBox, e as RoutedEventArgs) AS VOID
			var textBox := sender 
			Self.txtStatus.Text := "Selection starts at character #" + textBox.SelectionStart + Environment.NewLine
			Self.txtStatus.Text += "Selection is " + textBox.SelectionLength + " character(s) long" + Environment.NewLine
			Self.txtStatus.Text += "Selected text: '" + textBox.SelectedText + "'"
		    RETURN
            
    END CLASS
END NAMESPACE
