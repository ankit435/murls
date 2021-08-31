import 'package:flutter/material.dart';
import 'package:murls/providers/murls_items.dart';
import 'package:murls/screens/url_detail_screen.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class userUrl extends StatelessWidget {
  final String allias;
  final String id;
  bool boost;
  bool recycled;

  //const userUrl({Key? key}) : super(key: key);

  userUrl(this.allias, this.id, this.boost, this.recycled);
  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        child: Icon(Icons.archive_sharp, color: Colors.white, size: 32),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
      );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(id),
      background: recycled ? buildSwipeActionLeft() : buildSwipeActionRight(),
      secondaryBackground: buildSwipeActionRight(),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => Card(
            color: Colors.transparent,
            child: AlertDialog(
              clipBehavior: Clip.antiAlias,
              title: Text('Are you sure?'),
              content: Text(
                direction == DismissDirection.startToEnd
                    ? 'Do you want to restore the this url ?'
                    : 'Do you want to remove the this url ?',
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    // recycled ? null :
                    Navigator.of(ctx).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    // recycled ? null :
                    Navigator.of(ctx).pop(true);
                  },
                ),
              ],
            ),
          ),
        );
      },
      onDismissed: (direction) {
        recycled
            ? direction == DismissDirection.startToEnd
                ? Provider.of<recycle>(context, listen: false).Restored(id)
                : recycled
                    ? Provider.of<recycle>(context, listen: false).delete(id)
                    : Provider.of<murls_detail>(context, listen: false)
                        .removeItem(id)
            : Provider.of<murls_detail>(context, listen: false).removeItem(id);
      },
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              recycled
                  ? null
                  : Navigator.of(context)
                      .pushNamed(url_detail.routeName, arguments: id);
            },
            child: Card(
              shadowColor: Colors.red,
              elevation: 7,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFE6197), Color(0xFFFFB463)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          '${allias[0].toUpperCase()}${allias.substring(1)}',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(boost ? Icons.bolt : null),
                      ),
                    ],
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
