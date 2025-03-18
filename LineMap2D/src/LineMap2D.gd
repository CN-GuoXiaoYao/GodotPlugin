@tool
extends Line2D

@export_category("Point")

##en:The number of points in Line2D can be created using Line2D's built-in method, or you can directly modify this value to dynamically increase or decrease
##zh:Line2D中点的数量，可以使用Line2D自带的方法创建，也可以直接修改这个数值，会动态的添加或者减少
@export var PointCount : int = 0:
	set(value):
		PointCount = value
		update()
##en:Distance between points in Line2D, this property will not be used when PositionLock is false
##zh:Line2D中点与点之间的距离，当PositionLock为false时，该属性不会使用
@export var PointDistance : float = 50:
	set(value):
		PointDistance = value
		updateDistance()
##en:The distance between points is automatically adjusted according to PointDistance when this property is true, and the position of the Line2D points (not child nodes) can be freely modified when this property is false
##zh:该属性为true时，点与点之间的距离按照PointDistance自动修改，该属性为false时，可以随意修改Line2D点的位置(不是子节点)
@export var PositionLock : bool = true
##en:If this property is true, the rotation of the texture corresponding to the point will be automatically modified, and if this property is false, you can modify the rotation of the child node corresponding to the point at will
##zh:该属性为true时，点对应的纹理的旋转会自动修改，该属性为false时，可以随意修改点对应的子节点的旋转
@export var RotationLock : bool = true

@export_category("Item")
##en:The texture of the child node
##zh:子节点的纹理
@export var texture2D : Texture2D:
	set = updateTexture
##en:Horizontal flip of child node texture
##zh:子节点纹理的水平翻转
@export var FlipH  : bool = false:
	set = updateFlipH
##en:Vertical flip of child node texture
##zh:子节点纹理的垂直翻转
@export var FlipV  : bool = false:
	set = updateFlipV
##en:SelfModulate of Child Node
##zh:子节点的SelfModulate
@export var Modulate : Color = Color(1,1,1):
	set = updateColor
##en:ZIndex of child node
##zh:子节点的ZIndex索引
@export var ZIndex : int = 0:
	set = updateZIndex
##en:Material of child node
##zh:子节点的Material材质
@export var NodeMaterial : Material:
	set = updateMaterial

var NextPointCount : int = 0
var Sprites : Array = []
var lastHash = null

func _ready():
	PointCount = get_point_count()
	NextPointCount = PointCount
	width_curve = Curve.new()
	
	for child in get_children():
		child.queue_free()
		
	await get_tree().process_frame
	update()

func _process(delta: float):
	var pointHash = hash(points)
	if lastHash != pointHash:
		lastHash = pointHash
		call_deferred("update")
		
func update():
	updateUI()
	updateDistance()
	updateSprite()
	createSprite()

##en:Checker UI update
##zh:检查器UI更新
func updateUI():
	if NextPointCount>PointCount:
		for i in range(0,NextPointCount-PointCount):
			remove_point(get_point_count()-1)
			NextPointCount -= 1
			removeSprite()
	elif get_point_count() > PointCount:
		PointCount += 1
		NextPointCount += 1
	elif PointCount > get_point_count():
		var newPoint = get_point_position(get_point_count()-1)
		add_point(Vector2(newPoint.x+PointDistance,newPoint.y))
		NextPointCount += 1
	
	Sprites.clear()
	for child in get_children():
		if child is Sprite2D:
			Sprites.append(child)

##en:The distance between Line2D points is updated
##zh:Line2D点之间的距离更新
func  updateDistance():
	var count = get_point_count()
	if count < 2||!PositionLock:
		return
		
	var firstPoint = points[0]
	
	for i in range(count - 2, -1, -1):
		var dir = (points[i] - points[i + 1]).normalized()
		points[i] = points[i + 1] + dir * PointDistance
		
	points[0] = firstPoint
	
	for i in range(1, count):
		var dir = (points[i] - points[i - 1]).normalized()
		points[i] = points[i - 1] + dir * PointDistance

##en:Texture position update
##zh:纹理位置更新
func updateSprite():
	var count = min(Sprites.size(),get_point_count())
	for i in range(count):
		Sprites[i].position = points[i]
	if RotationLock:
		rotateSprite()

##en:Texture creation
##zh:纹理创建

func createSprite():
	for i in range(get_point_count()-Sprites.size() - 1):
		var position = get_point_position(i)
		var sprite = Sprite2D.new()
		sprite.texture = texture2D
		sprite.position = position
		sprite.z_index = ZIndex
		self.add_child(sprite)
		
		sprite.owner = self.get_owner()
		Sprites.append(sprite)

##en:Texture removal
##zh:纹理移除
func removeSprite():
	var sprite = Sprites.pop_back()
	if sprite and sprite.is_inside_tree():
		remove_child(sprite)
		sprite.queue_free()
		Sprites.remove_at(Sprites.size()-1)

##en:Texture rotation
##zh:纹理旋转
func rotateSprite():
	if get_point_count() < 2:
		return
	
	for i in range(get_point_count()):
		if i < Sprites.size():
			if i < get_point_count() - 1:
				var dir = (get_point_position(i + 1) - get_point_position(i)).normalized()
				Sprites[i].rotation = dir.angle()
			else:
				var dir = (get_point_position(i - 1) - get_point_position(i - 2)).normalized()
				Sprites[i].rotation = dir.angle()

func updateTexture(value):
	texture2D = value
	for sprite in Sprites:
		sprite.texture = texture2D
func updateFlipH(value):
	FlipH = value
	for sprite in Sprites:
		sprite.flip_h = FlipH
func updateFlipV(value):
	FlipV = value
	for sprite in Sprites:
		sprite.flip_v = FlipV
func updateColor(value):
	Modulate = value
	for sprite in Sprites:
		sprite.self_modulate = Modulate
func updateZIndex(value):
	ZIndex = value
	for sprite in Sprites:
		sprite.z_index = ZIndex
func updateMaterial(value):
	NodeMaterial = value
	for sprite in Sprites:
		sprite.material = NodeMaterial
