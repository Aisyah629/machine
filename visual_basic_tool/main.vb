Imports System
Imports System.IO
Imports System.Diagnostics

Module VisualBasicTool
    Sub Main()
        Console.WriteLine("Visual Basic Tool Initialized")
        Console.WriteLine("-----------------------------")
        Console.WriteLine("Supported file extensions: .vb")
        Console.WriteLine("Enter command (compile, run, help):")
        
        Dim command As String = Console.ReadLine().ToLower()
        
        Select Case command
            Case "help"
                ShowHelp()
            Case "compile"
                Dim fileName As String = GetFileName()
                If fileName IsNot Nothing Then
                    CompileVB(fileName)
                End If
            Case "run"
                Dim fileName As String = GetFileName()
                If fileName IsNot Nothing Then
                    RunVB(fileName)
                End If
            Case Else
                Console.WriteLine("Unknown command. Type 'help' for options.")
        End Select
        
        Console.WriteLine("Press any key to exit...")
        Console.ReadKey()
    End Sub

    Private Sub ShowHelp()
        Console.WriteLine("Visual Basic Tool Help:")
        Console.WriteLine("  compile [filename] - Compile a .vb file using vbc.")
        Console.WriteLine("  run [filename]     - Compile and run a .vb file.")
        Console.WriteLine("  help               - Show this help message.")
    End Sub

    Private Function GetFileName() As String
        Console.WriteLine("Enter the name of the .vb file (without extension):")
        Dim baseName As String = Console.ReadLine()
        Return If(String.IsNullOrEmpty(baseName), Nothing, baseName)
    End Function

    Private Sub CompileVB(fileName As String)
        Console.WriteLine($"Compiling {fileName}.vb...")
        
        ' Ensure the file exists
        If Not File.Exists($"{fileName}.vb") Then
            Console.WriteLine("Error: File not found.")
            Return
        End If

        ' Use ProcessStartInfo to invoke vbc
        Dim psi As New ProcessStartInfo With {
            .FileName = "vbc", ' Assumes vbc is in PATH, or specify full path
            .Arguments = $""\"{fileName}.vb"" /out:""{fileName}.exe""",
            .UseShellExecute = False,
            .RedirectStandardOutput = True,
            .RedirectStandardError = True,
            .CreateNoWindow = True
        }

        Using process As Process = Process.Start(psi)
            Dim output As String = process.StandardOutput.ReadToEnd()
            Dim errors As String = process.StandardError.ReadToEnd()
            process.WaitForExit()

            If process.ExitCode = 0 Then
                Console.WriteLine("Compilation successful.")
                Console.WriteLine(output)
            Else
                Console.WriteLine("Compilation failed.")
                Console.WriteLine(errors)
            End If
        End Using
    End Sub

    Private Sub RunVB(fileName As String)
        Console.WriteLine($"Compiling and running {fileName}.vb...")
        CompileVB(fileName)
        
        If File.Exists($"{fileName}.exe") Then
            Console.WriteLine("Running application...")
            Dim psi As New ProcessStartInfo With {
                .FileName = $"{fileName}.exe",
                .UseShellExecute = True
            }
            Process.Start(psi)
        Else
            Console.WriteLine("Executable not found. Compilation may have failed.")
        End If
    End Sub
End Module
