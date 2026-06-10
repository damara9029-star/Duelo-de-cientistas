extends Node

# Esta função é chamada pelo BattleManager. 
# Usaremos uma trava ("stats_snapshot_taken") para garantir que rode apenas UMA vez (ao entrar).
func apply_aura_effect(battle_manager, card_node, friendlies_list):
	if card_node.has_meta("stats_snapshot_taken"):
		return
	var hand_count = 0
	if battle_manager.player_cards_on_battlefield.has(card_node):
		if is_instance_valid(card_node.player_hand_ref):
			hand_count = card_node.player_hand_ref.cards_in_hand.size()
	elif battle_manager.opponent_cards_on_battlefield.has(card_node):
		if is_instance_valid(battle_manager.opponent_hand):
			if "opponent_hand" in battle_manager.opponent_hand:
				hand_count = battle_manager.opponent_hand.opponent_hand.size()
			else:
				hand_count = battle_manager.opponent_hand.get_child_count()
	card_node.base_attack = hand_count
	card_node.base_health = hand_count
	var temp_atk = 0
	var temp_hp = 0
	if "temp_attack_bonus" in card_node: temp_atk = card_node.temp_attack_bonus
	if "temp_health_bonus" in card_node: temp_hp = card_node.temp_health_bonus
	card_node.current_attack = hand_count + temp_atk
	card_node.current_health = hand_count + temp_hp
	card_node.set_meta("stats_snapshot_taken", true)
	
	# Atualiza o visual
	if card_node.has_method("update_stats_display"):
		card_node.update_stats_display()
