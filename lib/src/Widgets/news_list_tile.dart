import 'package:flutter/material.dart';
import 'package:flutter_news/src/Widgets/loading_container.dart';

import '../models/item_model.dart';

import '../blocs/stories_provider.dart';
import 'loading_container.dart';
import 'dart:async';

class NewsListTile extends StatelessWidget {

  final int itemId;

  NewsListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildTile(context,itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context,ItemModel item) {
    return Column(
      children: [
        ListTile(
          onTap: (){
            print("${item.id} clicked");
            Navigator.pushNamed(context, '/news/${item.id}');
          },
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),

        ),
        Divider(
          height: 8.0,
        ),

      ],
    );
  }

}