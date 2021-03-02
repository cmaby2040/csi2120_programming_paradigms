package main

// question_2 project main.go

import (
	"fmt"
	"math/rand"
	"sync"
	"time"
)

const (
	NumRoutines = 3
	NumRequests = 1000
)

// global semaphore monitoring the number of routines
var semRout = make(chan int, NumRoutines)

// global semaphore monitoring console
var semDisp = make(chan int, 1)

// Waitgroups to ensure that main does not exit until all done
var wgRout sync.WaitGroup
var wgDisp sync.WaitGroup

type Task struct {
	a, b float32
	disp chan float32
}

func solve(t *Task) float32 {
	x := rand.Int63n(15) + 1
	time.Sleep(time.Duration(x) * time.Second)
	t.disp <- (t.a + t.b)
	return t.a + t.b
}
func handleReq(t *Task) {
	solve(t)
}

func ComputeServer() chan *Task {
	channel := make(chan *Task)
	go func() {
		for {
			semRout <- 1
			handleReq(<-channel)
			<-semRout
		}
	}()
	return channel
}
func DisplayServer() chan float32 {
	channel := make(chan float32)
	go func() {
		for recieved := range channel {
			semRout <- 1
			fmt.Println("Calculated value", recieved)
			<-semRout
		}
	}()
	return channel
}

func main() {
	dispChan := DisplayServer()
	reqChan := ComputeServer()
	for {
		var a, b float32

		fmt.Print("Enter two numbers: ")
		fmt.Scanf("%f %f \n", &a, &b)
		fmt.Printf("%f %f \n", a, b)
		if a == 0 && b == 0 {
			break
		}
		fmt.Println("")
		wgRout.Add(1)
		reqChan <- &Task{a, b, dispChan}
		wgRout.Done()
		// Create task and send to ComputeServer
		time.Sleep(1e9)
	}
	wgRout.Wait()
	wgDisp.Wait()
}
