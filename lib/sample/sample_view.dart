import 'package:flutter/material.dart';
import 'package:jjs/model/model.dart';
import 'package:jjs/sample/sample_provider.dart';
import 'package:provider/provider.dart';

//페이지역할만
class SampleViewPage extends StatelessWidget {
  static const String path = '/';

  const SampleViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SampleProvider _provider = context.watch<SampleProvider>();
    return SampleView(
      // datas: _provider.datas,
      count: _provider.datas.length,
      itemBuilder: (context, index) => SampleViewTile(
        title: _provider.datas[index].title,
        onTap: () {
          ///todo: 로그인 이후 넘거가게 한다.
          _provider.setSelectIndex(index);
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => SampleListPage(),
          //   ),
          // );
          Navigator.of(context).pushNamed(SampleListPage.path);
        },
      ),
    );
  }
}

class SampleViewTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const SampleViewTile({this.onTap, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SampleView extends StatelessWidget {
  // final List<Data<DesData>> datas;
  final int count;
  final Widget Function(BuildContext context, int) itemBuilder;

  const SampleView({required this.count, required this.itemBuilder, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        itemCount: this.count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        padding: EdgeInsets.all(10),
        itemBuilder: this.itemBuilder,
      ),
    );
  }
}

class SampleListPage extends StatelessWidget {
  static const String path = '/list';

  const SampleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SampleProvider _provider = context.watch<SampleProvider>();
    return SampleListView(
      itemCount: _provider.selectData?.des.length ?? 0,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          _provider.setDesIndex(index);
          Navigator.of(context).pushNamed(SampleDetailPage.path);
        },
        leading: Text(
          index.toString(),
        ),
        title: Text(_provider.selectData?.des[index].title ?? ""),
        subtitle: Text(_provider.selectData?.des[index].name ?? ""),
      ),
      selectTitle: _provider.selectData?.title ?? '',
    );
  }
}

class SampleListView extends StatelessWidget {
  final int itemCount;
  final String selectTitle;
  final Widget Function(BuildContext context, int) itemBuilder;

  const SampleListView(
      {required this.itemCount,
      required this.selectTitle,
      required this.itemBuilder,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.selectTitle),
      ),
      body: ListView.builder(
        itemCount: this.itemCount,
        padding: EdgeInsets.all(10.0),
        itemBuilder: this.itemBuilder,
      ),
    );
  }
}

class SampleDetailPage extends StatelessWidget {
  static const String path = '/list/detail';

  const SampleDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SampleProvider _provider = context.watch<SampleProvider>();
    return SampleDetailView(
      title: _provider.selectDesData?.title ?? "",
      img: _provider.selectDesData?.img?? "",
      desc: _provider.selectDesData?.desc ?? "",
      name: _provider.selectDesData?.name ?? "",
    );
  }
}

class SampleDetailView extends StatelessWidget {
  final String title;
  final String img;
  final String name;
  final String desc;

  const SampleDetailView(
      {required this.title,
      required this.name,
      required this.img,
      required this.desc,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(img),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(name),
                    Text(desc),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
