class GetSubjects
{
  String name;
  String url;

  GetSubjects({this.name,this.url});

  GetSubjects.fromJson(Map<String  , dynamic> element)
  {
    url = element['url'];
    name = element['name'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name': name,
        'url': url,
      };
  }

}