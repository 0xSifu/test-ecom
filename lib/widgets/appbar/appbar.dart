import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar_search_input.dart';

class UEAppBar extends PreferredSize {

  // If title is not null search bar is hidden
  final String? title;
  final Widget? titleWidget;
  final List<Widget> actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  final String searchHint;
  final bool transparent;
  final Function(String)? onSearchSubmitted;
  final Function? onBackClicked;

  /// show notifivation icon
  final bool showNotification;

  /// show cart icon
  final bool showCart;
  
  const UEAppBar({
    super.key,
    required this.title,
    this.titleWidget,
    this.searchHint = 'Cari di UFO Elektronika',
    this.transparent = false,
    this.onSearchSubmitted,
    this.showNotification = true,
    this.showCart = true,
    this.actions = const [],
    this.bottom,
    this.leading,
    Size? preferredSize,
    this.onBackClicked
  }): super(child: const SizedBox(width: 0, height: 0), preferredSize: preferredSize ?? const Size.fromHeight(34));

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      leading: leading ?? (Navigator.canPop(context) ? IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: const Icon(
          Icons.chevron_left,
          size: 36,
        ),
          onPressed: () {
            if (onBackClicked != null) {
              onBackClicked?.call();
            } else {
              Get.back();
            }
          }
      ) : null),
      leadingWidth: 36,
      elevation: 0,
      backgroundColor: transparent == false
              ? Colors.white
              : Colors.transparent,
      title: Column(
        children: [
          if (title != null)
            Text(title!.toUpperCase()) 
          else titleWidget ?? Padding(
            padding: EdgeInsets.only(left: Navigator.canPop(context) ? 0 : 15),
            child: AppBarSearchInput(
              hintText: searchHint,
              onSubmitted: onSearchSubmitted
            ),
          )
        ],
      ),
      systemOverlayStyle: !transparent ? SystemUiOverlayStyle.dark : null,
      titleSpacing: 0,
      actions: [
        ActionBarWidget(
          transparentBackground: transparent,
          showNotification: showNotification,
          showCart: showCart,
        ),
        ...actions
      ],
      bottom: bottom,
    );
  }


}