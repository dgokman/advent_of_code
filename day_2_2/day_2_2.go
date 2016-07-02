package main

import (
  "io/ioutil"
  "fmt"
  "strings"
  "strconv"
)

func strToInt(sa []string) []int {
  si := make([]int, 0, len(sa))
  for _, a := range sa {
      i, _ := strconv.Atoi(a)
      si = append(si, i)
  }
  return si
}

func min(arr []int) (int, int) {
  min := arr[0]
  var i int
  var index int
  for i = 1; i < len(arr); i++ {
    if arr[i] < min {
      min = arr[i]
      index = i
    }
  }
  return min, index
}

func min2(arr []int) int {
  _, index := min(arr)
  arr[index] = arr[2]
  arr = arr[:2]
  min, _ := min(arr)
  return min
}

func main() {
  contents, _ := ioutil.ReadFile("day_2_2.txt")
  split := strings.Split(string(contents), "\n")
  sum := 0
  var i int
  for i = 0; i < len(split); i++ {
    nums := strings.Split(split[i], "x")
    numsInt := strToInt(nums)
    if len(numsInt) == 3 {
      min, _ := min(numsInt)
      n := numsInt[0]*numsInt[1]*numsInt[2]
      o := (2*min)+(2*min2(numsInt))
      sum += n+o
    }
  }
  fmt.Println(sum)
}
