import 'package:flutter/material.dart';
import 'package:murls/providers/murls_items.dart';
import 'package:murls/screens/url_detail_screen.dart';
import 'package:murls/utilities/styles.dart';
import 'package:provider/provider.dart';

class userUrl extends StatelessWidget {
  final String allias;
  final String id;

  //const userUrl({Key? key}) : super(key: key);

  userUrl(this.allias, this.id);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the this url?',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<murls_detail>(context, listen: false).removeItem(id);
      },
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print('hi');
              Navigator.of(context)
                  .pushNamed(url_detail.routeName, arguments: id);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(4, 6, 0, 0),
              child: InkWell(
                splashColor: Colors.red,
                child: Theme(
                  data: ThemeData(
                    highlightColor: Colors.red,
                  ),
                  child: ListTile(
                    title: Text(
                      '${allias}',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
    





//  Navigator.of(context).pushNamed(url_detail.routeName, arguments: id);