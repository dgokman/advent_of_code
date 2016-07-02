package main

import (
  "io/ioutil"
  "fmt"
)

func main() {
  contents, _ := ioutil.ReadFile("day_1.txt")
  floor := 0
  for _, val := range contents {
    if string(val) == ")" {
      floor--
    } else if string(val) == "(" {
      floor++
    }
  }
  fmt.Println(floor)
}
