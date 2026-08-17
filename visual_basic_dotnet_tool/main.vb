Imports System
Imports System.Windows.Forms
Imports System.ComponentModel
Imports System.Collections.Generic
Imports System.Reflection

Namespace VisualBasicDotNetTool
    ''' <summary>
    ''' A robust desktop application framework with UI binding capabilities built strictly in Visual Basic .NET.
    ''' </summary>
    Public Module Program
        ''' <summary>
        ''' Entry point for the application. Initializes the main form and runs the message loop.
        ''' </summary>
        <STAThread>
        Sub Main()
            Application.EnableVisualStyles()
            Application.SetCompatibleTextRenderingDefault(False)
            
            Dim mainForm As New MainForm()
            Application.Run(mainForm)
        End Sub
    End Module

    ''' <summary>
    ''' Represents the main application window with bound UI elements.
    ''' </summary>
    Public Class MainForm
        Inherits Form

        Private _viewModel As AppViewModel
        Private _bindings As List(Of Binding)
        Private _label As Label
        Private _textBox As TextBox
        Private _button As Button

        Public Sub New()
            InitializeComponent()
            SetupViewModel()
            SetupBindings()
        End Sub

        Private Sub InitializeComponent()
            Me.Text = "VB.NET Advanced Desktop Tool"
            Me.Size = New Size(400, 250)
            Me.StartPosition = FormStartPosition.CenterScreen

            _label = New Label With {
                .Text = "Data Binding Demo",
                .Location = New System.Drawing.Point(20, 20),
                .AutoSize = True
            }
            Me.Controls.Add(_label)

            _textBox = New TextBox With {
                .Location = New System.Drawing.Point(20, 60),
                .Size = New System.Drawing.Size(300, 20),
                .Text = "Initial Value"
            }
            Me.Controls.Add(_textBox)

            _button = New Button With {
                .Text = "Update Label",
                .Location = New System.Drawing.Point(20, 90),
                .Size = New System.Drawing.Size(120, 30)
            }
            AddHandler _button.Click, AddressOf Button_Click
            Me.Controls.Add(_button)
        End Sub

        Private Sub SetupViewModel()
            _viewModel = New AppViewModel With {
                .Title = "Initialized Framework"
            }
        End Sub

        Private Sub SetupBindings()
            _bindings = New List(Of Binding) From {
                New Binding("Text", _viewModel, "Title", True, DataSourceUpdateMode.OnPropertyChanged)
            }

            For Each binding As Binding In _bindings
                _label.DataBindings.Add(binding)
            Next
        End Sub

        Private Sub Button_Click(sender As Object, e As EventArgs)
            If _viewModel IsNot Nothing Then
                _viewModel.Title = "Updated via Event Handler"
            End If
        End Sub

        Protected Overrides Sub OnFormClosing(e As FormClosingEventArgs)
            ' Cleanup resources
            If _bindings IsNot Nothing Then
                For Each b As Binding In _bindings
                    b.Dispose()
                Next
            End If
            MyBase.OnFormClosing(e)
        End Sub
    End Class

    ''' <summary>
    ''' Represents the view model with INotifyPropertyChanged for UI binding.
    ''' </summary>
    Public Class AppViewModel
        Implements INotifyPropertyChanged

        Private _title As String

        Public Property Title As String
            Get
                Return _title
            End Get
            Set(value As String)
                If _title IsNot value Then
                    _title = value
                    OnPropertyChanged("Title")
                End If
            End Set
        End Property

        Public Event PropertyChanged As PropertyChangedEventHandler Implements INotifyPropertyChanged.PropertyChanged

        Protected Overridable Sub OnPropertyChanged(propertyName As String)
            RaiseEvent PropertyChanged(Me, New PropertyChangedEventArgs(propertyName))
        End Sub
    End Class
End Namespace
