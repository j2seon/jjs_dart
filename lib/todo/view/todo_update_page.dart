import 'package:flutter/material.dart';
import 'package:jjs/todo/model/todoModel.dart';
import 'package:jjs/todo/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoUpdatePage extends StatelessWidget {
  static const path = '/todo/update';

  const TodoUpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoProvider _provider = context.watch<TodoProvider>();
    final _selected = _provider.selectTodoModel;
    return TodoUpdateView(
      todo: _selected!.todo,
      onUpdateTab: (String text) {
        if(text.isEmpty) return false;
        ///todo 변경
        // TodoModel(id: _selected.id, todo: text, isCheck: _selected.isCheck);
        //원시값을 넘겨줌으로서 의존을 끊는다.
        final String _id = _selected.id; //전부나열해주는게 친절 ㅎㅎ
        final bool _check = _selected.isCheck;
        _provider.update(id: _id, todo: text, isCheck:_check);
        return true;
        //onUpdateTab: _provider.update, 방법도 있다.
      },
    );
  }
}

class TodoUpdateView extends StatefulWidget {
  final String? todo;
  final bool Function(String a)? onUpdateTab;
  const TodoUpdateView({required this.todo, Key? key, this.onUpdateTab}) : super(key: key);

  @override
  State<TodoUpdateView> createState() => _TodoUpdateViewState();
}

class _TodoUpdateViewState extends State<TodoUpdateView> {

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(this.widget.todo!,),
            TextField(
              controller: this.controller,
              focusNode: focusNode,
            ),
            IconButton(
              onPressed: () {
                if(!this.widget.onUpdateTab!(this.controller.text)) return;
                this.controller.clear();
                this.focusNode.unfocus();
              },
              icon: Icon(Icons.update),
            )
          ],
        ),
      ),
    );
  }
}
