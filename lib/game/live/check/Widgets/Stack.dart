import 'dart:math';
import 'package:appwrite_hackathon_2024/classes/Challenge.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../../animations/GradientText.dart';
import '../../Widgets/Timer.dart';

class CheckingStack extends StatefulWidget {
  final Duration timeRemaining;
  final Challenge challenge;
  const CheckingStack(
      {super.key, required this.timeRemaining, required this.challenge});

  @override
  State<CheckingStack> createState() => _CheckingStackState();
}

class _CheckingStackState extends State<CheckingStack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Center(
              child: GradientText(
                "Do these Assets fulfill the given Challenge?",
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.onSecondary,
                    Theme.of(context).colorScheme.primary,
                  ],
                ),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          CountdownTimer(
            initialDuration: widget.timeRemaining,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "If more than 50% of Users say that this asset doesn't fulfill the challenge, it will be deleted. Please note that this isn't the place to report inappropriate content.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              // Centering the swipeable stack
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SwipableStack(
                  allowVerticalSwipe: false,
                  overlayBuilder: (context, properties) {
                    final opacity = min(properties.swipeProgress, 1.0);
                    final isRight =
                        properties.direction == SwipeDirection.right;
                    final isLeft = properties.direction == SwipeDirection.left;

                    if (isRight) {
                      return Opacity(
                        opacity: isRight ? opacity : 0,
                        child: CardLabel.right(),
                      );
                    } else if (isLeft) {
                      return Opacity(
                        opacity: isLeft ? opacity : 0,
                        child: CardLabel.left(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  builder: (context, properties) {
                    return Align(
                      alignment: Alignment.center,
                      child: Card(
                        elevation: 6.0,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        shadowColor: Colors.grey.withOpacity(0.5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Asset Image
                            Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://picsum.photos/400/300?random=${properties.index}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Asset #${properties.index + 1}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  onSwipeCompleted: (swipeIndex, direction) {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SwipeDirectionColor {
  static const right = Color.fromRGBO(70, 195, 120, 1);
  static const left = Color.fromRGBO(220, 90, 108, 1);
}

const _labelAngle = pi / 2 * 0.2;

class CardLabel extends StatelessWidget {
  const CardLabel._({
    required this.color,
    required this.label,
    required this.angle,
    required this.alignment,
  });

  factory CardLabel.right() {
    return const CardLabel._(
      color: SwipeDirectionColor.right,
      label: 'CORRECT',
      angle: -_labelAngle,
      alignment: Alignment.topLeft,
    );
  }

  factory CardLabel.left() {
    return const CardLabel._(
      color: SwipeDirectionColor.left,
      label: 'WRONG',
      angle: _labelAngle,
      alignment: Alignment.topRight,
    );
  }

  final Color color;
  final String label;
  final double angle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(
        vertical: 36,
        horizontal: 36,
      ),
      child: Transform.rotate(
        angle: angle,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
              width: 4,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(6),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
              color: color,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}