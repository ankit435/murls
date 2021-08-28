import 'package:flutter/material.dart';
import 'package:murls/Auth/models/auth0_user.dart';
import 'package:murls/Auth/services/auth_service.dart';
import 'package:murls/providers/murls_items.dart';
import '../widgets/user_urls_item.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import './add_new_urls.dart';

// ignore: camel_case_types
class listed_url extends StatefulWidget {
  static const routeName = '/listed-urls';

  @override
  _listed_urlState createState() => _listed_urlState();
}

// ignore: camel_case_types
class _listed_urlState extends State<listed_url> {
  var _isInit = true;
  var _isLoading = false;

  void initState() {
    super.initState();
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

  Auth0User? profile = AuthService.instance.profile;

  bool picture = false;

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

  Future<void> _refreshUrls(BuildContext context) async {
    await Provider.of<murls_detail>(context, listen: false).fetchAndSetUrls();
  }

  @override
  Widget build(BuildContext context) {
    final urlsdata = Provider.of<murls_detail>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('All URLS'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: _avatar(profile),
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
              child: urlsdata.items.isEmpty
                  ? LayoutBuilder(
                      builder: (ctx, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'No url is found  ?',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: constraints.maxHeight * .6,
                              child: Image.asset(
                                'assets/images/waiting.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  :
                  // FutureBuilder(
                  //     future: _refreshUrls(context),
                  //     builder: (ctx, snapshot) =>
                  //         snapshot.connectionState == ConnectionState.waiting
                  //             ? Center(
                  //                 child: CircularProgressIndicator(),
                  //               )
                  //             : RefreshIndicator(
                  //                 onRefresh: () => _refreshUrls(context),
                  //                 child: Consumer<murls_detail>(
                  //                   builder: (ctx, urlsdata, _) =>

                  Padding(
                      padding: EdgeInsets.all(6),
                      child: ListView.builder(
                        itemCount: urlsdata.items.length,
                        itemBuilder: (_, i) => Column(
                          children: [
                            userUrl(
                              urlsdata.items[i].Alias,
                              urlsdata.items[i].Id,
                              urlsdata.items[i].boost,
                            ),
                            // Text('${urlsdata.items[i].boost}'),

                            Divider(),
                          ],
                        ),
                      ),
                      //                 ),
                      //               ),
                      //             ),
                    ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewUrl(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Padding _avatar(Auth0User? profile) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.cover,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.all(Radius.circular(600)),
          child: Container(
            child: _avatarPhoto(profile),
          ),
        ),
      ),
    );
  }

  Widget _avatarPhoto(Auth0User? profile) {
    return profile != null && profile.hasImage
        ? Image.network(
            profile.picture,
            width: 20,
            height: 20,
          )
        : Container(
            width: 20,
            height: 20,
            // color: darkBrown,
            child: Center(
              child: Text('${profile?.name[0].toUpperCase()}'),
            ),
          );
  }
}
