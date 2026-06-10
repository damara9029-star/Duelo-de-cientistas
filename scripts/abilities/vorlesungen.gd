extends Node

func trigger_ability(battle_manager, card_node, owner_str):
	if owner_str == "Jogador":
		if battle_manager.has_method("rpc_draw_my_card"):
			battle_manager.rpc_draw_my_card()
			await battle_manager.get_tree().create_timer(0.3).timeout
			battle_manager.rpc_draw_my_card()
		if battle_manager.has_method("spawn_floating_text"):
			battle_manager.spawn_floating_text("Conhecimento! Comprou 2 cartas", card_node.global_position, Color.CYAN)
			
	elif owner_str == "Oponente":
		if battle_manager.has_method("spawn_floating_text"):
			battle_manager.spawn_floating_text("Estudando... Comprou 2 cartas", card_node.global_position, Color.RED)
