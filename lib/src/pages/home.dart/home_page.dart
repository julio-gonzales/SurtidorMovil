import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 210,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            pinned: true,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            backgroundColor: Colors.blue,
            actionsIconTheme: IconThemeData(opacity: 0.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Text('SOFTIDOR')),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications, color: Colors.white))
              ],
            ),
          )
        ];
      },
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Popular Laundry Nearby'),
                  TextButton(onPressed: () {}, child: Text('View All'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
