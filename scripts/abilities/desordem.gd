extends Node

func trigger_ability(battle_manager, card_node, owner_str):
	if owner_str == "Jogador":
		if battle_manager.has_method("initiate_hand_swap"):
			battle_manager.initiate_hand_swap()
			if battle_manager.has_method("spawn_floating_text"):
				battle_manager.spawn_floating_text("TROCA DE MÃOS!", card_node.global_position, Color.WHITE)
