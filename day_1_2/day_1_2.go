package main

import (
  "io/ioutil"
  "fmt"
)

func main() {
  contents, _ := ioutil.ReadFile("day_1_2.txt")
  floor := 0
  for index, val := range contents {
    if string(val) == ")" {
      floor--
    } else if string(val) == "(" {
      floor++
    }
    if floor == -1 {
      fmt.Println(index+1)
      break
    }
  }
}
