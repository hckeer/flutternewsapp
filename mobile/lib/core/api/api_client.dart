import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../config/api_config.dart';

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode, this.code});

  final String message;
  final int? statusCode;
  final String? code;

  @override
  String toString() => message;
}

typedef UnauthorizedCallback = Future<void> Function();

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  String? _token;
  UnauthorizedCallback? onUnauthorized;

  void setToken(String? token) => _token = token;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  Future<Map<String, dynamic>> get(String path) async {
    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: _headers,
    );
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final response = await _client.put(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> delete(String path) async {
    final response = await _client.delete(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: _headers,
    );
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> uploadMultipart(
    String path,
    String fieldName,
    List<int> bytes,
    String filename,
  ) async {
    final detectedMime = lookupMimeType(filename, headerBytes: bytes);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiConfig.baseUrl}$path'),
    );
    if (_token != null) {
      request.headers['Authorization'] = 'Bearer $_token';
    }
    request.files.add(
      http.MultipartFile.fromBytes(
        fieldName,
        bytes,
        filename: filename,
        contentType: detectedMime != null ? MediaType.parse(detectedMime) : null,
      ),
    );
    final streamed = await _client.send(request);
    final response = await http.Response.fromStream(streamed);
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> _parseResponse(http.Response response) async {
    Map<String, dynamic> decoded;
    try {
      decoded = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw ApiException(
        'Invalid server response',
        statusCode: response.statusCode,
      );
    }

    if (response.statusCode == 401) {
      await onUnauthorized?.call();
      final error = decoded['error'] as Map<String, dynamic>?;
      throw ApiException(
        error?['message'] as String? ?? 'Unauthorized',
        statusCode: 401,
        code: error?['code'] as String?,
      );
    }

    if (response.statusCode >= 400) {
      final error = decoded['error'] as Map<String, dynamic>?;
      throw ApiException(
        error?['message'] as String? ?? 'Request failed',
        statusCode: response.statusCode,
        code: error?['code'] as String?,
      );
    }
    return decoded;
  }
}
