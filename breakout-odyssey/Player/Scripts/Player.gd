class_name player extends CharacterBody2D

var move_speed: float = 50.0;
var cardinal_direction: Vector2 = Vector2.DOWN;
var direction: Vector2 = Vector2.ZERO;
var state: String = 'idle';
@onready var animation_player: AnimationPlayer = $AnimationPlayer;
@onready var sprite: Sprite2D =  $Sprite2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass; # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction.x = Input.get_action_strength('Right') - Input.get_action_strength('Left');
	direction.y = Input.get_action_strength('Down') - Input.get_action_strength('Up');
	velocity = direction * move_speed;
	
	if set_state() == true || set_direction() == true:
		update_animation();
	pass;

func _physics_process(delta):
	move_and_slide();
	pass;

func set_direction() -> bool:
	var new_direction: Vector2 = cardinal_direction;
	
	if new_direction == Vector2.ZERO:
		return false;
		
	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_direction == cardinal_direction:
		return false;
	
	cardinal_direction = new_direction;
	return true;
	
func set_state() -> bool:
	var new_state: String = 'idle' if direction == Vector2.ZERO else 'walk';
	
	if new_state == state:
		return false
	
	state = new_state;
	return true;

func update_animation() -> void:
	if state == 'idle':
		animation_player.stop()
	animation_player.play(state+'_'+animate_direction());
	return;
	
func animate_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return 'down';
	elif cardinal_direction == Vector2.UP:
		return 'up';
	elif cardinal_direction == Vector2.LEFT:
		return 'left';
	else:
		return 'right';
