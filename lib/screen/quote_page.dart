import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  String _quote = 'Click here to get a new quote!';
  String _author = '';

  void _fetchQuote() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random'));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      setState(() {
        _quote = result['content'];
        _author = result['author'];
      });
    } else {
      setState(() {
        _quote = 'Failed to load quote';
        _author = '';
      });
    }
  }

  void _shareQuote() {
    if (_quote.isNotEmpty && _author.isNotEmpty) {
      Share.share('$_quote - $_author');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Quotes'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareQuote,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _quote,
                style: TextStyle(fontSize: 24.sp, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Text(
                _author,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchQuote,
        tooltip: 'New Quote',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
