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
            backgroundColor: Colors.cyan[500],
            actionsIconTheme: IconThemeData(opacity: 0.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('SOFTIDOR', style: TextStyle(fontWeight: FontWeight.bold),)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications, color: Colors.white))
              ],
            ),
          )
        ];
      },
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Home page de la aplicación del surtidor'),
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
