import 'package:flutter/material.dart';
import 'package:jjs/myprovider.dart';
import 'package:jjs/state_test.dart';
import 'package:provider/provider.dart';

class StateTestPage2 extends StatelessWidget {
  const StateTestPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyState state = context.read<MyState>();
    return Scaffold(
      appBar: AppBar(),
      // body: Center(
      //   child: ViewText(txt: state.v.toString()),
      // ),
      // floatingActionButton: ActionBtn2(),
      // floatingActionButton: ActionBtn(
      //   onPressed: () {},
      //   txt: state.v.toString(),
      // ),
      // floatingActionButton: MyStateActionBtn2(),
      // body: MyProviderBuilder<MyState2>(
      //   provider :(BuildContext context)=> context.watch<MyState2>(),
      //   builder : (context,MyState2 state) => Text(),
      // ),
      floatingActionButton: MyProviderBuilder<MyState>(
        provider: (BuildContext context)=> context.watch<MyState>(),
        ///state? null가능?
        builder : (context,MyState state) => FloatingActionButton(onPressed: state.add,child: Text(state.v.toString()),),
      ),
    );
  }
}

class MyStateActionBtn2 extends StatelessWidget {
  const MyStateActionBtn2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyState state = context.watch<MyState>();
    return ActionBtn2(
      txt: state.v.toString(),
      onPressed: state.add,
    );
  }
}

//어떻게 호출코드를 작성할것인가? 어떻게 써야할까?
class MyProviderBuilder<T> extends StatelessWidget {
  final T Function(BuildContext) provider;
  final Widget Function(BuildContext , T) builder;
  const MyProviderBuilder({required this.builder, required this.provider,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final T _state = this.provider(context);
    return this.builder(context, _state);
  }
}
