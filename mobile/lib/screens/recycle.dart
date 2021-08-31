import 'package:flutter/material.dart';
import 'package:murls/providers/murls_items.dart';
import 'package:murls/widgets/app_drawer.dart';
import 'package:murls/widgets/user_urls_item.dart';
import 'package:provider/provider.dart';

class recycle_urls extends StatefulWidget {
  const recycle_urls({Key? key}) : super(key: key);
  static const routeName = '/recycle-urls';

  @override
  _recycle_urlsState createState() => _recycle_urlsState();
}

class _recycle_urlsState extends State<recycle_urls> {
  var _isInit = true;
  var _isLoading = false;

  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<recycle>(context).fetchAndSetUrls().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Check internet connection !.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('okay'),
              )
            ],
          ),
        );
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final urlsdata = Provider.of<recycle>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Recycles'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: urlsdata.items.isEmpty
                  ? LayoutBuilder(
                      builder: (ctx, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                                height: constraints.maxHeight * .6,
                                child: FittedBox(
                                  child: Image.asset(
                                    'assets/images/recyle-empty.png',
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        );
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.all(6),
                      child: ListView.builder(
                        itemCount: urlsdata.items.length,
                        itemBuilder: (_, i) => Column(
                          children: <Widget>[
                            userUrl(
                              urlsdata.items[i].Alias,
                              urlsdata.items[i].Id,
                              urlsdata.items[i].boost,
                              true,
                            ),
                          ],
                        ),
                      ),
                    )),
    );
  }
}
