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

func min(arr []int) int {
  min := arr[0]
  var i int
  for i = 1; i < len(arr); i++ {
    if arr[i] < min {
      min = arr[i]
    }
  }
  return min
}

func main() {
  contents, _ := ioutil.ReadFile("day_2.txt")
  split := strings.Split(string(contents), "\n")
  sum := 0
  var i int
  for i = 0; i < len(split); i++ {
    nums := strings.Split(split[i], "x")
    numsInt := strToInt(nums)
    if len(numsInt) == 3 {
      arr := []int{numsInt[0]*numsInt[1],
        numsInt[1]*numsInt[2],
        numsInt[0]*numsInt[2]}
      sum += 2*arr[0]+2*arr[1]+2*arr[2]+min(arr)
    }
  }
  fmt.Println(sum)
}
