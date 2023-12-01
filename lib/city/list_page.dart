import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resas_basic_app/city/detail_page.dart';
import 'package:resas_basic_app/env.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<String> _citiesFuture;

  @override
  void initState() {
    super.initState();

    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/cities';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };

    _citiesFuture = http
        .get(
          Uri.http(host, endpoint),
          headers: headers,
        )
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder<String>(
        future: _citiesFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // 1-1. snapshot.dataの`result`というkeyにデータが入っているのでListとして扱います
              final json = jsonDecode(snapshot.data!)['result'] as List;
              // 1-2. Listの各要素はkey,value構造をしているのでkey: String, value: dynamicとして変換します
              final items = json.cast<Map<String, dynamic>>();
              // 2. ListViewをListView.builderに書き換えてitemsのデータを使う
              return ListView.builder(
                // 取得したデータの数を指定
                itemCount: items.length,
                // itemBuilderで返却されるWidgetがUIに表示されます
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item['cityName'] as String),
                    subtitle: const Text('政令指定都市'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (context) => CityDetailPage(
                            city: item['cityName'] as String,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
