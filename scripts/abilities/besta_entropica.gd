extends Node

func trigger_turn_start(battle_manager, card_node):
	card_node.base_attack += 1
	card_node.base_health += 1
	card_node.current_attack += 1
	card_node.current_health += 1
	card_node.update_stats_display()
	if battle_manager.has_method("spawn_floating_text"):
		battle_manager.spawn_floating_text("Entropia +1/+1", card_node.global_position, Color.GOLD)
