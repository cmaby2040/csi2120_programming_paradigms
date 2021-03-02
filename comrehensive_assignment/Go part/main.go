// assignment_question#2 project main.go
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

//var wg sync.WaitGroup

type cell struct {
	quantity, row, column int
}

type board struct {
	supply, demand []int    // Supply from each factory, Demand from each warehouse
	cost           [][]int  // Cost of transportation from factory to warehouse
	matrix         [][]cell // Allocation of products from factory to warehouse
}

type path struct {
	pathTaken []cell // Path taken
	taken     bool   // True if this path has been used regardless of direction
}

//this check to see if there is an error when opening the file
func errCheck(err error) {
	if err != nil {
		panic(err)
	}
}

// Reads the files containing the costs and the initial solution
// and sets up the warehouse struct to the initial solution
func initialSolutionboard(inputFileName string, initialFileName string) *board {
	nLine := count(inputFileName)
	//fmt.Println(nRows)
	inputFile, err := os.Open(inputFileName)
	if err != nil {
		panic(err)
	}
	defer inputFile.Close()
	scanner := bufio.NewScanner(inputFile)
	scanner.Scan()
	scanner.Scan()
	costarray := make([][]int, nLine-2)
	for i := range costarray {
		costarray[i] = make([]int, 0)
	}
	var supplyarray = []int{}
	var demandarray = []int{}
	initialSolutionarray := make([][]cell, nLine-2)
	for i := range initialSolutionarray {
		initialSolutionarray[i] = make([]cell, 0)
	}
	//fmt.Println(nLine)
	for x := 0; x < nLine-1; x++ {
		//fmt.Println(scanner.Text(), x, x == nLine-2)
		if x == nLine-2 {
			demandline := strings.Split(scanner.Text(), " ")
			demandString := demandline[1:]
			for _, m := range demandString { //_, m:
				value, err := strconv.Atoi(m)
				if err != nil {
					panic(err)
				}
				demandarray = append(demandarray, value)
			}
		} else {
			line := strings.Split(scanner.Text(), " ")
			costString := line[1 : len(line)-1]
			//fmt.Println(costString)
			//fmt.Println(line[len(line)-1])
			i, err := strconv.Atoi(line[len(line)-1])
			if err != nil {
				panic(err)
			}
			supplyarray = append(supplyarray, i)
			//fmt.Println(scanner.Text(), " ", x)
			a := 0
			for _, j := range costString {
				k, err := strconv.Atoi(j)
				if err != nil {
					panic(err)
				}
				a++
				costarray[x] = append(costarray[x], k)
				//fmt.Println(costarray)
			}
			//*/
			scanner.Scan()
		}

	}
	//fmt.Println(supplyarray)
	//fmt.Println(demandarray)
	//fmt.Println(costarray)

	initialFile, err := os.Open(initialFileName)
	if err != nil {
		panic(err)
	}
	defer initialFile.Close()
	scanner = bufio.NewScanner(initialFile)
	scanner.Scan()
	scanner.Scan()
	for z := 1; z < nLine-1; z++ {
		line := strings.Split(scanner.Text(), " ")
		quantityString := line[1 : len(line)-1]
		//fmt.Println(quantityString, len(quantityString))
		for w := 0; w < len(quantityString); w++ {
			if quantityString[w] == "-" {
				quantityString[w] = "0"
			}
			quantity, err := strconv.Atoi(quantityString[w])
			if err != nil {
				panic(err)
			}
			initialSolutionarray[z-1] = append(initialSolutionarray[z-1], cell{quantity, z - 1, w})
		}
		scanner.Scan()
	}
	//fmt.Println(initialSolutionarray)
	return &board{supplyarray, demandarray, costarray, initialSolutionarray}
}

// Counts the number of lines in the input text files
// had to create this method was having issues with the
//files given in class also need to know the number of lines and rows in each file
func count(inputFile string) (inputLineNumber int) {
	inputLineNum := 0
	input, err := os.Open(inputFile)
	if err != nil {
		panic(err)
	}
	scanner := bufio.NewScanner(input)
	defer input.Close()
	for i := 0; scanner.Scan(); i++ { //count strings in input file
		inputLineNum++
	}
	return inputLineNum
}

