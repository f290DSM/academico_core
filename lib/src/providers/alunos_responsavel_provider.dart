import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/aca_students.dart';

final alunosResponsavelProvider =
    FutureProvider.family<List<Aluno>, String>((ref, String userId) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase
        .from('responsavel_aluno')
        .select('alunos(*)')
        .eq('user_id', userId);

    return (response as List<dynamic>)
        .map((alunoData) =>
            Aluno.fromMap(alunoData['alunos'] as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Erro ao buscar alunos: $e');
  }
});
