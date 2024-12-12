import 'package:flutter/material.dart';

/// ScoreSlider
/// A Custom Slider componente that mainly used for selecting a Score.
/// You can set a minimum and maximum score value and current score.
/// Current score can also be null so the user can choose the score without and default score entered.
/// 
/// Example
/// ```dart
/// ScoreSlider(
///   maxScore: 10,
///   backgroundColor: Colors.black,
///   thumbColor: Colors.blue,
///   scoreDotColor: Colors.white,
///   onScoreChanged: (newScore) {
///                     setState(() {
///                       _currentScore = newScore;
///                     });
///                },
///   )
/// ```
/// 
class ScoreSlider extends StatefulWidget {
  final double height;
  final int? score;
  final int maxScore;
  final int minScore;
  final Color? thumbColor;
  final Color? scoreDotColor;
  final Color? backgroundColor;
  final Function(int value)? onScoreChanged;
  final bool enabled;

  /// Create ScoreSlider Widgets.
  /// 
  /// You must provide [maxScore] parameter with the Maximum score allowed.
  /// 
  /// You can set also minimum score by using [minScore] Parameter. the defualt minScore is 0.
  /// 
  /// To get a call back when the user select score implement [onScoreChanged] callback
  /// 
  /// You can customize the Slider colors by using [thumbColor], [scoreDotColor] and [backgroundColor] parameter.
  /// If not specify, Colors will be take from the default ThemeData.
  /// 
  /// The default height of the Slider is 30, in order to set other height, use [height] parameter.
  const ScoreSlider({super.key, 
    required this.maxScore,
    this.minScore = 0,
    this.score,
    this.onScoreChanged,
    this.height = 40,
    this.thumbColor,
    this.scoreDotColor,
    this.backgroundColor,
    this.enabled = true,
  }):
        assert(minScore < maxScore);

  @override
  State<StatefulWidget> createState() => ScoreSliderState();
}

class ScoreSliderState extends State<ScoreSlider> {
  int? _currentScore;

  @override
  void initState() {
    super.initState();
    _currentScore = widget.score;
  }

  List<Widget> _dots(BoxConstraints size) {
    List<Widget> dots = [];

    for (var i = widget.minScore; i <= widget.maxScore; i++) {
      dots.add(
        Padding(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Icon(Icons.star, 
            color: i <= (_currentScore ?? 0) ? const Color(0xFFFBAA1A) : Colors.grey,
            size: size.maxWidth / (widget.maxScore + 2),
          ),
        )
      );
    }

    return dots;
  }

  void _handlePanGesture(BoxConstraints size, Offset localPosition) {
    if (widget.enabled == false) return;
    double socreWidth =
        size.maxWidth / (widget.maxScore - widget.minScore + 1);
    double x = localPosition.dx;
    int calculatedScore = (x ~/ socreWidth) + widget.minScore;
    if (calculatedScore != _currentScore &&
        calculatedScore <= widget.maxScore &&
        calculatedScore >= 0) {
      setState(() => _currentScore = calculatedScore);
      if (widget.onScoreChanged != null) {
        widget.onScoreChanged?.call(_currentScore ?? 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return GestureDetector(
          onHorizontalDragStart: (details) {
            _handlePanGesture(size, details.localPosition);
          },
          onHorizontalDragUpdate: (details) {
            _handlePanGesture(size, details.localPosition);
          },
          onHorizontalDragDown: (details) {
            _handlePanGesture(size, details.localPosition);
          },
          onHorizontalDragEnd: (details) {
            _handlePanGesture(size, details.localPosition);
          },
          child: Row(
            children: _dots(size),
          ),
        );
      },
    );
  }
}