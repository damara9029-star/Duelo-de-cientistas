extends Node

func trigger_ability(battle_manager, targets, spell_card, owner_str):
	if targets.size() > 0:
		var target_creature = targets[0]
		if is_instance_valid(target_creature):
			print("Aplicando Escritos Populares (Temp) em: ", target_creature.card_name)
			if target_creature.has_method("add_temp_buff"):
				target_creature.add_temp_buff(2, 2)
				if battle_manager.has_method("spawn_floating_text"):
					battle_manager.spawn_floating_text("+2/+2 (Turno)", target_creature.global_position, Color.GOLD)
