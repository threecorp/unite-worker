// import 'package:extremo/io/entity/paging.dart';
// import 'package:extremo/io/store/api/extremo/extremo.dart';
// import 'package:extremo/io/store/api/extremo/extremo_request.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:extremo/misc/logger.dart';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/io/store/api/extremo/extremo_response.dart';
import 'package:extremo/io/store/db/extremo/box.dart';
import 'package:extremodart/extremo/api/mypage/artifacts/v1/artifact_service.pb.dart';
import 'package:extremodart/extremo/msg/db/v1/db.pb.dart' as pbdb;
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Cache save & return
// Future<ArtifactEntity> xFormResponseArtifactEntity(
//   Ref ref,
//   ArtifactResponse element,
// ) async {
//   final artifactBox = await ref.read(artifactBoxProvider.future);
//   final userBox = await ref.read(userBoxProvider.future);
//
//   final entity = ArtifactEntity.fromResponse(element: element);
//   if (artifactBox.get(element.pk)?.updatedAt == entity.updatedAt) {
//     return entity;
//   }
//
//   //
//   // TODO(Backgrounder): Background process to put data to DB
//   //
//   // Artifact
//   await artifactBox.put(element.pk, entity);
//   // User
//   if (entity.user != null) {
//     await userBox.put(entity.userFk, entity.user!);
//   }
//
//   return entity;
// }

// Cache save & return
Future<ArtifactEntity> xFormRpcArtifactEntity(
  Ref ref,
  pbdb.Artifact element,
) async {
  final artifactBox = await ref.read(artifactBoxProvider.future);
  final userBox = await ref.read(userBoxProvider.future);

  final entity = ArtifactEntity.fromRpc(element: element);
  if (artifactBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // TODO(Backgrounder): Background process to put data to DB
  //
  // Artifact
  await artifactBox.put(element.pk, entity);
  // User
  if (entity.user != null) {
    await userBox.put(entity.userFk, entity.user!);
  }

  return entity;
}

// Cache save & return
Future<ChatEntity> xFormRpcChatEntity(
  Ref ref,
  pbdb.Chat element,
) async {
  final chatBox = await ref.read(chatBoxProvider.future);
  final userBox = await ref.read(userBoxProvider.future);

  final entity = ChatEntity.fromRpc(element: element);
  if (chatBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // TODO(Backgrounder): Background process to put data to DB
  //
  // Chat
  await chatBox.put(element.pk, entity);
  // User
  if (entity.senderUser != null) {
    await userBox.put(entity.senderFk, entity.senderUser!);
  }
  if (entity.recipientUser != null) {
    await userBox.put(entity.recipientFk, entity.recipientUser!);
  }

  return entity;
}

// Cache save & return
Future<UserEntity> xFormRpcChatUserEntity(
  Ref ref,
  pbdb.User element,
) async {
  // final chatBox = await ref.read(chatBoxProvider.future);
  // final userBox = await ref.read(userBoxProvider.future);
  //
  final entity = UserEntity.fromRpc(element: element);
  // if (chatBox.get(element.pk)?.updatedAt == entity.updatedAt) {
  //   return entity;
  // }
  //
  // //
  // // TODO(Backgrounder): Background process to put data to DB
  // //
  // // Chat
  // await chatBox.put(element.pk, entity);
  // // User
  // if (entity.senderUser != null) {
  //   await userBox.put(entity.senderFk, entity.senderUser!);
  // }
  // if (entity.recipientUser != null) {
  //   await userBox.put(entity.recipientFk, entity.recipientUser!);
  // }

  return entity;
}

// Cache save & return
Future<UserEntity> xFormRpcUserEntity(
  Ref ref,
  pbdb.User element,
) async {
  final userBox = await ref.read(userBoxProvider.future);
  final userProfileBox = await ref.read(userProfileBoxProvider.future);

  final entity = UserEntity.fromRpc(element: element);
  if (userBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // TODO(Backgrounder): Background process to put data to DB
  //
  // User
  await userBox.put(element.pk, entity);
  // Profile
  if (entity.profile != null) {
    // TODO(compaction): compare to both of updatedAt
    await userProfileBox.put(entity.profile!.id, entity.profile!);
  }

  return entity;
}
