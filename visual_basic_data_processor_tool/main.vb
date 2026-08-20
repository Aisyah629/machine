Imports System
Imports System.IO
Imports System.Collections.Generic
Imports System.Text

Module DataProcessor

    Sub Main(args As String())
        Dim inputFile As String = ""
        Dim outputFile As String = ""
        Dim delimiter As String = ","
        Dim transformMode As String = "none"

        ' Parse command-line arguments
        For i As Integer = 0 To args.Length - 1
            Select Case args(i)
                Case "-i", "--input"
                    If i + 1 < args.Length Then
                        inputFile = args(i + 1)
                        i += 1
                    End If
                Case "-o", "--output"
                    If i + 1 < args.Length Then
                        outputFile = args(i + 1)
                        i += 1
                    End If
                Case "-d", "--delimiter"
                    If i + 1 < args.Length Then
                        delimiter = args(i + 1)
                        i += 1
                    End If
                Case "-t", "--transform"
                    If i + 1 < args.Length Then
                        transformMode = args(i + 1).ToLower()
                        i += 1
                    End If
            End Select
        Next

        ' Defaults
        If String.IsNullOrEmpty(inputFile) Then
            inputFile = "input_data.csv"
        End If
        If String.IsNullOrEmpty(outputFile) Then
            outputFile = "output_data.csv"
        End If

        If Not File.Exists(inputFile) Then
            Console.WriteLine("Error: Input file not found: " & inputFile)
            Environment.Exit(1)
        End If

        Try
            Dim lines As String() = File.ReadAllLines(inputFile)
            Dim sb As New StringBuilder()

            For Each line As String In lines
                ' Skip empty lines
                If String.IsNullOrWhiteSpace(line) Then
                    Continue For
                End If

                ' Split line by delimiter
                Dim fields As String() = line.Split(New String() {delimiter}, StringSplitOptions.None)
                Dim processedFields As New List(Of String)()

                For Each field As String In fields
                    Dim processedField As String = field.Trim()

                    ' Apply transformation
                    Select Case transformMode
                        Case "upper"
                            processedField = processedField.ToUpper()
                        Case "lower"
                            processedField = processedField.ToLower()
                        Case "trim"
                            ' Already trimmed above
                        Case Else
                            ' No transformation
                    End Select

                    ' Basic validation
                    If processedField = "" Then
                        processedFields.Add("NULL")
                    Else
                        processedFields.Add(processedField)
                    End If
                Next

                ' Join processed fields
                sb.AppendLine(String.Join(delimiter, processedFields.ToArray()))
            Next

            ' Write output
            File.WriteAllText(outputFile, sb.ToString())
            Console.WriteLine("Processing complete. Output written to: " & outputFile)

        Catch ex As Exception
            Console.WriteLine("An error occurred during processing: " & ex.Message)
            Environment.Exit(1)
        End Try
    End Sub

End Module
