## [4.0.1] - 2024/01/09
                 
* Compatible with current Flutter version. 

## [3.0.0] - 2021/10/05

* Breaking change: The two widgets in `AlignPositioned.relative()` are now named. To fix it, just
  name the first one `container`, and the second one `child`. For example:

  ```
  Center(
     child: AlignPositioned.relative(
         container: widgetA(),
         child: widgetB(),
         moveByContainerHeight: 0.5,
         moveByChildHeight: 0.5));
  ```

* `AlignPositioned.relative()` now has a parameter called `invert`, which controls which widget
  overlaps the other. If `invert` is `false` (the default), the `container` widget is below
  the `child` widget in the Z-axis (will be painted before). If `invert` is true, the `container`
  widget to be on top of the `child` widget, in the Z-axis (will be painted after).

## [2.0.4] - 2021/08/01

* Larger AlignPosition hitTest area.

## [2.0.3] - 2021/07/25

* Added AnimatedAlignPositioned.expand().

## [2.0.1] - 2021/04/16

* Details.

## [2.0.0] - 2021/03/05

* Nullsafety.

## [1.2.15] - 2020/11/23

* AnimChain.initialDelay (initial delay before starting the animation chain).

## [1.2.12] - 2020/11/20

* moveVerticallyByChildWidth.
* moveHorizontallyByChildHeight.
* moveVerticallyByContainerWidth.
* moveHorizontallyByContainerHeight.
* Better treatment of null values in AnimatedAlignPositioned.

## [1.2.9] - 2020/11/19

* Touch.middle.

## [1.2.8] - 2020/09/14

* Docs improvement.

## [1.2.7] - 2020/07/27

* Better error message when AlignPositioned is given infinite size.

## [1.2.6] - 2020/05/19

* Docs improvement.

## [1.2.5] - 2019/09/10

* Docs improvement.

## [1.2.3] - 2019/09/10

* Removed reverseDuration.

## [1.2.0] - 2019/08/29

* AlignPositioned.relative().

## [1.1.9] - 2019/08/26

* AnimChain.

## [1.1.8] - 2019/08/25

* AnimatedAlignPositioned.

## [1.1.5] - 2019/08/23

* ChildHeightRatio and childHeight may be present at the same time.
* Rotate.
* Transform.

## [1.1.0] - 2019/08/17

* AlignPositioned inside of a Stack.

## [1.0.8] - 2019/08/07

* Better docs.

## [1.0.7] - 2019/02/23

* Added size parameters.

## [1.0.6] - 2019/02/23

* Added moveByContainerWidth and moveByContainerHeight.

## [1.0.5] - 2019/02/22

* Code and examples.



