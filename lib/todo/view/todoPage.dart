import 'package:flutter/material.dart';
import 'package:jjs/todo/model/todoModel.dart';
import 'package:jjs/todo/provider/todo_provider.dart';
import 'package:jjs/todo/view/todo_update_page.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatefulWidget {
  static const String path = '/';

  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  bool isDrag = false;
  TodoProvider? _provider;
  List<double>? dragPos;

  @override
  void didChangeDependencies() {
    _provider = context.watch<TodoProvider>();
    this.dragPos = List<double>.generate(_provider!.todo.length, (index) => 0);
    if (!this.mounted) return;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_provider == null) return Scaffold();
    final List<TodoModel> _todo = _provider!.todo;
    // this.dragPos = List<double>.generate(_todo.length, (index) => 0);
    // final List<TodoModel> _todo = _provider?.todo ?? [];
    return TodoView(
        // todos: _provider.todo,
        itemCount: _todo.length,
        onAddTab: (String input) {
          ///여기서 벨리데이션 하던지~~~
          if (input.isEmpty) return false;
          _provider!.add(todo: input);

          ///false 인 경우 팝업을 사용하지 않고 TodoView 내의 위젯을 만들어서 오류 상황을 표시할것.
          ///throw;
          return true;
        },
        itemBuilder: (BuildContext context, int index) {
          return Transform.translate(
            offset: Offset(this.dragPos![index], 0.0),
            child: GestureDetector(
              onPanStart: (DragStartDetails dd) {
                // print('start');
                this.isDrag = true;
              },
              onPanUpdate: (DragUpdateDetails dd) {
                if (!this.isDrag) return;
                print(dd);
                setState(() {
                  dragPos![index] += dd.delta.dx;
                });
                if (this.dragPos![index] <= -200) {
                  // print('remove');
                  _provider!.remove(_todo[index].id);
                  this.isDrag = false;
                }
                if (this.dragPos![index] >= 200) {
                  this.isDrag = true;
                  _provider!.select(index);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TodoUpdatePage()
                    ),
                  );
                }
              },
              onPanEnd: (DragEndDetails de) {
                this.isDrag = false;
                setState(() {
                  this.dragPos![index] = 0;
                });
              },
              child: ListTile(
                title: Text(
                  _todo[index].todo,
                ),
              ),
            ),
          );
        });
  }
}

class TodoView extends StatefulWidget {
  // final List<TodoModel> todos; // 의존하게되네? 그럼
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool Function(String) onAddTab;

  TodoView(
      {required this.onAddTab,
      required this.itemCount,
      required this.itemBuilder,
      Key? key})
      : super(key: key);

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  // TodoProvider? _provider;
  // @override
  // void didChangeDependencies() {
  //   _provider = context.watch<TodoProvider>();
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    this.controller.dispose();
    this.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Container(
              width: _size.width,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: this.focusNode,
                      // onChanged: (String a) {
                      //   print(a);
                      // }, // 입력되는 값을 제어하는 애
                      controller: this.controller,
                      // onSubmitted: (String s){
                      //   print(s); //
                      // },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // print('dddd : ${this.input}');
                      //분기할수 잇는 콜백....
                      if (!this.widget.onAddTab(this.controller.text)) return;
                      this.controller.clear();
                      this.focusNode.unfocus();
                      // focusNode.requestFocus();
                      // this.controller.text = 'sdf'; //setter도 가능
                      // print(this.controller.text);getter
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            // Container(
            // 여기서 텍스트로 안내
            // ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  // itemCount: this.widget.todos.length,
                  itemCount: this.widget.itemCount,
                  itemBuilder: this.widget.itemBuilder,
                  //       (context, index) {
                  //     return ListTile(
                  //       leading: Text('${this.widget.todos[index].id}'),
                  //       title: Text('${this.widget.todos[index].todo}'),
                  //       onTap: () {},
                  //     );
                  //   },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
