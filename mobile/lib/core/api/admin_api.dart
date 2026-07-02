import '../api/api_client.dart';

class AdminApi {
  AdminApi(this._client);

  final ApiClient _client;

  Future<List<Map<String, dynamic>>> list(String resource) async {
    final response = await _client.get('/admin/$resource');
    return (response['data'] as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> getById(String resource, int id) async {
    final response = await _client.get('/admin/$resource/$id');
    return response['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> create(
    String resource,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.post('/admin/$resource', body: body);
    return response['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> update(
    String resource,
    int id,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.put('/admin/$resource/$id', body: body);
    return response['data'] as Map<String, dynamic>;
  }

  Future<void> delete(String resource, int id) async {
    await _client.delete('/admin/$resource/$id');
  }

  Future<Map<String, dynamic>> uploadMedia(
    List<int> bytes,
    String filename,
  ) async {
    final response = await _client.uploadMultipart(
      '/admin/media/upload',
      'file',
      bytes,
      filename,
    );
    return response['data'] as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> listArticles() => list('articles');
  Future<List<Map<String, dynamic>>> listNews() => list('news');
  Future<List<Map<String, dynamic>>> listDistricts() => list('districts');
  Future<List<Map<String, dynamic>>> listStatistics() => list('statistics');
  Future<List<Map<String, dynamic>>> listContacts() => list('contacts');
  Future<List<Map<String, dynamic>>> listMedia() => list('media');
}
