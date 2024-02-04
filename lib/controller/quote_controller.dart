import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/quote_model.dart';

class QuoteService {
  Future<Quote> fetchQuote() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random'));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Quote(text: result['content'], author: result['author']);
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
