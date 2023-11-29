import 'package:flutter/material.dart';

class CityListPage extends StatelessWidget {
  const CityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('大阪市'),
            subtitle: const Text('政令指定都市'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              // TODO: 詳細画面に遷移する
            },
          ),
          ListTile(
            title: const Text('名古屋市'),
            subtitle: const Text('政令指定都市'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              // TODO: 詳細画面に遷移する
            },
          ),
          ListTile(
            title: const Text('博多市'),
            subtitle: const Text('政令指定都市'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              // TODO: 詳細画面に遷移する
            },
          ),
        ],
      ),
    );
  }
}
