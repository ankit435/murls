import 'package:flutter/material.dart';
import 'package:murls/providers/murls_items.dart';
import '../widgets/user_urls_item.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import './add_new_urls.dart';

class listed_url extends StatefulWidget {
  static const routeName = '/listed-urls';

  @override
  _listed_urlState createState() => _listed_urlState();
}

class _listed_urlState extends State<listed_url> {
  var _isInit = true;
  var _isLoading = false;
  var urlsdata;
  String? filter;
  TextEditingController searchController = new TextEditingController();
  bool picture = false;
  bool is_searching = false;

  void initState() {
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
    super.initState();
  }

  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<murls_detail>(context).fetchAndSetUrls().then((_) {
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

  void _startAddNewUrl(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      isScrollControlled: false,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: addUrls(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var fiterurl;
    urlsdata = Provider.of<murls_detail>(context);
    return Scaffold(
      appBar: AppBar(
        title: !is_searching
            ? Text('My URLs')
            : TextField(
                style: TextStyle(color: Colors.white),
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
        actions: <Widget>[
          is_searching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      this.is_searching = !this.is_searching;
                    });
                  },
                  icon: Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      this.is_searching = !this.is_searching;
                    });
                  },
                  icon: Icon(Icons.search),
                ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [Color(0xFF61A3FE), Color(0xFF63FFD5)],
              //     begin: Alignment.centerLeft,
              //     end: Alignment.centerRight,
              //   ),
              // ),
              child: urlsdata.items.isEmpty
                  ? LayoutBuilder(
                      builder: (ctx, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FittedBox(
                              child: Text(
                                'Mmm... It\'s empty ?',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                                height: constraints.maxHeight * .6,
                                width: MediaQuery.of(context).size.width,
                                child: FittedBox(
                                  child: Image.asset(
                                    'assets/images/nourl.png',
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
                        itemBuilder: (_, i) {
                          return filter == null || filter == ""
                              ? Column(
                                  children: [
                                    userUrl(
                                        urlsdata.items[i].Alias,
                                        urlsdata.items[i].Id,
                                        urlsdata.items[i].boost,
                                        false),
                                    //  Divider(),
                                  ],
                                )
                              : '${urlsdata.items[i].Alias}'
                                      .toLowerCase()
                                      .contains(filter!.toLowerCase())
                                  ? Column(
                                      children: [
                                        userUrl(
                                          urlsdata.items[i].Alias,
                                          urlsdata.items[i].Id,
                                          urlsdata.items[i].boost,
                                          false,
                                        ),
                                        // Divider(),
                                      ],
                                    )
                                  : new Container();
                        },
                      ),
                    ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewUrl(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
