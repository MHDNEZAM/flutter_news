
import 'dart:convert';

class ItemModel{

 int id;
 bool deleted;
 String type;
 String by;
 int time;
 String text;
 bool dead;
 int parent;
 List<dynamic> kids;
 String url;
 int score;
 String title;
 int descendants;

ItemModel(this.id,this.deleted,this.type,this.by,this.time,this.text,this.dead,this.parent,this.kids,this.url,this.score,this.title,this.descendants);
ItemModel.fromJson(Map<String,dynamic> parsedJson){
  id=parsedJson['id'];
  deleted = parsedJson['deleted'] ?? false;
  type = parsedJson['type'];
  by = parsedJson['by']??'';
  time = parsedJson['time'];
  text = parsedJson['text'] ?? '';
  dead = parsedJson['dead'] ?? false;
  parent = parsedJson['parent'];
  kids = parsedJson['kids'] ?? [];
  url = parsedJson['url'];
  score = parsedJson['score'];
  title = parsedJson['title'];
  descendants = parsedJson['descendants'] ?? 0;

}
ItemModel.fromDb(Map<String,dynamic> parsedJson){
   id=parsedJson['id'];
   deleted = parsedJson['deleted']==1;
   type = parsedJson['type'];
   by = parsedJson['by'];
   time = parsedJson['time'];
   text = parsedJson['text'];
   dead = parsedJson['dead']==1;
   parent = parsedJson['parent'];
   kids = jsonDecode(parsedJson['kids']);
   url = parsedJson['url'];
   score = parsedJson['score'];
   title = parsedJson['title'];
   descendants = parsedJson['descendants'];

 }

 Map<String,dynamic> toMapForDb(){
  return <String,dynamic>{
     "id":id,
    "deleted": deleted ? 1 : 0,
    "type": type,
    "by": by,
    "time": time,
    "dead":  dead ? 1 : 0,
    "parent": parent,
    "kids":  jsonEncode(kids), // BLOB
    "url": url,
    "score": score,
    "title": title,
    "descendants": descendants,
  } ;
 }
}







