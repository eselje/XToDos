using System;
using System.ComponentModel;
using System.Collections.ObjectModel;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using XSharpToDo;
using XSharp.VFP;

namespace ToDoInterface2
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        //        private System.Collections.ObjectModel.ObservableCollection<User> users = new ObservableCollection<User>();
        XToDos oTasks = new XToDos { };

        public MainWindow()
        {
            InitializeComponent();            
            this.DataContext = this;
            dgTasks.ItemsSource = this.oTasks.aToDos;
            this.oTasks.Load();
        }

        private void NewCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e)
        {
            e.CanExecute = true;
        }
        private void NewCommand_Executed(object sender, ExecutedRoutedEventArgs e)
        {
            MessageBox.Show("New Task");
            this.oTasks.New("");
        }
        private void PrintCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e)
        {
            e.CanExecute = true;
        }
        private void PrintCommand_Executed(object sender, ExecutedRoutedEventArgs e)
        {
            MessageBox.Show("Print");
            // oTasks.Print();
        }
    }
}
