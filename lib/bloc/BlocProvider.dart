import 'package:flutter/widgets.dart';
import 'Bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;
  final Function init;

  const BlocProvider({Key key, @required this.bloc, @required this.child, this.init})
      : super(key: key);

  // 2
  static T of<T extends Bloc>(BuildContext context) {
//    final type = _providerType<BlocProvider<T>>();
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }

  // 3
  static Type _providerType<T>() => T;

  @override
  State createState() => _BlocProviderState(init);

}

class _BlocProviderState extends State<BlocProvider> {
  Function init;

  _BlocProviderState(this.init);

  @override
  void initState() {
    super.initState();
    init();
  }
  // 4
  @override
  Widget build(BuildContext context) => widget.child;

  // 5
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}