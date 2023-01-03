import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servicios_flutter/src/pages/usuario/prueba2_page.dart';

class PruebaPage extends StatelessWidget {
  const PruebaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: innerBoxIsScrolled ? Colors.black : Colors.white),
                  onPressed: () {},
                ),
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0.5,
                expandedHeight: 400,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding:
                      EdgeInsets.only(bottom: 66, left: 40, right: 50),
                  collapseMode: CollapseMode.parallax,
                  title: Text(
                    'Rohan Patel',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH1yT4DmHv_jOOt7GLCO2pZY4wcst77Nvi4A&usqp=CAU',
                              height: 300,
                              width: 500,
                              fit: BoxFit.fill),
                          Container(
                            height: 300,
                            color: Colors.black26,
                          ),
                          Positioned(
                            bottom: 8,
                            left: 16,
                            right: 16,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('XPress Laundry Service'),
                                    Text(
                                      '145 Valencia St, San Francisco, CA 94103',
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '(90 Reviews)',
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '0.2 Km Away',
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 6, bottom: 6),
                                      child: Text('Open'.toUpperCase()),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                bottom: TabBar(
                  labelColor: Colors.black,
                  isScrollable: false,
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Datos'.toUpperCase()),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Services'.toUpperCase()),
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: [NadaPage(), NadaPage()],
          ),
        ),
      ),
    );
  }
}
