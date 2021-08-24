import 'package:flutter/material.dart';
import 'package:murls/Auth/models/auth0_user.dart';
import 'package:murls/Auth/services/auth_service.dart';
import 'package:murls/providers/murls_items.dart';
import '../widgets/user_urls_item.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import './add_new_urls.dart';

import 'package:murls/utilities/styles.dart';

import 'profile.dart';

class listed_url extends StatelessWidget {
  //const listed_url({Key? key}) : super(key: key);
  static const routeName = '/listed-urls';

  Auth0User? profile = AuthService.instance.profile;
  bool picture = false;
  @override
  Widget build(BuildContext context) {
    final urlsdata = Provider.of<murls_detail>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('All URLS'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            },
            child: _avatar(profile),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
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
            : Padding(
                padding: EdgeInsets.all(6),
                child: ListView.builder(
                  itemCount: urlsdata.items.length,
                  itemBuilder: (_, i) => Column(
                    children: [
                      userUrl(
                        urlsdata.items[i].Alias,
                        urlsdata.items[i].Id,
                      ),
                      // Text('${urlsdata.items[i].boost}'),

                      Divider(),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          // backgroundColor: Colors.amber,
          isScrollControlled: false,
          // backgroundColor: Colors.black,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {},
              child: addUrls(),
              behavior: HitTestBehavior.opaque,
            );
          },
        ),
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





  

//Navigator.of(context).pushNamed(addUrls.routeName);