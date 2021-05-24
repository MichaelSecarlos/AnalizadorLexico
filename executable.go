package main

import "fmt"

func main() {
	var intType int = 15
	var float32Type float32 = 12.6
	var float64Type float64 = 15.9
	var stringType string = "cadena"

	fmt.Printf("intType=%d: %T\n", intType, intType)
	fmt.Printf("float32Type=%f: %T\n", float32Type, float32Type)
	fmt.Printf("float64Type=%f: %T\n", float64Type, float64Type)
	fmt.Printf("stringType=%s: %T\n", stringType, stringType)
}
