ALPHABET = ("a".."z").to_a << "a"

def valid?(input, str)
  arr = str.split("")
  return false if str <= input
  return false if arr.include?("i") || arr.include?("o") || arr.include?("l")
  return false unless arr.each_cons(3).any? {|a,b,c| ALPHABET.index(a)+1==ALPHABET.index(b) && 
    ALPHABET.index(b)+1==ALPHABET.index(c)}
  i = 0
  new_arr = []
  while i < arr.length-1
    new_arr << [arr[i],arr[i+1]] if arr[i] == arr[i+1]
    if arr[i+1] && arr[i+2] && arr[i] == arr[i+1] && arr[i+1] == arr[i+2]
      i += 1
    end
    i += 1
  end  
  return false unless new_arr.length >= 2
  true
end

def find_santas_password(str)
  input = str.clone
  pr = ALPHABET

  s = ALPHABET.index(str[-1])
  q = ALPHABET.index(str[-2])
  l = ALPHABET.index(str[-3])
  k = ALPHABET.index(str[-4])
  p = ALPHABET.index(str[-5])
  z = ALPHABET.index(str[-6])
  r = ALPHABET.index(str[-7])
  t = ALPHABET.index(str[-8])

  loop do
    break if t > 26
    while r <= 26
      while z <= 26
        while p <= 26
          while k <= 26
            while l <= 26
              while q <= 26
                while s <= 26
                  str = [pr[t]+pr[r]+pr[z]+pr[p]+pr[k]+pr[l]+pr[q]+pr[s]].join
                  return str if valid?(input, str)
                  s += 1
                end
                q += 1
                s = 0
              end
              l += 1
              q = 0
              s = 0
            end
            k += 1
            l = 0
            q = 0
            s = 0
          end
          p += 1
          k = 0
          l = 0
          q = 0
          s = 0
        end
        z += 1
        p = 0
        k = 0
        l = 0
        q = 0
        s = 0
      end
      r += 1
      z = 0
      p = 0
      k = 0
      l = 0
      q = 0
      s = 0 
    end
    t += 1
    r = 0
    z = 0
    p = 0
    k = 0
    l = 0
    q = 0
    s = 0    
  end
end  

# 1

password = find_santas_password("vzbxkghb")
puts password

# 2

puts find_santas_password(password)
