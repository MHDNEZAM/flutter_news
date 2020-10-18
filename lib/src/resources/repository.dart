import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository{
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,

  ];

  Future<ItemModel>  fetchItem(int id) async{
    ItemModel item;
    var source;

    for (source in sources){
      item = await source.fetchItem(id);
      if(item != null){
        break;
      }
    }

    for (var cache in caches){
      if(cache != source) {
        cache.addItem(item);
      }

    }

    return item;

  }

// todo iterate over sources when dbprovider implemanted
  Future<List<int>> fetchTopIds(){
    return sources[1].fetchTopIds();
  }

  /*   OLD METHOD
    NewsApiProvider apiProvider = NewsApiProvider();
    NewsDbProvider dbProvider = NewsDbProvider();


    Future<List<int>> fetchTopIds(){
      return apiProvider.fetchTopIds();
    }

    Future<ItemModel>  fetchItem(int id) async{
      var item = await dbProvider.fetchItem(id);
      if(item != null) {
        return item;
      }

      item = await apiProvider.fetchItem(id);
     dbProvider.addItem(item);
      return item;


    }
*/
  clearCache() async{
    for (var cache in caches){
      await cache.clear();
    }
  }
}


abstract class Source{

  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}
abstract class Cache{
  Future<int> addItem(ItemModel item);
  Future<int> clear();

}