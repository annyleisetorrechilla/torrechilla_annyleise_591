import 'dart:async';
import 'package:modelhandling/model/chat_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatController {
  final supabase = Supabase.instance.client;

  final _messagesController = StreamController<List<Message>>.broadcast();
  Stream<List<Message>> get messagesStream => _messagesController.stream;

  List<Message> _messages = [];
  RealtimeChannel? _channel;

//task 5
  Future<void> loadMessages() async {
    final data = await supabase
        .from('messages')
        .select()
        .order('created_at', ascending: true);

    _messages = data.map((item) => Message.fromMap(item)).toList();
    _messagesController.add(_messages);
  }

  void subscribeToMessages() {
    _channel = supabase
        .channel('public:messages')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            final newMessage = Message.fromMap(payload.newRecord);
            _messages.add(newMessage);
            _messagesController.add(_messages);
          },
        )
        .subscribe();
  }

  Future<void> sendMessage(String username, String message) async {
    final newMessage = Message(
      username: username,
      message: message,
      createdAt: DateTime.now(), 
    );

    await supabase.from('messages').insert(newMessage.toMap());
  }


  void dispose() {
    _channel?.unsubscribe();
    _messagesController.close();
  }
}
