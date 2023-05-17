import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/entities/chat_content_refactor_entity.dart';
import 'package:ihz_bql/models/enums/chat_content_type.dart';
part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatDetailCubit() : super(const ChatDetailState());

  Future<List<ChatContentRefactorEntity>> getChatConversation(
      int pageKey) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // final results = [
    //   for (int i = 0; i < 20; i++) ...[
    //     ChatContentEntity(
    //       id: Random().nextInt(1000),
    //       chatContent: "${getRandomString(10)} $i",
    //       isOwner: Random().nextInt(1000) % 3 == 1,
    //     )
    //   ]
    // ];
    // Nhóm các message cùng người tạo
    // List<ChatContentRefactorEntity> chatConversations = [];
    // int considerIndex = 0;
    // while (considerIndex < results.length) {
    //   List <String> messageGroup = [results[considerIndex].chatContent];
    //
    //   if()
    //
    //
    //   chatConversations = [
    //     ChatContentRefactorEntity(
    //       id: 1,
    //       isOwner: ,
    //       chatContent: ,
    //     ),
    //     ...chatConversations,
    //   ];
    //   considerIndex++;
    // }
    List<ChatContentRefactorEntity> chatConversations = [
      for (int i = 0; i < 20; i++) ...[
        ChatContentRefactorEntity(
          id: Random().nextInt(1000),
          chatContent: [
            "${getRandomString(10)} $i",
            "${getRandomString(10)} $i",
          ],
          isOwner: Random().nextInt(1000) % 2 == 1,
          type: ChatContentType.text.getType,
        )
      ]
    ];
    return chatConversations;
  }

  // Test
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );
}
