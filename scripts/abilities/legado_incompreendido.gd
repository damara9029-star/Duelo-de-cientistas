extends Node

func trigger_ability(battle_manager, targets, spell_card, owner_str):
	if targets.size() > 0:
		var creature_to_sacrifice = targets[0]
		if is_instance_valid(creature_to_sacrifice):
			await battle_manager.destroy_card(creature_to_sacrifice, owner_str)
			if owner_str == "Jogador":
				if battle_manager.has_method("rpc_draw_my_card"):
					battle_manager.rpc_draw_my_card()
					await battle_manager.get_tree().create_timer(0.2).timeout
					battle_manager.rpc_draw_my_card()
				battle_manager.opponent_health = max(0, battle_manager.opponent_health - 2)
				battle_manager.update_health_labels()
				if battle_manager.has_method("spawn_floating_text"):
					battle_manager.spawn_floating_text("Legado!", Vector2(500, 300), Color.GOLD)
			elif owner_str == "Oponente":
				battle_manager.player_health = max(0, battle_manager.player_health - 2)
				battle_manager.update_health_labels()
