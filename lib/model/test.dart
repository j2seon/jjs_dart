// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class Check {
//   int x;
//   int y;
//   bool isBlack;
//
//   Check({required this.x, required this.y,this.isBlack=false});
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final List<List<int>> tableData =
//       new List.generate(19, (int i) => new List.generate(19, (int e) => e));
//
//   List<List<Check>> list() {
//     return tableData
//         .map<List<Check>>((e) =>
//             e.map<Check>((i) => Check(x: tableData.indexOf(e), y: i)).toList())
//         .toList();
//   }
//
//   bool isBlack = false;
//   final List<int> data = List<int>.generate(19, (index) => index);
//   final List<Check> click= [];
//
//   Color checked(int x, int y){
//     final List<Check?> check = this.click.map<Check?>((e){
//       if(e.x == x && e.y == y) return e;
//     }).toList().where((check) => check.isBlack).toList();
//
//     return check[0]!.isBlack ? Colors.black : Colors.white ;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<List<Check>> _data = list();
//
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//             children: _data
//                 .map<Widget>(
//                   (e) => Expanded(
//                     child: Row(
//                       children: e
//                           .map<Widget>(
//                             (i) => Expanded(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   print('${i.x} ${i.y}');
//                                   click.add(i);
//                                   print(click);
//                                   setState(() {
//                                     checked(i.x, i.y);
//                                     isBlack = !isBlack;
//                                     print(isBlack);
//                                   });
//                                 },
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.black),
//                                     color: Colors.orangeAccent,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ),
//                 )
//                 .toList()),
//       ),
//     );
//   }
// }
