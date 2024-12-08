import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/aca_users.dart';

final loginProvider = FutureProvider.family<UserModel?, Map<String, String>>(
    (ref, credentials) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase
        .from('users')
        .select()
        .eq('email', credentials['email'] as String)
        .eq('senha', credentials['senha'] as String)
        .maybeSingle();

    if (response == null) {
      throw Exception('Credenciais inválidas');
    }

    // Converte os dados retornados em UserModel
    return UserModel.fromMap(response);
  } on PostgrestException catch (e) {
    // Trata erros do Supabase
    throw Exception('Erro ao autenticar: ${e.message}');
  } catch (e) {
    // Trata outros erros genéricos
    throw Exception('Erro inesperado ao autenticar: $e');
  }
});
