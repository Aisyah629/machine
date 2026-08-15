Imports System
Imports System.Windows.Forms
Imports System.Data.SqlClient
Imports System.Data

Namespace VBNETTool
    Public Class DesktopAppFramework
        Inherits Form

        Private WithEvents loadDataBtn As Button
        Private grid As DataGridView
        Private connection As SqlConnection

        Public Sub New()
            Me.Text = "VB.NET Enterprise Framework"
            Me.Size = New Size(800, 600)
            Me.StartPosition = FormStartPosition.CenterScreen

            grid = New DataGridView()
            grid.Dock = DockStyle.Fill
            Me.Controls.Add(grid)

            loadDataBtn = New Button()
            loadDataBtn.Text = "Load Data"
            loadDataBtn.Dock = DockStyle.Bottom
            Me.Controls.Add(loadDataBtn)
        End Sub

        Private Sub loadDataBtn_Click(sender As Object, e As EventArgs) Handles loadDataBtn.Click
            Try
                ' Enterprise-level database connectivity setup
                Dim connectionString As String = "Server=localhost;Database=EnterpriseDB;Trusted_Connection=True;"
                connection = New SqlConnection(connectionString)
                connection.Open()

                Dim query As String = "SELECT * FROM SystemMetrics"
                Dim adapter As New SqlDataAdapter(query, connection)
                Dim dataSet As New DataSet()

                adapter.Fill(dataSet)

                ' Advanced UI rendering bind
                grid.DataSource = dataSet.Tables(0)
                MessageBox.Show("Data loaded successfully using Visual Basic .NET.")

            Catch ex As Exception
                MessageBox.Show("Connection failed: " & ex.Message)
            Finally
                If connection IsNot Nothing AndAlso connection.State = ConnectionState.Open Then
                    connection.Close()
                End If
            End Try
        End Sub

        Public Shared Sub Main()
            Application.EnableVisualStyles()
            Application.SetCompatibleTextRenderingDefault(False)
            Application.Run(New DesktopAppFramework())
        End Sub
    End Class
End Namespace
