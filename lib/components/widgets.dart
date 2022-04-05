import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/wallet/initwallet.dart';
import 'package:noob_wallet/components/colors.dart';

Widget appBar(
    {required Widget left, required String title, required Widget right}) {
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          left,
          Text(
            title,
            style: const TextStyle(
              color: mainColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          right,
        ],
      ),
    ),
  );
}

Widget card({
  double width = double.infinity,
  double padding = 20,
  required Widget child,
}) {
  return Container(
    width: width,
    padding: EdgeInsets.all(padding),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 228, 226, 226),
          offset: Offset(4, 4),
          blurRadius: 10,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Color.fromARGB(255, 228, 226, 226),
          offset: Offset(-4, -4),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    ),
    child: child,
  );
}

class Exchange extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function press;
  final Color color;
  const Exchange(
      {Key? key,
      required this.text,
      required this.icon,
      required this.press,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton.icon(
        icon: icon,
        label: Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 5, 71, 102),
            fontFamily: 'OpenSans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          shadowColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 13, 36, 47).withOpacity(1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
        ),
        onPressed: () => press(),
      ),
    );
  }
}

/// {@template hero_dialog_route}
/// Custom [PageRoute] that creates an overlay dialog (popup effect).
///
/// Best used with a [Hero] animation.
/// {@endtemplate}
class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}

class AddPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  final Widget child;
  const AddPopupCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'tag',
          child: Container(
            width: 450,
            height: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.only(
              right: 20.0,
              left: 30.0,
              top: 20.0,
              bottom: 20.0,
            ),
            child: Column(
              children: <Widget>[
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
Material(
            color: lightColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'New todo',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a note',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),*/