import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/create_ocorrencia_domain.dart';
import 'app_providers.dart';

part 'create_ocorrencia.g.dart';

@riverpod
Future<void> inserirOcorrencia(
    Ref ref, CreateOcorrenciaDomain ocorrencia) async {
  final client = ref.watch(supabaseClientProvider);
  final response =
      await client.from('posts_controle_diario').insert(ocorrencia.toMap());

  if (response != null && response.error != null) {
    throw Exception('Failed to insert data: ${response.error!.message}');
  }
}
