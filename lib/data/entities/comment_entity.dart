import 'entity.dart';

class CommentEntity extends Entity<String> {
  final String lotto;
  final String prize;
  final String user;
  final String content;

  CommentEntity(
    {required String id,
    required this.lotto,
    required this.prize,
    required this.user,
    required this.content}) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lotto': lotto,
      'prize': prize,
      'user': user,
      'content': content,
    };
  }

  @override
  List<Object> get props => [
    id,
    lotto,
    prize,
    user,
    content,
  ];
}
