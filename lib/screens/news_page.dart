import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_model.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _interestController = TextEditingController();
  List<Map<String, String>> _articles = [];
  bool _isLoading = false;

  void _fetchNewsArticles() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Map<String, String>> articles = await NewsModel.fetchArticles(_interestController.text);
      setState(() {
        _articles = articles;
      });
    } catch (e) {
      print('Failed to fetch news articles: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Row(
          children: [
            Image.network(
              'https://abiastatepolytechnic.edu.ng/wp-content/themes/abiapoly1/assets/img/logoapoly.png',
              width: 50,
              height: 50,
            ),
            SizedBox(width: 10),
            Text('AI-Driven News Aggregator'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _interestController,
              decoration: InputDecoration(
                labelText: 'Search for news',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _fetchNewsArticles,
                ),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _articles.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 4.0,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            title: Text(
                              _articles[index]['title']!,
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              _articles[index]['url']!,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            onTap: () => _launchURL(_articles[index]['url']!),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
