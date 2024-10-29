## 5.0.0

* Sponsored by [MyText.ai](https://mytext.ai)

[![](./example/SponsoredByMyTextAi.png)](https://mytext.ai)

## 4.0.1 
                 
* Compatible with current Flutter version, as of 2024/01/09. 

## 3.0.0

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

## 2.0.4

* Larger AlignPosition hitTest area.

## 2.0.3

* Added `AnimatedAlignPositioned.expand()`.

## 2.0.1

* Details.

## 2.0.0

* Nullsafety.

## 1.2.15

* `AnimChain.initialDelay` (initial delay before starting the animation chain).

## 1.2.12

* moveVerticallyByChildWidth.
* moveHorizontallyByChildHeight.
* moveVerticallyByContainerWidth.
* moveHorizontallyByContainerHeight.
* Better treatment of null values in AnimatedAlignPositioned.

## 1.2.9

* `Touch.middle`.

## 1.2.7

* Better error message when AlignPositioned is given infinite size.

## 1.2.6

* Docs improvement.

## 1.2.3

* Removed reverseDuration.

## 1.2.0

* AlignPositioned.relative().

## 1.1.9

* AnimChain.

## 1.1.8

* AnimatedAlignPositioned.

## 1.1.5

* ChildHeightRatio and childHeight may be present at the same time.
* Rotate.
* Transform.

## 1.1.0

* AlignPositioned inside a Stack.

## 1.0.7

* Added size parameters.

## 1.0.6

* Added `moveByContainerWidth` and `moveByContainerHeight`.

## 1.0.5

* Code and examples.
