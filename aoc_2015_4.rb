require 'digest'

i = 0
until (d = Digest::MD5.hexdigest "iwrupvqb#{i}") && (d[0..4] == "00000")
  i += 1
end

p i

i = 0
until (d = Digest::MD5.hexdigest "iwrupvqb#{i}") && (d[0..5] == "000000")
  i += 1
end

p i