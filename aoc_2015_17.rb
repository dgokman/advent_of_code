A = [33,
14,
18,
20,
45,
35,
16,
35,
1,
13,
18,
13,
50,
44,
48,
6,
24,
41,
30,
42]


count = 0
hash = Hash.new(0)
for i in 3..10
  A.combination(i).each do |a|
    if a.inject(:+) == 150
      hash[i] += 1
    end
  end
end

# 1

p hash.values.inject(:+)

# 2

p hash.to_a.first.last