A = "Dancer can fly 27 km/s for 5 seconds, but then must rest for 132 seconds.
Cupid can fly 22 km/s for 2 seconds, but then must rest for 41 seconds.
Rudolph can fly 11 km/s for 5 seconds, but then must rest for 48 seconds.
Donner can fly 28 km/s for 5 seconds, but then must rest for 134 seconds.
Dasher can fly 4 km/s for 16 seconds, but then must rest for 55 seconds.
Blitzen can fly 14 km/s for 3 seconds, but then must rest for 38 seconds.
Prancer can fly 3 km/s for 21 seconds, but then must rest for 40 seconds.
Comet can fly 18 km/s for 6 seconds, but then must rest for 103 seconds.
Vixen can fly 18 km/s for 5 seconds, but then must rest for 84 seconds."

stats = []
arr = A.split("\n")
arr.each do |a|
  stats << a.split(" ").map(&:to_i).select {|b| b > 0}
end

distances = Array.new(arr.length){[0]}
seconds = [0]*arr.length
points = [0]*arr.length

L = 2503
p stats

loop do
  for i in 0..arr.length-1
    stats[i][1].times do
      seconds[i] += 1
      distances[i][seconds[i]] = distances[i][seconds[i]-1] + stats[i][0]
    end
    stats[i][2].times do
      seconds[i] += 1
      distances[i][seconds[i]] = distances[i][seconds[i]-1]
    end    
  end
  break if seconds.all? {|s| s > L }
end

# 1
p distances.map {|d| d[L].to_i}.max

distances.map {|a| a[1..seconds.min]}.transpose.each_with_index do |reindeer,j|
  max = reindeer.max
  reindeer.each_with_index do |d,i|
    if d == max
      points[i] += 1
      # 2
      p points.max if j == L
    end
  end
end   

