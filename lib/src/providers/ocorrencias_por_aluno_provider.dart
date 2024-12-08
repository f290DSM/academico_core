import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/ocorrencia_domain.dart';
import 'app_providers.dart';

part 'ocorrencias_por_aluno_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<OcorrenciaDomain>> ocorrenciasPorAluno(Ref ref, int id) async {
  final response = await ref
      .watch(supabaseClientProvider)
      .from('posts_controle_diario')
      .select('*')
      .eq("aluno_id", id);

  return response.map((e) => OcorrenciaDomain.fromMap(e)).toList();
}
