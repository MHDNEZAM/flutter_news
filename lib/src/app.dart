



import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget{

  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child:MaterialApp(
          title: 'News!',
          // home: NewsList(),
          onGenerateRoute: routes,
        ),
      ),
    );

  }



  Route routes(RouteSettings settings){

    if(settings.name=='/')
    {
        return MaterialPageRoute(
            builder: (context){
          return NewsList();
        },
        );
    }
    else if(settings.name.contains('/news/')){
      return MaterialPageRoute(builder: (context){
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name.replaceFirst('/news/', ''));

        commentsBloc.fetchItemWithComments(itemId);

        return NewsDetail(itemId:itemId,);
      });
    }


  }
}