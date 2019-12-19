extends Control

onready var groupLabel = get_node("VBoxContainer/HBoxContainer/Label")
onready var lineEdit = get_node("VBoxContainer/HBoxContainer/LineEdit")
onready var chatLog = get_node("VBoxContainer/RichTextLabel")

var groups = [
	{'name': 'Team', 'color': '#00abc7'},
	{'name': 'Match', 'color': '#ffdd8b'},
	{'name': 'Global', 'color': '#ffffff'}
]
var group_index = 0
var user_name = 'Kilo'

func _ready():
	lineEdit.connect("text_entered", self,'text_entered')
	change_group(0)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			lineEdit.grab_focus()
		if event.pressed and event.scancode == KEY_ESCAPE:
			lineEdit.release_focus()
		if event.pressed and event.scancode == KEY_TAB:
			change_group(1)

func change_group(value):
	group_index += value
	if group_index > (groups.size() - 1):
		group_index = 0
	groupLabel.text = '[' + groups[group_index]['name'] + ']'
	groupLabel.set("custom_colors/font_color", Color(groups[group_index]['color']))
	
func add_message(username, text, group = 0, color = ''):
	chatLog.bbcode_text += '\n' 
	if color == '':
		chatLog.bbcode_text += '[color=' + groups[group]['color'] + ']'
	else:
		chatLog.bbcode_text += '[color=' + color + ']'
	if username != '':
		chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]'


func text_entered(text):
	if text =='/h':
		add_message('', 'There is no help message yet!', 0, '#ff5757')
		lineEdit.text = ''		
		return
	if text != '':
		add_message(user_name, text, group_index)
		# Here you have to send the message to the server
		print(text)
		lineEdit.text = ''
