Imports System
Imports System.IO
Imports System.Text

Module DataProcessor
    Sub Main()
        Dim inputPath As String = "data.csv"
        Dim outputPath As String = "output.csv"

        If Not File.Exists(inputPath) Then
            Console.WriteLine("Input file not found.")
            Exit Sub
        End If

        Dim lines() As String = File.ReadAllLines(inputPath)
        Dim sb As New StringBuilder()

        For Each line As String In lines
            Dim cols() As String = line.Split(",")
            ' Simple transformation: capitalize each field
            Dim transformedCols() As String = Array.ConvertAll(cols, Function(c) c.Trim().ToUpper())
            sb.AppendLine(String.Join(",", transformedCols))
        Next

        File.WriteAllText(outputPath, sb.ToString())
        Console.WriteLine("Processing complete. Output written to " & outputPath)
    End Sub
End Module
