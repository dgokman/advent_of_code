def look_and_say(n)
  arr = []
  i = 0
  j = 0
  while i < n.length
    arr[j] = []
    arr[j][1] = n[i]
    arr[j][0] = 0
    until n[i] != arr[j][1]
      arr[j][0] += 1
      i += 1
    end
    j += 1
  end
  arr.flatten.map {|x| x.to_s}.join
end

n = "3113322113"
40.times do
  n = look_and_say(n)
end

p n.length    

n = "3113322113"
50.times do
  n = look_and_say(n)
end

p n.length