// Uses the stepping stone method to determine an optimized
// transportation from factories to warehouses
func (w *board) steppingStone() {
	var emptyCell cell
	leastExpensive := 0
	var tour, finaltour []cell
	var mrgCost int
	//transferP := make(chan []cell)
	for x := 0; x < len(w.supply); x++ {
		for y := 0; y < len(w.demand); y++ {
			if w.matrix[x][y].quantity == 0 { // Looking for an empty cell
				emptyCell = w.matrix[x][y]
				tour, mrgCost = w.getClosedPath(emptyCell)
				if mrgCost < leastExpensive {
					finaltour = tour

				}
			}
		}
	}
	//fmt.Println(finaltour)
	//fmt.Println("error here")
	//transferP <- finaltour
	w.transfer(finaltour)

}

// Calculates the minimum marginal cost of a path from an empty cell
// Does not change the warehouse struct (No pointers used for warehouse)
/*
func (w *board) marginalCost(emptyCell cell) int {
	var maxReduction, mrgCost int
	var builtpath []cell

	if mrgCost <= maxReduction {
		maxReduction = mrgCost
		result <- path{tour, true}
	}
	}
	}

	return maxReduction
}
*/
//
func (w *board) verticalTwoPlus(columnNumber int) bool { //function to tell if there is at least 2
	count := 0
	for i := 0; i < len(w.demand); i++ {
		if w.matrix[i][columnNumber].quantity > 0 {
			count++
			//fmt.Println(count)
		}
	}
	if count > 1 {
		return true
	} else {
		return false
	}
}
func (w *board) horizontalTwoPlus(rowNumber int) bool { //function to tell if there is at least 2
	count := 0
	for i := 0; i < len(w.supply); i++ {
		if w.matrix[rowNumber][i].quantity > 0 {
			count++
			//fmt.Println(count)
		}
	}
	if count > 1 {
		return true
	} else {
		return false
	}
}
func (w *board) getClosedPath(c cell) ([]cell, int) {
	var path []cell
	startCell := c
	firstCell := c
	var savings int
	firstTrycell := cell{startCell.quantity, startCell.row, startCell.column}
	path = append(path, startCell)
	for i := 0; i < len(path); i++ {
		// If i is even, look for non-zero cells in the same row
		//fmt.Println(firstTrycell, startCell, i, " bebinnig of each loop")
		if i%2 == 0 {
			//fmt.Println(w.matrix)

			for k := 0; k < len(w.demand); k++ {
				/*
					//fmt.Println(k)
					//fmt.Println((w.matrix[firstTrycell.row][k].quantity != 0))
					//fmt.Println(w.verticalTwoPlus(k))
					//fmt.Println(k != firstTrycell.column)
					//fmt.Println()
					//fmt.Println(w.matrix[firstTrycell.row][k].quantity != 0 && w.verticalTwoPlus(k) && k != firstTrycell.column)
					//fmt.Println()
				*/
				if (w.matrix[firstTrycell.row][k].quantity != 0 && (w.verticalTwoPlus(k))) && k != firstTrycell.column {
					firstTrycell.column = k
					//fmt.Println(w.matrix[firstTrycell.row][k].quantity)
					firstTrycell.quantity = w.matrix[firstTrycell.row][k].quantity
					break
				}
			}
			//fmt.Println(firstTrycell)
			for j := 0; j < len(w.demand); j++ {
				//fmt.Println(w.matrix[startCell.row][j].quantity != 0 && w.verticalTwoPlus(startCell.row))
				if w.matrix[firstTrycell.row][j].quantity != 0 && w.cost[firstTrycell.row][j] < w.cost[firstTrycell.row][firstTrycell.column] {
					firstTrycell.column = j
					firstTrycell.quantity = w.matrix[firstTrycell.row][j].quantity
					startCell = firstTrycell
					/*if firstTrycell.column == firstCell.column {
						break
					} else {*/

				}

			}
			savings = savings - firstTrycell.quantity*w.cost[firstTrycell.row][firstTrycell.column]
			path = append(path, firstTrycell)
			//fmt.Println(firstTrycell, startCell, i)
			// If i is odd, look for non-zero cells in the same column
		} else {
			for k := 0; k < len(w.supply); k++ {
				/*
					fmt.Println(k)
					fmt.Println((w.matrix[k][firstTrycell.column].quantity != 0))
					fmt.Println(w.horizontalTwoPlus(k))
					fmt.Println(k != firstTrycell.row)
					fmt.Println()
					fmt.Println((w.matrix[k][firstTrycell.column].quantity != 0 && (w.horizontalTwoPlus(k))) && k != firstTrycell.row)
					fmt.Println()
				*/
				if (w.matrix[k][firstTrycell.column].quantity != 0 && (w.horizontalTwoPlus(k))) && k != firstTrycell.row {
					firstTrycell.row = k
					//fmt.Println(w.matrix[k][firstTrycell.column].quantity)
					firstTrycell.quantity = w.matrix[k][firstTrycell.column].quantity

				}
			}
			//fmt.Println(firstTrycell)
			for j := 0; j < len(w.demand); j++ {
				//fmt.Println(w.matrix[startCell.row][j].quantity != 0 && w.verticalTwoPlus(startCell.row))
				if w.matrix[j][startCell.column].quantity != 0 && w.cost[j][startCell.column] < w.cost[firstTrycell.row][firstTrycell.column] {
					firstTrycell.row = j
					startCell = firstTrycell
				}

				savings = savings + firstTrycell.quantity*w.cost[firstTrycell.row][firstTrycell.column]

			}

			path = append(path, firstTrycell)

		}
		if firstTrycell.column == firstCell.column && i > 1 {
			break
		}
		if i > 20 {
			break
		}
	}

	//fmt.Println(path)
	//fmt.Println(savings)
	return path, savings
}

