extends Node

func should_cancel_combat_action(battle_manager, card_node) -> bool:
	var chance = randf()
	
	if chance < 0.5:
		print("Lutador Bêbado tropeçou e falhou na ação!")
		if battle_manager.has_method("spawn_floating_text"):
			battle_manager.spawn_floating_text("Tropeçou!", card_node.global_position, Color(1, 0.3, 0.3))
		return true # Cancela a ação
		
	else:
		print("Lutador Bêbado conseguiu focar!")
		# Texto Branco/Verde indicando sucesso (opcional)
		if battle_manager.has_method("spawn_floating_text"):
			battle_manager.spawn_floating_text("Focado!", card_node.global_position, Color(0.5, 1, 0.5))
		return false # Permite a ação
