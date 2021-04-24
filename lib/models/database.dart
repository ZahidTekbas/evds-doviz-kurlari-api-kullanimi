import 'dart:convert';

import 'package:borsa/classes/series_json_class.dart';
import 'package:borsa/constants/constants.dart';
import 'package:supabase/supabase.dart';

insertReport(String code, String json) async {
  var client = SupabaseClient(supabaseurl, supabasekey);
  var response = await client.from('reports').insert([
    {'code': code, 'json': json}
  ]).execute();
}

readReports() async {
  var client = SupabaseClient(supabaseurl, supabasekey);
  var response = await client.from('reports').select().execute();
}

// Query code comes from Hive.db
readSingleReport(String code) async {
  var client = SupabaseClient(supabaseurl, supabasekey);
  var response =
      await client.from('reports').select().eq('code', code).execute();
  var map = jsonDecode(response.data[0]['json']);
  SeriesArrayJson data = SeriesArrayJson.fromMap(map);
  return data;
}

// Query code comes from Hive.db
deleteReport(String code) async {
  var client = SupabaseClient(supabaseurl, supabasekey);
  var response =
      await client.from('reports').delete().eq('code', code).execute();
}
