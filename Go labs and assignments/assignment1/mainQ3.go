// question3 project main.go
package main

import (
	"fmt"
	"math"
	"math/rand"
	"sync"
)

type Point struct {
	x float64
	y float64
}
type Triangle struct {
	A Point
	B Point
	C Point
}

var wait sync.WaitGroup

func triangles10000() (result [10000]Triangle) {
	rand.Seed(2120)
	for i := 0; i < 10000; i++ {
		result[i].A = Point{rand.Float64() * 100., rand.Float64() * 100.}
		result[i].B = Point{rand.Float64() * 100., rand.Float64() * 100.}
		result[i].C = Point{rand.Float64() * 100., rand.Float64() * 100.}
	}
	return
}
func (t Triangle) Perimeter() float64 {
	var sum, x1, x2, x3, y1, y2, y3 float64
	sum = 0
	x1 = t.A.x - t.B.x
	x2 = t.A.x - t.C.x
	x3 = t.B.x - t.C.x
	y1 = t.A.y - t.B.y
	y2 = t.A.y - t.C.y
	y3 = t.B.y - t.C.y
	sum = math.Sqrt(((x1 * x1) + (y1 * y1))) + math.Sqrt(((x2 * x2) + (y2 * y2))) + math.Sqrt(((x3 * x3) + (y3 * y3)))
	return sum
}
func (t Triangle) Area() float64 {
	var area, x1, x2, x3, x4 float64
	x1 = t.B.x - t.A.x
	x2 = t.C.x - t.A.x
	x3 = t.B.y - t.A.y
	x4 = t.C.y - t.A.y
	area = math.Abs((0.5 * ((x1 * x4) - (x2 * x3))))
	return area
}
func classifyTriangles(highRatio *Stack, lowRatio *Stack, ratioThreshold float64, triangles []Triangle) {
	var ratio float64
	for i := 0; i < len(triangles); i++ {
		ratio = ((triangles[i].Perimeter()) / (triangles[i].Area()))
		if ratio > ratioThreshold {
			highRatio.Push(triangles[i])
		} else {
			lowRatio.Push(triangles[i])
		}
	}
	wait.Done()
	return
}

//--------------------------------
type Stack struct {
	lockdata sync.Mutex
	stack    []Triangle
}

func NewStack() *Stack {
	return &Stack{sync.Mutex{}, make([]Triangle, 0)}
}

func (s *Stack) Push(t Triangle) {
	s.lockdata.Lock()
	s.stack = append(s.stack, t)
	s.lockdata.Unlock()
}

func (s *Stack) Pop() Triangle {
	s.lockdata.Lock()
	var t Triangle
	t = s.stack[len(s.stack)-1]
	s.stack = s.stack[:len(s.stack)-2]
	s.lockdata.Unlock()
	return t
}

func (s *Stack) Peek() Triangle {
	t := s.stack[len(s.stack)-1]
	return t

}
func (t *Triangle) print() {
	fmt.Println("Corners:", t.A, t.B, t.C)
	fmt.Println("Area:", t.Area())
	fmt.Println("Perimeter: ", t.Perimeter())
}
func main() {
	triangleArray := triangles10000()
	higherstack := NewStack()
	lowerStack := NewStack()
	wait.Add(10)
	go classifyTriangles(higherstack, lowerStack, 1.0, triangleArray[:1000])
	go classifyTriangles(higherstack, lowerStack, 1.0, triangleArray[1000:2000])
	go classifyTriangles(higherstack, lowerStack, 1.0, triangleArray[2000:3000])
	go classifyTriangles(higherstack, lowerStack, 1.0, triangleArray[3000:4000])
	go classifyTriangles(higherstack, lowerStack, 1.0, triangleArray[4000:5000])
	go classifyTriangles(higherstack, lowerStack, 1.0, triangleArray[5000:6000])
	go classifyTriangles(higherstack, lowerStack, 1.0, triangleArray[6000:7000])
	go classifyTriangles(higherstack, lowerStack, 1.0, triangleArray[7000:8000])
	go classifyTriangles(higherstack, lowerStack, 1.0, triangleArray[8000:9000])
	classifyTriangles(higherstack, lowerStack, 1.0, triangleArray[9000:])

	wait.Wait()
	fmt.Println()
	tophigh := higherstack.Peek()
	toplow := lowerStack.Peek()

	fmt.Println("highRatio:", len(higherstack.stack), "triangles")
	fmt.Println("lowRatio:", len(lowerStack.stack), "triangles")
	fmt.Println("")
	fmt.Println("HighRatio Top Triangle")
	tophigh.print()
	fmt.Println("")
	fmt.Println("LowRatio Top Triangle")
	toplow.print()

}
