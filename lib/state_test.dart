import 'package:flutter/material.dart';
import 'package:jjs/myprovider.dart';
import 'package:provider/provider.dart';

//네이티브 연동 참고하기

//stf
class StateTestPage extends StatefulWidget {
  StateTestPage({Key? key}) : super(key: key);

  @override
  State<StateTestPage> createState() => _StateTestPageState();
}

class _StateTestPageState extends State<StateTestPage> {
  //변수 - 상태
  int v = 0;

  @override
  void setState(VoidCallback fn) {
    print('setState 소환');
    super.setState(fn);
  }

  @override
  void initState() {
    //1번
    print('init');

    //빌드하고 바로 호출하고 싶을때 -> mount를 할 필요가 없다.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // print('add');
      // setState(() { this.v=2;});
    });

    if (this.mounted) return; // 빌드함수가 호출이 되면 true
    setState(() {});
    super.initState();
  }

  @override // 2번째
  void didChangeDependencies() {
    if (this.mounted) return; // 빌드함수가 호출이 되면 true
    setState(() {});
    print('did');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //없어질때
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ViewText(txt: this.v.toString()),
      ),
      // floatingActionButton: ActionBtn2(
      //   onPressed: () {
      //     this.setState(() {
      //       this.v +=1;
      //     });
      //   },
      //   txt: this.v.toString(),
      // ),
    );
  }
}

class ViewText extends StatelessWidget {
  final String txt;

  const ViewText({required this.txt, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.txt.toString(), style: TextStyle(fontSize: 30.0));
  }
}

//stf
class ActionBtn extends StatefulWidget {
  final String txt;
  final void Function() onPressed;

  const ActionBtn({required this.onPressed, required this.txt, Key? key})
      : super(key: key);

  @override
  State<ActionBtn> createState() => _ActionBtnState();
}

class _ActionBtnState extends State<ActionBtn> {
  //지역상태
  int? v;

  @override
  void initState() {
    super.initState();
    this.v = int.parse(this.widget.txt);
    if (!this.mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Text(this.v?.toString() ?? this.widget.txt),
      onPressed: () {
        if (this.v == null) return;
        setState(() {
          // this.widget.onPressed();
          this.v = this.v! + 1;
        });
      },
    );
  }
}



/// 역할
/// UI
/// State >> 두개가 같이오네 ? 이걸 감싸는게 필요하다 그래야 상태와 ui가 분리되니까!!!
/// ui는 ui로써 존재하자
class ActionBtn2 extends StatelessWidget {
  final String txt;
  final void Function()? onPressed;
  const ActionBtn2({required this.txt, this.onPressed,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // MyState state = context.watch<MyState>();
    return FloatingActionButton(
      onPressed: this.onPressed,
      child: Text(this.txt.toString()),
    );
  }
}


