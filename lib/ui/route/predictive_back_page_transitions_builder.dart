// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:animations/animations.dart';
import 'package:annix/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Used by [PageTransitionsTheme] to define a [MaterialPageRoute] page
/// transition animation that looks like the default page transition used on
/// Android U and above when using predictive back.
///
/// Currently predictive back is only supported on Android U and above, and if
/// this [PageTransitionsBuilder] is used by any other platform, it will fall
/// back to [ZoomPageTransitionsBuilder].
///
/// When used on Android U and above, animates along with the back gesture to
/// reveal the destination route. Can be canceled by dragging back towards the
/// edge of the screen.
///
/// See also:
///
///  * [FadeUpwardsPageTransitionsBuilder], which defines a page transition
///    that's similar to the one provided by Android O.
///  * [OpenUpwardsPageTransitionsBuilder], which defines a page transition
///    that's similar to the one provided by Android P.
///  * [ZoomPageTransitionsBuilder], which defines the default page transition
///    that's similar to the one provided in Android Q.
///  * [CupertinoPageTransitionsBuilder], which defines a horizontal page
///    transition that matches native iOS page transitions.
class PredictiveBackPageTransitionsBuilder extends PageTransitionsBuilder {
  /// Creates an instance of a [PageTransitionsBuilder] that matches Android U's
  /// predictive back transition.
  const PredictiveBackPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _PredictiveBackGestureDetector(
      route: route,
      builder: (context, event) {
        // Only do a predictive back transition when the user is performing a
        // pop gesture. Otherwise, for things like button presses or other
        // programmatic navigation, fall back to FadeThroughPageTransitionsBuilder.
        if (route.popGestureInProgress) {
          return _PredictiveBackPageTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            getIsCurrent: () => route.isCurrent,
            event: event,
            child: child,
          );
        }

        return const FadeThroughPageTransitionsBuilder().buildTransitions(
          route,
          context,
          animation,
          secondaryAnimation,
          child,
        );
      },
    );
  }
}

typedef PredictiveWidgetBuilder = Widget Function(
  BuildContext context,
  PredictiveBackEvent? event,
);

class _PredictiveBackGestureDetector extends StatefulWidget {
  const _PredictiveBackGestureDetector({
    required this.route,
    required this.builder,
  });

  final PredictiveWidgetBuilder builder;
  final PredictiveBackRoute route;

  @override
  State<_PredictiveBackGestureDetector> createState() =>
      _PredictiveBackGestureDetectorState();
}

class _PredictiveBackGestureDetectorState
    extends State<_PredictiveBackGestureDetector> with WidgetsBindingObserver {
  /// True when the predictive back gesture is enabled.
  bool get _isEnabled {
    return widget.route.isCurrent && widget.route.popGestureEnabled;
  }

  /// The back event when the gesture first started.
  PredictiveBackEvent? get startBackEvent => _startBackEvent;
  PredictiveBackEvent? _startBackEvent;
  set startBackEvent(PredictiveBackEvent? startBackEvent) {
    if (_startBackEvent != startBackEvent && mounted) {
      setState(() {
        _startBackEvent = startBackEvent;
      });
    }
  }

  /// The most recent back event during the gesture.
  PredictiveBackEvent? get currentBackEvent => _currentBackEvent;
  PredictiveBackEvent? _currentBackEvent;
  set currentBackEvent(PredictiveBackEvent? currentBackEvent) {
    if (_currentBackEvent != currentBackEvent && mounted) {
      setState(() {
        _currentBackEvent = currentBackEvent;
      });
    }
  }

  // Begin WidgetsBindingObserver.

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    final bool gestureInProgress = !backEvent.isButtonEvent && _isEnabled;
    if (!gestureInProgress) {
      return false;
    }

    widget.route.handleStartBackGesture(progress: 1 - backEvent.progress);
    startBackEvent = currentBackEvent = backEvent;
    return true;
  }

  @override
  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) {
    widget.route
        .handleUpdateBackGestureProgress(progress: 1 - backEvent.progress);
    currentBackEvent = backEvent;
  }

  @override
  void handleCancelBackGesture() {
    widget.route.handleCancelBackGesture();
    startBackEvent = currentBackEvent = null;
  }

  @override
  void handleCommitBackGesture() {
    widget.route.handleCommitBackGesture();
    startBackEvent = currentBackEvent = null;
  }

  // End WidgetsBindingObserver.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, currentBackEvent);
  }
}

/// Android's predictive back page transition.
class _PredictiveBackPageTransition extends StatelessWidget {
  const _PredictiveBackPageTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.getIsCurrent,
    required this.child,
    this.event,
  });

  // These values were eyeballed to match the native predictive back animation
  // on a Pixel 2 running Android API 34.
  static const double _scaleStartTransition = 0.85;
  static const double _weightForStartState = 2.0;
  static const double _weightForEndState = 98.0;
  static const double _screenWidthDivisionFactor = 10.0;
  static const double _xShiftAdjustment = 18.0;

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final ValueGetter<bool> getIsCurrent;
  final PredictiveBackEvent? event;
  final Widget child;

  // add decoration to background page
  Widget _secondaryAnimatedBuilder(BuildContext context, Widget? child) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface.withOpacity(0.4),
      ),
      child: child,
    );
  }

  // main page
  Widget _primaryAnimatedBuilder(BuildContext context, Widget? child) {
    final Size size = MediaQuery.sizeOf(context);
    final double screenWidth = size.width;
    final double xShift =
        (screenWidth / _screenWidthDivisionFactor) - _xShiftAdjustment;

    final Animatable<double> xShiftTween = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 0.0),
        weight: _weightForStartState,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: xShift, end: 0.0),
        weight: _weightForEndState,
      ),
    ]);
    final Animatable<double> scaleTween = TweenSequence<double>([
      // TweenSequenceItem<double>(
      //   tween: Tween<double>(
      //     begin: _scaleFullyOpened,
      //     end: _scaleFullyOpened,
      //   ),
      //   weight: _weightForStartState,
      // ),
      // TweenSequenceItem<double>(
      //   tween: Tween<double>(
      //     begin: 0.0,
      //     end: _scaleStartTransition,
      //   ),
      //   weight: _weightForStartState,
      // ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: _scaleStartTransition),
        weight: _weightForStartState,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: _scaleStartTransition, end: 1.0),
        weight: _weightForEndState,
      ),
    ]);
    final Animatable<double> fadeTween = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 10,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween(1.0),
        weight: 90,
      ),
    ]);

    return Transform.translate(
      offset: Offset(
          (event?.swipeEdge == SwipeEdge.right ? -1 : 1) *
              xShiftTween.animate(animation).value,
          0),
      child: Transform.scale(
        scale: scaleTween.animate(animation).value,
        child: Opacity(
          opacity: fadeTween.animate(animation).value,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular((1 - animation.value) * 50),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: secondaryAnimation,
      builder: _secondaryAnimatedBuilder,
      child: AnimatedBuilder(
        animation: animation,
        builder: _primaryAnimatedBuilder,
        child: child,
      ),
    );
  }
}
