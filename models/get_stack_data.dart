class GetStack
{
  String image;
  String text;
  double opacity;
  int term;

  GetStack.fromJson(Map<String  , dynamic> element)
  {
    image = element['image'];
    text = element['text'];
    opacity = element['opacity'];
    term = element['term'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name': image,
        'email': text,
        'term': term,
      };
  }
}