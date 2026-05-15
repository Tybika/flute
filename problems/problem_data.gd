extends Resource
class_name ProblemData

@export var title: String = ""
@export var context: Array[String] = []
@export var answer_line: Array[String] = []
@export var answer_position: Array[int] = []
@export var tags: Dictionary[String, Array] = {
	"variáveis": [],
	"tipos": [],
	"operadores": [],
	"sintaxe": ["(", ")", "[", "]", "{", "}", ":", ";", ",", "\"", ]
}
