class Message {
  String profileImage;
  String image;
  String fileUrl;
  String fileName;
  String name;
  String text;
  String time;
  String dateTime;
  String senderId;

  Message({this.profileImage, this.text, this.senderId, this.time , this.name , this.dateTime , this.image , this.fileUrl , this.fileName});

  Message.fromJson(Map<String, dynamic> element) {
    profileImage = element['profileImage'];
    time = element['time'];
    text = element['text'];
    senderId = element['senderId'];
    name = element['name'];
    dateTime = element['dateTime'];
    fileUrl = element['fileUrl'];
    image = element['image'];
    fileName = element['fileName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage,
      'fileName': fileName,
      'time': time,
      'fileUrl': fileUrl,
      'text': text,
      'senderId': senderId,
      'name': name,
      'image': image,
      'dateTime': dateTime,
    };
  }
}
