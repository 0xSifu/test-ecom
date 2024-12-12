import 'package:flutter/material.dart';

import 'package:ufo_elektronika/constants/colors.dart';

class ModalBottomSheetDefault extends StatelessWidget {
  const ModalBottomSheetDefault({
    super.key,
    this.title = '',
    required this.child,
    this.closeButtonLeft = false,
    this.initialChildSize = 0.4,
    this.minChildSize = 0.2,
    this.maxChildSize = 0.9,
  });

  // title
  final String title;

  // widget child
  final Widget Function(ScrollController controller) child;

  // set button close to ledt
  final bool closeButtonLeft;

  /// The initial fractional value of the parent container's height to use when
  /// displaying the widget.
  ///
  /// Rebuilding the sheet with a new [initialChildSize] will only move
  /// the sheet to the new value if the sheet has not yet been dragged since it
  /// was first built or since the last call to [DraggableScrollableActuator.reset].
  ///
  /// The default value is `0.5`.
  final double initialChildSize;

  /// The minimum fractional value of the parent container's height to use when
  /// displaying the widget.
  ///
  /// The default value is `0.25`.
  final double minChildSize;

  /// The maximum fractional value of the parent container's height to use when
  /// displaying the widget.
  ///
  /// The default value is `1.0`.
  final double maxChildSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: !closeButtonLeft
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* ------------------------------ button close ------------------------------ */
              if (closeButtonLeft)
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColor.primaryColor),
                ),

              /* ---------------------------------- title --------------------------------- */
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  title.toUpperCase(),
                  style: const TextStyle(fontFamily: "FuturaLT", fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                ),
              ),

              /* ------------------------------ button close ------------------------------ */
              if (!closeButtonLeft)
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColor.primaryColor,),
                ),
            ],
          ),
          const Divider(height: 1, color: Color(0xFFEFEFEF),),
          const SizedBox(height: 10),
          Flexible(
            child: DraggableScrollableSheet(
              expand: false,
              initialChildSize: initialChildSize,
              minChildSize: minChildSize,
              maxChildSize: maxChildSize,
              builder: (context, scrollController) => child(scrollController)
            ),
          ),
        ],
      )
    );
  }
}
