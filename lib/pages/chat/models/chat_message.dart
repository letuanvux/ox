class ChatMessage{
  String message;
  MessageType type;
  ChatMessage({required this.message, required this.type});
}

enum MessageType{
  Sender,
  Receiver,
}