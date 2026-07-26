extends Control

@export var pages: Array[Control]
@export var current_page_idx: int = 0

func next_page() -> void:
	current_page_idx += 1
	if current_page_idx >= pages.size():
		current_page_idx = 0
	show_page(current_page_idx)

func prev_page() -> void:
	current_page_idx -= 1
	if current_page_idx < 0:
		current_page_idx = pages.size() - 1
	show_page(current_page_idx)

func show_page(idx: int) -> void:
	for page_idx in pages.size():
		var page: Control = pages[page_idx] 
		if page_idx == idx:
			page.visible = true
		else:
			page.visible = false


func _on_prev_page_pressed() -> void:
	prev_page()

func _on_next_page_pressed() -> void:
	next_page()
