@s = []

def s(n)
  if n == 1
    20151125
  elsif @s[n]
    return @s[n]
  else
    @s[n] = (s(n-1)*252533) % 33554393
    return @s[n]
  end
end

arr = Array.new(10000){Array.new(10000)}

TARGET = [2981,3075]

i = 0
j = 0
n = 1
while i < arr.length
  k = i
  while j <= i
    arr[k][j] = s(n)
    n += 1
    j += 1
    k -= 1
  end
  i += 1
  j = 0
end

p arr[TARGET[0]-1][TARGET[1]-1]

      