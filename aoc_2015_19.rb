A = "Al => ThF
Al => ThRnFAr
B => BCa
B => TiB
B => TiRnFAr
Ca => CaCa
Ca => PB
Ca => PRnFAr
Ca => SiRnFYFAr
Ca => SiRnMgAr
Ca => SiTh
F => CaF
F => PMg
F => SiAl
H => CRnAlAr
H => CRnFYFYFAr
H => CRnFYMgAr
H => CRnMgYFAr
H => HCa
H => NRnFYFAr
H => NRnMgAr
H => NTh
H => OB
H => ORnFAr
Mg => BF
Mg => TiMg
N => CRnFAr
N => HSi
O => CRnFYFAr
O => CRnMgAr
O => HP
O => NRnFAr
O => OTi
P => CaP
P => PTi
P => SiRnFAr
Si => CaSi
Th => ThCa
Ti => BP
Ti => TiTi
e => HF
e => NAl
e => OMg"

MOLECULE = "CRnSiRnCaPTiMgYCaPTiRnFArSiThFArCaSiThSiThPBCaCaSiRnSiRnTiTiMgArPBCaPMgYPTiRnFArFArCaSiRnBPMgArPRnCaPTiRnFArCaSiThCaCaFArPBCaCaPTiTiRnFArCaSiRnSiAlYSiThRnFArArCaSiRnBFArCaCaSiRnSiThCaCaCaFYCaPTiBCaSiThCaSiThPMgArSiRnCaPBFYCaCaFArCaCaCaCaSiThCaSiRnPRnFArPBSiThPRnFArSiRnMgArCaFYFArCaSiRnSiAlArTiTiTiTiTiTiTiRnPMgArPTiTiTiBSiRnSiAlArTiTiRnPMgArCaFYBPBPTiRnSiRnMgArSiThCaFArCaSiThFArPRnFArCaSiRnTiBSiThSiRnSiAlYCaFArPRnFArSiThCaFArCaCaSiThCaCaCaSiRnPRnCaFArFYPMgArCaPBCaPBSiRnFYPBCaFArCaSiAl"

hash = {}
A.split("\n").map {|x| x.split(" => ")}.each do |k,v|
  hash[k] ||= []
  hash[k] << v
end  

require 'set'

set = Set.new
hash.each do |k,v_arr|
  positions = MOLECULE.enum_for(:scan, k).map { Regexp.last_match.begin(0) }
  positions.each do |i|
    v_arr.each do |v|
      m = MOLECULE.clone
      m[i..i+k.length-1] = ""
      m.insert(i,v)
      set << m
    end  
  end  
end

# 1
p set.length

# 2

def positions(m, k)
  m.enum_for(:scan, k).map { Regexp.last_match.begin(0) }
end

def insert(m, pos, val, repl)
  m = m.dup
  m[pos..pos+val.length-1] = ""
  m.insert(pos, repl)
  m
end


times_arr = Set.new
1000.times do
  mols = ["e"]
  time = 0

  until mols.first.length > 488
    new_mols = Set.new
    mols.each do |m|
      hash.each do |val, repl_arr|
        positions(m, val).each do |pos|
          repl_arr.each do |repl|
            new_mols << insert(m, pos, val, repl)
          end
        end
      end        

    end
    time += 1
    if new_mols.include?(MOLECULE)
      p time
      raise
    end 
    mols = [new_mols.to_a.sample]
  end

  times_arr << time
end

p [times_arr.to_a.min, times_arr.to_a.max]
# manual binary search after getting min and max range 