// Calculates the cost of the warehouse
func (t *board) getCost() int {
	total := 0

	for i := 0; i < len(t.supply); i++ {
		for j := 0; j < len(t.demand); j++ {
			total += (t.cost[i][j]) * (t.matrix[i][j].quantity)
		}
	}
	return total
}

// Moves the quantity to other warehouses to lower the cost
// (Changes the warehouse struct)
// as proposed by marginalCost func
func (w *board) transfer(pth []cell) {
	//oCost := w.getCost() // Original cost
	tour := pth
	smallestqnty := 1000
	fmt.Println("error here")
	for j := 0; j < len(tour); j++ {
		if (w.matrix[tour[j].row][tour[j].column].quantity > 0) && (w.matrix[tour[j].row][tour[j].column].quantity < smallestqnty) {
			smallestqnty = w.matrix[tour[j].row][tour[j].column].quantity
		}
	}
	for z := 0; z < smallestqnty; z++ {
		for i := 0; i < len(tour); i++ {
			if i%2 == 0 {
				w.matrix[tour[i].row][tour[i].column].quantity++
			} else {
				w.matrix[tour[i].row][tour[i].column].quantity--
			}
		}
	}
}

// Prints the results of the stepping stone method
// and writes the results to a text file
func (w *board) printResult(descriptionText string, initialText string) {
	fmt.Println("Problem description: ", descriptionText)
	fmt.Println("Initial solution: ", initialText)
	fmt.Println("Optimal solution:")
	for x := 0; x < len(w.supply); x++ {
		for y := 0; y < len(w.demand); y++ {
			fmt.Print(w.matrix[x][y].quantity, " ")
		}
		fmt.Print("\n")
	}

	fmt.Println("Total costs: ", w.getCost())

}

// The main function of the program
// Asks user to input the text flie with problem description
// and the text file with the initial solution using minimum cost method
// Then performs the stepping stone method for a optimized solution
// and prints the results
func main() {
	var inputText, initialText string
	/*
		fmt.Println("Cost of each factory to each warehouse?")
		fmt.Scanf("%s", &inputText)

		fmt.Println("Initial solution?")
		fmt.Scanf("%s", &initialText)
	*/
	inputText = "classex.txt"
	initialText = "initialclass.txt"
	initalboard := initialSolutionboard(inputText, initialText)
	//initalboard.getClosedPath(cell{0, 0, 0})
	fmt.Println(initalboard)
	maxCost := initalboard.getCost()
	for {
		initalboard.steppingStone()
		if maxCost > initalboard.getCost() {
			maxCost = initalboard.getCost()
		} else {
			break
		}
	}
	initalboard.printResult(inputText, initialText)
}

//*/
