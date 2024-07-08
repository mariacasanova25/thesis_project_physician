import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis_project_physician/communityForum/data/discussions_repository.dart';
import 'package:thesis_project_physician/communityForum/discussions_list.dart';

class CommunityForumScreen extends ConsumerWidget {
  const CommunityForumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discussionsAsync = ref.watch(watchDiscussionsProvider);
    return Scaffold(
      body: discussionsAsync.when(
          data: (discussions) {
            if (discussions.isEmpty) {
              return const Text('Não foram encontradas discussões.');
            }
            return DiscussionsList(discussions: discussions);
          },
          error: (error, stackTrace) {
            return const SizedBox(
              width: 10,
            );
          },
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
