import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ReadMoreText extends StatefulWidget {
  const ReadMoreText({
    super.key,
    required this.text,
    this.maxLines = 4,
  });

  /// read more text
  final String text;

  /// max lines
  final int maxLines;

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final style = {
      "p": Style(
        color: const Color(0xFF333333),
        margin: Margins.zero,
        fontFamily: "FuturaLT",
        fontSize: FontSize(12)
      ),
      "body": Style(
        color: const Color(0xFF333333),
        margin: Margins.zero,
        fontFamily: "FuturaLT",
        fontSize: FontSize(12)
      ),
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !_expanded ? SizedBox(height: 80, child: Html(
          data: widget.text,
          style: style,
        )) : Html(
          data: widget.text,
          style: style,
        ),
        GestureDetector(
          onTap: () => setState(() {
            _expanded = !_expanded;
          }),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  _expanded ? 'Sembunyikan' : 'Baca Selengkapnya',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0060af),
                  ),
                ),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  color: const Color(0xFF0060af),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
