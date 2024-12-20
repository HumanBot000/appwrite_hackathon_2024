import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import '../../../animations/ChallengeChoosing.dart';
import '../../../classes/Challenge.dart';
import '../../live/management/navigation.dart';
import 'management/setChallenge.dart';

class ChallengeChooser extends StatefulWidget {
  final int roomID;
  final User user;
  final List<Challenge> challenges;

  const ChallengeChooser(
      {super.key,
      required this.roomID,
      required this.user,
      required this.challenges});

  @override
  State<ChallengeChooser> createState() => _ChallengeChooserState();
}

class _ChallengeChooserState extends State<ChallengeChooser> {
  late String chosenChallenge;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _setChallenge();
  }

  Future<void> _setChallenge() async {
    chosenChallenge = await chooseChallenge(widget.challenges, widget.roomID);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: ChallengeDrawerAnimation(
          roomID: widget.roomID,
          user: widget.user,
          challenges: widget.challenges,
          finalChallenge: widget.challenges.firstWhere(
              (challenge) => challenge.description == chosenChallenge),
          wordDuration: const Duration(seconds: 1),
          finalWordDuration: const Duration(seconds: 3),
          onFinished: navigateToGameScreen),
    );
  }
}
