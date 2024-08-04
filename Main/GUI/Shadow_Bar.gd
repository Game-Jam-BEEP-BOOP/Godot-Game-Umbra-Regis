extends ProgressBar

signal bar_empty

func update(drain_amount) -> void:
	Globals.currentShadow = clamp(Globals.currentShadow + drain_amount, 0, Globals.maxShadow)
	value = Globals.currentShadow * 100 / Globals.maxShadow
	if Globals.currentShadow == 0:
		bar_empty.emit()


func _on_gui_shadow_changed_gui(drain_amount: Variant) -> void:
	update(drain_amount)

