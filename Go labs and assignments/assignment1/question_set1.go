// assignment_1_command project main.go
package main

import (
	"errors"
	"fmt"
)

type Trip struct {
	destination string
	weight      float32
	deadline    int
}
type Truck struct {
	vehicle     string
	name        string
	destination string
	speed       float32
	capacity    float32
	load        float32
}
type TrainCar struct {
	Truck
	railway string
}
type Pickup struct {
	Truck
	isPrivate bool
}

func NewTruck() *Truck {
	t := Truck{"Truck", "Truck", "", 40, 10, 0}
	return &t
}
func NewPickup() *Pickup {
	p := Pickup{Truck{"Pickup", "Pickup", "", 60, 2, 0}, true}
	return &p
}
func NewTrainCar() *TrainCar { //name string, destination string
	c := TrainCar{Truck{"TrainCar", "Traincar", "", 30, 30, 0}, "CNR"}
	return &c
}

type Transporter interface {
	addLoad(*Trip)
	print()
}

func NewTorontoTrip(weight float32, deadline int) (t *Trip) {
	x := Trip{"Toronto", weight, deadline}
	return &x
}
func NewMontrealTrip(weight float32, deadline int) (t *Trip) {
	y := Trip{"Montreal", weight, deadline}
	return &y
}
func (t *Truck) print() { //if statement that changes these two
	fmt.Println(t.vehicle, t.name, "to", t.destination, "with", t.load, "tons")
}
func (t *Pickup) print() {
	fmt.Println(t.vehicle, t.name, "to", t.destination, "with", t.load, "tons", "(Private: ", t.isPrivate, ")")
}
func (t *TrainCar) print() {
	fmt.Println(t.vehicle, t.name, "to", t.destination, "with", t.load, "tons", "(", t.railway, ")")
}
func (t *Trip) print() {
	fmt.Print("{", t.destination, t.weight, t.deadline, "} ")
}
func (t *Truck) addLoad(trip *Trip) error { // returning an error if capacity+weight is wrong
	var err error
	if trip.destination == "Toronto" {
		if 400/t.speed < (float32(trip.deadline)) && (t.load+trip.weight) < t.capacity {
			if t.destination == "" {
				t.destination = trip.destination
				t.load = trip.weight
				err = nil
			} else if trip.destination == t.destination {
				t.load = trip.weight
				err = nil
			}
		} else {
			if trip.destination != t.destination && t.destination != "" {
				err = errors.New("Error: Other destination")
			} else if 400/t.speed > (float32(trip.deadline)) {
				err = errors.New("Error: unable to make it")
			} else if t.load+trip.weight > t.capacity {
				err = errors.New("Error: Out of capacity")
			}

		}
	} else {
		if 200/t.speed < (float32(trip.deadline)) && t.load+trip.weight < t.capacity {
			if t.destination == "" {
				t.destination = trip.destination
				t.load = trip.weight
				err = nil
			} else if trip.destination == t.destination {
				t.load = trip.weight
				err = nil
			} else {

			}
		} else {
			if trip.destination != t.destination && t.destination != "" {
				err = errors.New("Error: Other destination")
			} else if 200/t.speed > (float32(trip.deadline)) {
				err = errors.New("Error: unable to make it")
			} else if t.load+trip.weight > t.capacity {
				err = errors.New("Error: Out of capacity")
			}
		}
	}
	return err

}

func main() {
	var tripVar *Trip
	truck1 := NewTruck()
	truck2 := NewTruck()
	pickup1 := NewPickup()
	pickup2 := NewPickup()
	pickup3 := NewPickup()
	traincar1 := NewTrainCar()
	truck1.name = "A"
	truck2.name = "B"
	pickup1.name = "A"
	pickup2.name = "B"
	pickup3.name = "C"
	traincar1.name = "A"
	truckArray := [2]*Truck{truck1, truck2}
	pickupArray := [3]*Pickup{pickup1, pickup2, pickup3}
	var tripArray [100]*Trip
	stop := false
	//i := 0
	var tripSize int
	tripSize = 0
	for stop == false {
		var dest string
		var weight float32
		var time int

		fmt.Print("Destination: (t)oronto, (m)ontreal, else exit? ")
		fmt.Scanln(&dest)

		if dest[0] == 'm' || dest[0] == 'M' || dest[0] == 't' || dest[0] == 'T' {
			//fmt.Println(dest[0] == 'm' || dest[0] == 'M' || dest[0] == 't' || dest[0] == 'T')

		} else {
			fmt.Println("Not going to TO or Montreal, bye!")
			stop = true
			break
		}
		var loaderr error
		fmt.Print("Weight: ")
		fmt.Scanln(&weight)

		fmt.Print("Deadline (in hours): ")
		fmt.Scanln(&time)
		if dest[0] == 'm' || dest[0] == 'M' {
			tripVar = NewMontrealTrip(weight, time)
			tripArray[tripSize] = tripVar
			tripSize++
		} else if dest[0] == 't' || dest[0] == 'T' {
			tripVar = NewTorontoTrip(weight, time)
			tripArray[tripSize] = tripVar
			tripSize++
		}
		var innerLoop = false
		j := 0
		for j < 6 && innerLoop == false {
			if j == 0 || j == 1 {
				loaderr = truckArray[j].addLoad(tripVar)
				if loaderr == nil {
					innerLoop = true
				} else {
					fmt.Println(loaderr)
				}
				j++
			} else if j == 2 || j == 3 || j == 4 {
				loaderr = pickupArray[j-2].addLoad(tripVar)
				if loaderr == nil {
					innerLoop = true
				} else {
					fmt.Println(loaderr)
				}
				j++

			} else {
				loaderr = traincar1.addLoad(tripVar)
				if loaderr != nil {
					fmt.Println(loaderr)
				}
				j++
			}
		}

		//*/
	}
	fmt.Print("Trips: [")
	for k := 0; k < tripSize; k++ {
		tripArray[k].print()
		if k == tripSize-1 {
			fmt.Println("]")
		}
	}
	fmt.Println("Vechicles: ")
	for j := 0; j < 6; j++ {
		if j == 0 || j == 1 {
			truckArray[j].print()
		} else if j == 2 || j == 3 || j == 4 {
			pickupArray[j-2].print()
		} else {
			traincar1.print()
		}
	}
	/*
		t := NewTruck()
		t.print()
		y := NewPickup()
		y.print()
		z := NewTrainCar()
		z.print()
		x := NewTorontoTrip(8, 12)
		c := NewMontrealTrip(8, 12)
		t.addLoad(x)
		z.addLoad(c)
		fmt.Println("Hello World!")
		traingle := Triangle{Point{1, 1}, Point{2, 2}, Point{2, 1}}
		var perm, area float64
		perm = traingle.Perimeter()
		area = traingle.Area()
		fmt.Println(perm, area)
	//*/
	//triangles10000()

}

////
////
////
////
////
//question#3
/*
type Point struct {
	x float64
	y float64
}
type Triangle struct {
	A Point
	B Point
	C Point
}

func triangles10000() (result [10000]Triangle) {
	rand.Seed(2120)
	for i := 0; i < 10000; i++ {
		result[i].A = Point{rand.Float64() * 100., rand.Float64() * 100.}
		result[i].B = Point{rand.Float64() * 100., rand.Float64() * 100.}
		result[i].C = Point{rand.Float64() * 100., rand.Float64() * 100.}
		fmt.Println(result[i])
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
func classifyTriangles(highRatio *Stack, lowRatio *Stack, ratioThreshold float64, triangles []Triangle /* ?) {
	return
}
*/
