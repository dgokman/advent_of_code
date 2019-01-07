A = "Weapons:    Cost  Damage  Armor
Dagger        8     4       0
Shortsword   10     5       0
Warhammer    25     6       0
Longsword    40     7       0
Greataxe     74     8       0
Armor:      Cost  Damage  Armor
Leather      13     0       1
Chainmail    31     0       2
Splintmail   53     0       3
Bandedmail   75     0       4
Platemail   102     0       5
Rings:      Cost  Damage  Armor
Damage+1    25     1       0
Damage+2    50     2       0
Damage+3   100     3       0
Defense+1   20     0       1
Defense+2   40     0       2
Defense+3   80     0       3"

arr = A.split("\n").map {|a| a.split(" ")}
weapons, armor, rings = arr[1..5].map {|a| a.map(&:to_i)}, arr[7..11].map {|a| a.map(&:to_i)}, arr[13..-1].map {|a| a.map(&:to_i)}

def player_wins?(hp1, damage1, armor1, hp2, damage2, armor2)
  loop do
    hp2 -= damage1-armor2
    return true if hp2 <= 0
    hp1 -= damage2-armor1
    return false if hp1 <= 0
  end
end

# 1
combinations = []
weapons.each do |w|
  for a in 0..1
    armor.combination(a).each do |b|
      for r in 0..2
        rings.combination(r).each do |s|
          combo = []
          combo << w
          b.each do |c|
            combo << c
          end
          s.each do |t|
            combo << t
          end
          combinations << combo  
        end
      end
    end
  end
end

possibles = []
combinations.each do |array|
  cost_a, damage_a, armor_a = array.transpose[1..-1]
  possibles << [cost_a.inject(:+), damage_a.inject(:+), armor_a.inject(:+)]
end


possibles.sort.each do |cost, damage, armor|            
  if player_wins?(100,damage,armor,109,8,2)
    p cost
    break
  end
end

# 2

combinations = []
for z in 1..weapons.length
  weapons.combination(z).each do |w|
    for a in 0..armor.length
      armor.combination(a).each do |b|
        for r in 0..rings.length
          rings.combination(r).each do |s|
            combo = []
            w.each do |x|
              combo << x
            end  
            b.each do |c|
              combo << c
            end
            s.each do |t|
              combo << t
            end
            combinations << combo  
          end
        end
      end
    end
  end  
end 


possibles = []
combinations.each do |array|
  cost_a, damage_a, armor_a = array.transpose[1..-1]
  possibles << [cost_a.inject(:+), damage_a.inject(:+), armor_a.inject(:+)]
end

possibles.sort.reverse.each do |cost, damage, armor|   
  if !player_wins?(100,damage,armor,109,8,2)
    p cost
    break
  end
end  
