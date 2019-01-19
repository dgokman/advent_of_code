SPELLS = {
  magic_missile: {cost: 53, damage: 4},
  drain: {cost: 73, damage: 2, heal: 2},
  shield: {cost: 113, effect: 6, armor: 7},
  poison: {cost: 173, effect: 6, damage: 3},
  recharge: {cost: 229, effect: 5, mana: 101}
}

def init
  @player = {mana: 500, hit_points: 50, armor: 0}
  @enemy = {damage: 9, hit_points: 51}
  @current_spells = []
end  

def player_dead?
  @player[:hit_points] <= 0
end

def boss_dead?
  @enemy[:hit_points] <= 0
end

def effect(spell)
  @enemy[:hit_points] -= SPELLS[spell][:damage].to_i
  @player[:hit_points] += SPELLS[spell][:heal].to_i
  @player[:armor] = SPELLS[spell][:armor].to_i if SPELLS[spell].has_key?(:armor)
  @player[:mana] += SPELLS[spell][:mana].to_i
end

def player_attack(new_spell, hard=false)
  
  return if @player[:mana] < SPELLS[new_spell][:cost]
  return if (@current_spells.detect {|a,b| a==new_spell} || []).last.to_i > 1
  @player[:hit_points] -= 1 if hard
  return if player_dead?
  @player[:mana] -= SPELLS[new_spell][:cost]
  @mana_spent += SPELLS[new_spell][:cost]
  @current_spells = @current_spells.map {|spell, turn| [spell, turn - 1]}

  @current_spells.each do |spell, _|
    effect(spell)
  end

  if SPELLS[new_spell].has_key?(:effect)
    @current_spells << [new_spell, SPELLS[new_spell][:effect]]
  else
    effect(new_spell)
  end

  return true if boss_dead?

  @current_spells.select! {|_, turn| turn > 0}
  if !(@current_spells.transpose.first || []).include?(:shield)
    @player[:armor] = 0
  end
  true
end

def boss_attack
  @current_spells.each do |spell, _|
    effect(spell)
  end
  return if boss_dead?
  @player[:hit_points] -= (@enemy[:damage]-@player[:armor]) > 0 ? @enemy[:damage]-@player[:armor] : 1
  return if player_dead?

  @current_spells = @current_spells.map {|spell, turn| [spell, turn - 1]}
  @current_spells.select! {|_, turn| turn > 0}

  if !(@current_spells.transpose.first || []).include?(:shield)
    @player[:armor] = 0
  end
end

def run_simulation(hard=false)
  min = Float::INFINITY
  @mana_spent = 0

  count = 0
  loop do
    init
    loop do
      spell = SPELLS.keys.sample
      attack = player_attack(spell, hard)
      break if player_dead? || boss_dead?
      boss_attack if attack
      break if @player[:mana] < 53
      break if player_dead? || boss_dead?
    end
    if boss_dead? && !player_dead?
      if @mana_spent < min
        min = @mana_spent
        count = 0
      else
        count += 1
      end
      if count > 200
        break
      end  
    end
    @mana_spent = 0
  end
  min
end 

def brute_force(hard=false)
  min = Float::INFINITY
  @mana_spent = 0

  count = 0
  SPELLS.keys.repeated_permutation(6).each do |spells|
    [:shield, :recharge, :poison].permutation(3).each do |first|
      new_spells = first + spells

      init
      new_spells.each do |spell|
        
        attack = player_attack(spell, hard)
        break if player_dead? || boss_dead?
        boss_attack if attack

        break if @player[:mana] < 53
        break if player_dead? || boss_dead?
      end
      if boss_dead? && !player_dead?
        if @mana_spent < min
          min = @mana_spent
        end
      end
      @mana_spent = 0
    end  
    
  end
  min
end   

# 1
p run_simulation

# 2
p brute_force true


