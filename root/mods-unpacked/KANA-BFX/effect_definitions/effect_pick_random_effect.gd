class_name KANAEffectPickRandomEffect
extends Effect


# TODOS:
# - Add custom get_text

const KANA_BFX_LOG_NAME_EFFECT_RANDOM_EFFECT := "KANA-BFX:EffectPickRandomEffect"

export (Array, Resource) var effects = []
export(Array, float, 0.01, 1.00, 0.01) var probabilities = []


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)


func apply_random_effect() -> void:
	var effect: Effect = KANA_pick_random()
	effect.apply()


func KANA_pick_random() -> Effect:
	if probabilities.empty():
		return KANA_pick_random_index()

	return KANA_pick_random_with_probabilities()


func KANA_pick_random_index() -> Effect:
	var random_index := Utils.get_random_int(0, effects.size() - 1)
	ModLoaderLog.debug("Picked index -> %s" % random_index, KANA_BFX_LOG_NAME_EFFECT_RANDOM_EFFECT)
	return effects[random_index]


func KANA_pick_random_with_probabilities() -> Effect:
	var random_value := randf()
	var cumulative_probabilities := []
	var current_value := 0.0
	var selected_effect: Effect

	# Calculate cumulative probabilities
	for probability in probabilities:
		current_value = current_value + probability
		if current_value > 1.0:
			ModLoaderLog.error("Cumulative probabilities should stay in the 0 to 1 range, please adjust your values." , KANA_BFX_LOG_NAME_EFFECT_RANDOM_EFFECT)
			break
		cumulative_probabilities.push_back(current_value)

	if not current_value == 1.0:
		ModLoaderLog.error("Cumulative probabilities should sum up to 1." , KANA_BFX_LOG_NAME_EFFECT_RANDOM_EFFECT)
		return null

	for i in effects.size():
		if random_value <= cumulative_probabilities[i]:
			selected_effect = effects[i]
			break

	ModLoaderLog.debug("Random value is -> %s" % random_value, KANA_BFX_LOG_NAME_EFFECT_RANDOM_EFFECT)

	return selected_effect
