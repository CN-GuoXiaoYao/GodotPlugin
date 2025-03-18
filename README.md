# LineMap2D
Custom GodotPlugin

en
2DLineMap Plugin Documentation
Introduction
2DLineMap is a Godot 4 plugin based on Line2D that allows developers to create textured 2D lines with dynamic control over point positions, rotation, scaling, and other properties. This plugin runs in @tool mode, enabling real-time visualization and editing within the Godot editor.

Installation
Place the plugin folder into res://addons/2DLineMap/.
In the Godot editor, go to Project Settings -> Plugins and enable 2DLineMap.
Add a LineMap2D node to your scene to start using the plugin.
Usage
In the Point category of the LineMap2D node, adjust PointCount to dynamically add or remove points.
When PositionLock is set to true, point distances will automatically adjust based on PointDistance.
When RotationLock is set to true, child node rotations will align with the direction of the line.
In the Item category, you can modify child node (Sprite2D) properties such as texture, flip, color, ZIndex, and material.
Property Overview
Point Settings

PointCount (Number of Points) – Controls the number of points in Line2D. Adjusting this value dynamically adds or removes points.
PointDistance (Distance Between Points) – When PositionLock is true, this value determines the spacing between points.
PositionLock (Position Lock)
true: Points are evenly spaced according to PointDistance.
false: Points can be freely adjusted.
RotationLock (Rotation Lock)
true: Child nodes automatically rotate to align with the line direction.
false: Child node rotations can be manually adjusted.
Item Settings (Child Node Properties)

texture2D (Texture) – Sets the texture for Sprite2D child nodes.
FlipH / FlipV (Horizontal/Vertical Flip) – Controls the flip direction of child node textures.
Modulate (Color) – Sets the SelfModulate color of Sprite2D.
ZIndex (Z Index) – Determines the rendering order of child nodes.
NodeMaterial (Material) – Sets the material of child nodes, allowing custom shaders.
Code Overview
update(): Updates UI, point distances, child node positions, and rotations.
updateDistance(): Adjusts point spacing when PositionLock is enabled.
updateSprite(): Synchronizes the position of Sprite2D elements.
createSprite(): Dynamically creates Sprite2D nodes to match the number of points.
removeSprite(): Removes excess Sprite2D nodes when reducing points.
rotateSprite(): Adjusts Sprite2D rotation to match the direction of Line2D points.
Notes
This plugin was developed within a short time frame and may contain bugs.
width_curve is added automatically when the node initializes,Please adjust as needed.
It is released under the MIT License, and contributions or improvements are welcome. Feel free to modify and share it as needed.

zh
LineMap2D 插件说明
简介:
LineMap2D 是一个基于 Line2D 的 Godot 4 插件，允许开发者创建带有纹理的 2D 线条，同时支持动态调整点的位置、旋转、缩放等属性。本插件支持在 工具模式（@tool） 下运行，可用于编辑器内的可视化设计。

安装:
将插件文件夹放入 res://addons/2DLineMap/。
在 Godot 编辑器中，打开 Project Settings -> Plugins，启用 2DLineMap。
在场景中添加 LineMap2D 节点，即可开始使用。

使用方法:
在 LineMap2D 节点的 Point 选项卡中，可以调整 PointCount 以动态添加或删除点。
PositionLock 设为 true 时，点与点之间的距离会根据 PointDistance 自动调整。
RotationLock 设为 true 时，子节点的旋转会自动对齐线条方向。
在 Item 选项卡中，可以调整子节点（Sprite2D）的纹理、翻转、颜色、ZIndex 等参数。

属性说明:
Point（点设置）
PointCount（点的数量） 控制 Line2D 点的数量，修改该值会动态增加或减少点。
PointDistance（点间距） 当 PositionLock 为 true 时，点与点之间的距离会根据此值自动调整。
PositionLock（位置锁定）
-true：点的位置会按照 PointDistance 进行均匀排列。
-false：可以自由调整 Line2D 点的位置。
RotationLock（旋转锁定）
-true：子节点的旋转会自动对齐线条方向。
-false：可以手动调整子节点的旋转。
Item（子节点设置）
texture2D（子节点纹理） 设定 Sprite2D 子节点的纹理。
FlipH / FlipV（水平/垂直翻转） 控制子节点纹理的翻转方向。
Modulate（颜色） 设置 Sprite2D 的 SelfModulate 颜色。
ZIndex（Z 索引） 控制子节点的渲染顺序。
NodeMaterial（材质） 设定子节点的 Material，可用于自定义着色器。

代码概述:
update()：更新 UI、点的距离、子节点的位置和旋转。
updateDistance()：当 PositionLock 为 true 时，调整点的间距。
updateSprite()：同步 Sprite2D 位置。
createSprite()：动态创建 Sprite2D 以匹配点的数量。
removeSprite()：移除多余的 Sprite2D。
rotateSprite()：根据 Line2D 点的方向调整 Sprite2D 旋转。

注意事项:
该插件开发时间较短，可能会有一些bug，节点初始化会自动添加width_curve，请根据需要自行调整，遵循MIT协议，欢迎大家补充修改完善以及分享。
