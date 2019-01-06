A = "jio a, +22
inc a
tpl a
tpl a
tpl a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
jmp +19
tpl a
tpl a
tpl a
tpl a
inc a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
tpl a
tpl a
jio a, +8
inc b
jie a, +4
tpl a
inc a
jmp +2
hlf a
jmp -7"

OPERATIONS = {
  hlf: lambda {|idx,a,offset| [a/2, idx+1]},
  tpl: lambda {|idx,a,offset| [a*3, idx+1]},
  inc: lambda {|idx,a,offset| [a+1, idx+1]},
  jmp: lambda {|idx,a,offset| [a, idx+offset]},
  jie: lambda {|idx,a,offset| [a, a.even? ? idx+offset : idx+1]},
  jio: lambda {|idx,a,offset| [a, a == 1 ? idx+offset : idx+1]}
}

instructions = A.split("\n").map {|a| a.split(" ")}

def run(register, instructions)
  idx = 0
  until idx >= instructions.length
    register_idx = instructions[idx][1].sub(",","") == "a" ? 0 : 1
    new_register_val, idx = OPERATIONS[instructions[idx][0].to_sym].call(idx, 
      register[register_idx],
      instructions[idx][0] == "jmp" ? instructions[idx][1].to_i : instructions[idx][2].to_i)
    register[register_idx] = new_register_val
  end
  register
end  

# 1
p run([0,0], instructions)[1]

# 2
p run([1,0], instructions)[1]

