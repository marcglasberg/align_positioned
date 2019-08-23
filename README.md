# align_positioned

**Why is this widget an indispensable tool?** 

When your desired layout feels too complex for Columns and Rows, `AlignPositioned` widget is a real life saver.
Flutter is very composable, which is good, but sometimes it's unnecessarily complex to translate some layout 
requirement into a composition of simpler widgets. 

The `AlignPositioned` aligns, positions, sizes, rotates and transforms its child 
in relation to both the container and the child itself.
In other words, it lets you easily and **declaratively** 
define where and how a widget should appear in relation to another. 

For example, *you can tell it to position the top-left of its child at 15 pixels
to the left of the top-left corner of the container, 
plus move it two thirds of the child's height to the bottom plus 10 pixels, 
and then rotate 15 degrees.*
Do you even know how to start doing this by composing basic Flutter widgets?
Maybe, but with `AlignPositioned` it's much easier, and it takes a single widget.

The `AlignPositioned` widget is specially helpful for **animations**, 
since you can just calculate the final position and size you want for each frame. 
Without it you may find yourself having to animate a composition of widgets.

## How it works 

Add align_positioned [as a dependency](https://pub.dartlang.org/packages/align_positioned#-installing-tab-) 
in your `pubspec.yaml` file,
then import it:

    import 'package:align_positioned/align_positioned.dart';

Pass the `AlignPositioned` a `child`, and then one or more of the following parameters:
 
    AlignPositioned(
       child: child,           
       alignment: ...,
       dx: ...,
       dy: ...,
       moveByChildWidth: ...,
       moveByChildHeight: ...,
       moveByContainerWidth: ...,
       moveByContainerHeight: ...,
       childWidth: ...,
       childHeight: ...,
       minChildWidth: ...,
       minChildHeight: ...,
       maxChildWidth: ...,
       maxChildHeight: ...,
       childWidthRatio: ...,
       childHeightRatio: ...,
       minChildWidthRatio: ...,
       minChildHeightRatio: ...,
       maxChildWidthRatio: ...,
       maxChildHeightRatio: ...,
       rotateDegrees: ...,
       matrix4Transform: ...,
       wins: ...,
       touch: ...,       
       ); 
   
Let's study each parameter in detail:
        
## Align and Position parameters

The `alignment` parameter works as expected. For example, 
`Alignment.bottomRight` represents the bottom right of the container, 
and `Alignment(0.0, 0.0)` represents the center of the container. 
The distance from -1.0 to +1.0 is the distance from one side of the rectangle 
to the other side of the rectangle. 

If `touch` is `Touch.inside`, then `alignment` works just like the alignment 
for the `Align` widget, aligning the child inside of the container. 

However, if `touch` is `Touch.outside`, then the alignment happens outside of 
the container. 

As another example, if `touch` is `Touch.inside`, then `Alignment(1.0, 0.0)` makes the child's
right side touch the right side of the container (it touches the container from the **inside**). 

But if `touch` is `Touch.outside`, then `Alignment(1.0, 0.0)` makes the child's 
left side touch the right side of the container (it touches the container from the **outside**).

Parameters `dx` and `dy` can be positive or negative, and move the child horizontally and 
vertically, in pixels.

Parameters `moveByChildWidth` and `moveByChildHeight` can be positive or negative, and move the child 
horizontally and vertically, but the unit here is not pixels, but child widths and heights. 

Parameters `moveByContainerWidth` and `moveByContainerHeight` can be positive or negative, and move the child 
horizontally and vertically, but the unit here is not pixels, but container widths and heights.

## Align and Position Examples

The below image shows the center of the child positioned 15 pixels to the right 
of the top-left corner of the container: 

![alt text](./example/alignPos1.png)
  
    AlignPositioned(
       child: child,        
       alignment: Alignment.topLeft,
       touch: Touch.inside,
       dx: 15.0, // Move 4 pixels to the right. 
       moveByChildWidth: -0.5, // Move half child width to the left.  
       moveByChildHeight: -0.5); // Move half child height to the top.
       
Then, to move the child one container width to the right, and one container height to the bottom: 

![alt text](./example/alignPos2.png)
  
    AlignPositioned(
       child: child,        
       alignment: Alignment.topLeft,
       touch: Touch.inside,
       dx: 15.0, // Move 4 pixels to the right. 
       moveByChildWidth: -0.5, // Move half child width to the left.  
       moveByChildHeight: -0.5, // Move half child height to the top.
       moveByContainerWidth: 1.0, // Move one container width to the right.
       moveByContainerHeight: 1.0); // Move one container height to the bottom.               

Please, check the [example tab](https://pub.dartlang.org/packages/align_positioned#-example-tab-)
for the effects seen below:

![alt text](./example/alignPos3.png)

## Size Parameters

Optionally, you can also define the child size:

- `childWidth` is the child width, in pixels.

- `childHeight` is the child height, in pixels.

- `minChildWidth` is the minimum width, in pixels. It has precedence over `childWidth`.  

- `minChildHeight` is the minimum height, in pixels. It has precedence over `childHeight`.

- `maxChildWidth` is the maximum width, in pixels. It has precedence over `childWidth`.

- `maxChildHeight` is the maximum height, in pixels. It has precedence over `childHeight`.

- `childWidthRatio` is the child width, as a fraction of the container width.
   If between 0.0 and 1.0, the child will be smaller than its container.
   If more than 1.0, the child will be larger than its container. 
   If you define both `childWidthRatio` and `childWidth` they will be added.

- `childHeightRatio` is the child height, as a fraction of the container height.
   If between 0.0 and 1.0, the child will be smaller than its container.
   If more than 1.0, the child will be larger than its container.
   If you define both `childHeightRatio` and `childHeight` they will be added.   

- `minChildWidthRatio` is the minimum child width, as a fraction of the container width. 
   It has precedence over `childWidth`. If both `minChildWidth` and `minChildWidthRatio` 
   are defined, both will be applied (the minimum will be the larger one). 

- `minChildHeightRatio`. is the minimum child height, as a fraction of the container height. 
   It has precedence over `childHeight`. If both `minChildHeight` and `minChildHeightRatio` 
   are defined, both will be applied (the minimum will be the larger one).

- `maxChildWidthRatio` is the maximum child width, as a fraction of the container width. 
   It has precedence over `childWidth`. If both `maxChildWidth` and `maxChildWidthRatio` 
   are defined, both will be applied (the maximum will be the smaller one). 

- `maxChildHeightRatio` is the maximum child height, as a fraction of the container height. 
   It has precedence over `childHeight`. If both `maxChildHeight` and `maxChildHeightRatio` 
   are defined, both will be applied (the maximum will be the smaller one).

- `wins` decides what happens if the minimum size is larger then the maximum size.
   If `wins` is `Wins.min`, the default, the minimum size will be used.  
   If `wins` is `Wins.max`, the maximum size will be used.

## Rotate and Transform

Optionally, you can also define rotation and transformation:

- `rotateDegrees` is the rotation, in degrees (1 turn is 360 degrees).
  The position of the axis of the rotation (the "origin") depends on the
  `alignment` parameter and the parent. So, for example, `Alignment.center`
  means the axis of rotation is at the center of the parent.
  
- `matrix4Transform` lets you apply any transformation to the child.
   This uses Matrix4Transform instead of Matrix4, since it's easier to use.
   However, you can still use Matrix4 directly with the constructor `Matrix4Transform.from(matrix4)`.

![alt text](./example/alignPos4.png)

## Using AlignPositioned inside of a Stack

A `Stack` positions its children relative to the edges of its box.
The `Stack` documentation contains this text:

> _In particular, when using a Stack you can't position
> children relative to their size or the stack's own size._

However, by using `AlignPositioned` you can do precisely that:
position (and size, rotate and transform) children relative to their size or the Stack's own size,
and consequently in relation to the other widgets inside of the Stack.

If you recall how a `Stack` works, each of its child widgets is either positioned or non-positioned. 
The stack sizes itself to contain all the non-positioned children, 
which are positioned according to the stacks's `alignment` parameter.
Next, the positioned children are laid out. 

If you use the AlignPositioned default constructor and put it inside of a Stack it will be a **non-positioned** child.

To create a **positioned** widget, use the `AlignPositioned.expand()` constructor.
The `AlignPositioned` will then expand and fix itself to the corners of the `Stack`. 
In other words, the `Stack` will size itself to their other non-positioned widgets, 
and then you can use the `AlignPositioned` to layout its child in relation to the `Stack`.

Example:
```
Stack(
  children: [      
    Container(...),
    Positioner(child: Container(...)),                                        
    AlignPositioned(...),
    AlignPositioned.expand(...),
    ...
    ]);
```                

***

*The Flutter packages I've authored:* 
* <a href="https://pub.dev/packages/async_redux">async_redux</a>
* <a href="https://pub.dev/packages/align_positioned">align_positioned</a>
* <a href="https://pub.dev/packages/network_to_file_image">network_to_file_image</a>
* <a href="https://pub.dev/packages/align_positioned">align_positioned</a> 
* <a href="https://pub.dev/packages/back_button_interceptor">back_button_interceptor</a>
* <a href="https://pub.dev/packages/indexed_list_view">indexed_list_view</a> 
* <a href="https://pub.dev/packages/animated_size_and_fade">animated_size_and_fade</a>

---<br>_https://github.com/marcglasberg_<br>
_https://twitter.com/marcglasberg_<br>
_https://stackoverflow.com/users/3411681/marcg_<br>
_https://medium.com/@marcglasberg_<br>

