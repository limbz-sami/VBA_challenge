Sub stock():
    Dim ws As Worksheet
    For Each ws In Worksheets
        ws.Activate
'Declare variables

    Dim volumn As Double
    volumn = 0

    Dim count As Integer
    count = 2
    
    'Finding last row in column 1
    lastrow = Cells(Rows.count, 1).End(xlUp).Row
    

    For i = 2 To lastrow
    
        'Finding opening price
        If Cells(i, 1).Value = Cells(i + 1, 1).Value And Cells(i - 1, 1).Value <> Cells(i, 1).Value Then
            opening = Cells(i, 3).Value

        'Printing unique variables in column 1
        ElseIf Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
            Cells(count, 9).Value = Cells(i, 1)
            
            'Finding closing price
            Closing = Cells(i, 6).Value
            'Finding yearly change in stock price and formatting negative and positive change
            Yearly_Change = Closing - opening
            Range("J" & count).Value = Yearly_Change
                If Yearly_Change > 0 Then
                Range("J" & count).Interior.ColorIndex = 4
                Else
                Range("J" & count).Interior.ColorIndex = 3
                End If

            'Calculating the percent change in stock price
                If opening > 0 Then
                Percent_Change = (Closing - opening) / opening
                Range("K" & count).Value = Percent_Change
                Range("K" & count).NumberFormat = "0.00%"
                
                Else
                Range("K" & count).Value = 0
                
                End If
            
            'Calculating total stock volumn
            volumn = volumn + Cells(i, 7).Value
            Range("L" & count).Value = volumn

            count = count + 1
            volumn = 0


        ElseIf Cells(i + 1, 1).Value = Cells(i, 1).Value Then
            volumn = volumn + Cells(i, 7).Value
        
         End If
    
    Next i
    
    endrow = Cells(Rows.count, 11).End(xlUp).Row
    For i = 2 To endrow
    
            'Calculating greatest % increase in stock price
            Max_value = WorksheetFunction.Max(Columns("K"))
            Range("Q2").Value = Max_value
            Range("Q2").NumberFormat = "0.00%"
            
            'Calculating greatest % decrease in stock price
            Min_value = WorksheetFunction.Min(Columns("K"))
            Range("Q3").Value = Min_value
            Range("Q3").NumberFormat = "0.00%"
            
                If Cells(i, 11).Value = Max_value Then
                Range("P2").Value = Cells(i, 9).Value
                ElseIf Cells(i, 11).Value = Min_value Then
                Range("P3").Value = Cells(i, 9).Value
                End If
                
            'Calculating greatest stock volumn
            Maxvol = WorksheetFunction.Max(Columns("L"))
            Range("Q4").Value = Maxvol
                If Cells(i, 12).Value = Maxvol Then
                Range("P4").Value = Cells(i, 9).Value
                End If
        Next i
                
     
    Next ws

End Sub
