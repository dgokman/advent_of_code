# 1 in Mathematica

# Select[Table[{n, DivisorSigma[1, n]}, {n, 1000000}], #[[2]] >= 2900000 &][[1]][[1]]

# 2

presents = Hash.new(0)

k = 1
while k <= 10**6
  50.times do |n|
    presents[k*(n+1)] += 11*k
  end
 
  k += 1
end

p presents.detect {|k,v| v >= 29000000}.first