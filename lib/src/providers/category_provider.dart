import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/aca_category.dart';
import 'app_providers.dart';

part 'category_provider.g.dart';

@riverpod
FutureOr<List<AcaCategory>> categories(Ref ref) async {
  final response =
      await ref.watch(supabaseClientProvider).from('categories').select('*');

  return [for (final c in response) AcaCategory.fromJson(c)];
}
