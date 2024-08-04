class Diary{
  final String date; //일단은 string으로 하구 나중에 datetime으로 변경
  final String image; //이미지 입력 안받을수도?
  final String content;

  Diary({
    required this.date,
    required this.image,
    required this.content
  });
}