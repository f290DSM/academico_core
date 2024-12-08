import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/aca_role.dart';

final roleProvider =
    FutureProvider.family<List<RoleModel>, String>((ref, userId) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase
        .from('user_roles')
        .select('roles(name)')
        .eq('user_id', userId);

    return (response as List<dynamic>)
        .map((role) => RoleModel.fromMap(role as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Erro ao buscar permissões: $e');
  }
});
