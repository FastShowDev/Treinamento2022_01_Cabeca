extends YSort

onready var sign_01 = $Sign01/StaticBody2D
onready var sign_02 = $SignT2_/StaticBody2D

onready var grave_01 = $IGrave/StaticBody2D
onready var grave_02 = $IGrave2/StaticBody2D
onready var grave_03 = $IGrave3/StaticBody2D
onready var grave_04 = $IGrave4/StaticBody2D

func _ready():
	sign_01.text = "Um baú com itens pode ser encontrado nas redondezas!"
	sign_02.text = "Cuidado, a bomba pode ser perigosa!"
	grave_01.text = "Um cemitério para aqueles que buscaram a glória na dungeon!\n"
	grave_02.text = "\t\tGeraldo\n1160-1268"
	grave_03.text = "Um túmulo sem nome"
	grave_04.text = "\t\tCahir\n1246 - 1268"
	pass
