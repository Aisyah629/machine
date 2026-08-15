; Rlab (R Laboratory) Tool
; A simple script demonstrating Rlab syntax capabilities

; Define a simple function to calculate the square of a number
function square(x) {
    return x * x
}

; Define a function to calculate the mean of a list
function mean(list) {
    total = 0
    count = 0
    for item in list {
        total = total + item
        count = count + 1
    }
    if count == 0 {
        return 0
    }
    return total / count
}

; Main execution block
main {
    ; Example data
    data = [1, 2, 3, 4, 5]
    
    ; Calculate mean
    avg = mean(data)
    
    ; Print results
    print "Data: " + str(data)
    print "Mean: " + str(avg)
    
    ; Calculate squares
    squares = []
    for item in data {
        squares.append(square(item))
    }
    
    print "Squares: " + str(squares)
}
