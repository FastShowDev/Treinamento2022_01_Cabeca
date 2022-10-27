extends YSort

onready var sign_01 = $Sign01
onready var sign_02 = $SignT2_

onready var grave_01 = $IGrave
onready var grave_02 = $IGrave2
onready var grave_03 = $IGrave3
onready var grave_04 = $IGrave4

func _ready():
	sign_01.text = "Um baú com itens pode ser encontrado nas redondezas!"
	sign_01.title = ""
	
	sign_02.text = "Cuidado, a bomba pode ser perigosa!"
	sign_02.title = ""
	
	grave_01.text = "Um cemitério para aqueles que buscaram a glória na dungeon!\n"
	grave_01.title = "Túmulo"
	
	grave_02.text = "\t\tGeraldo\n1160-1268"
	grave_02.title = "Túmulo"
	
	grave_03.text = "Um túmulo sem nome"
	grave_03.title = "Túmulo"
	
	grave_04.text = "\t\tCahir\n1246 - 1268"
	grave_04.title = "Túmulo"
	
