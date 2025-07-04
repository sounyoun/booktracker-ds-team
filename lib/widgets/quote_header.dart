import 'dart:async';
import 'package:flutter/material.dart';

class QuoteHeader extends StatefulWidget {
  const QuoteHeader({super.key});

  @override
  State<QuoteHeader> createState() => _QuoteHeaderState();
}

class _QuoteHeaderState extends State<QuoteHeader> {
  final List<String> _quotes = const [
    "책은 마음의 양식이다.",
    "독서는 과거와 현재와 미래를 잇는 다리다.",
    "하루라도 책을 읽지 않으면 입안에 가시가 돋는다. - 안중근",
    "책은 인생의 스승이다.",
    "많이 읽고, 깊이 생각하라.",
    "책은 인간을 자유롭게 한다.",
    "읽는다는 것은 사유하는 것이다.",
    "독서는 영혼의 대화이다.",
    "책을 읽는다는 것은 세계를 여행하는 것이다.",
    "좋은 책은 친구와 같다.",
  ];

  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _quotes.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
      child: Padding(
        key: ValueKey<String>(_quotes[_currentIndex]),
        padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
        child: Text(
          '"${_quotes[_currentIndex]}"',
          style: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            color: Color(0xFF5D4037),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}