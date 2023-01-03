import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servicios_flutter/src/models/venta_producto.dart';
import 'package:servicios_flutter/src/provider/venta_producto_provider.dart';

import 'graph_widget.dart';

class VentaProductoPage extends StatefulWidget {
  const VentaProductoPage({Key key}) : super(key: key);
  @override
  State<VentaProductoPage> createState() => _VentaProductoPageState();
}

class _VentaProductoPageState extends State<VentaProductoPage> {
  Future<List<VentaProducto>> ventaProducto;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    ventaProducto = ventaProductoService.getVentas();
    _controller = PageController(
      initialPage: 3,
      viewportFraction: 0.3
    );
  }

  Widget _bottomAction(IconData icon) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Icon(
          icon,
          color: Colors.green,
        ),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _bottomAction(FontAwesomeIcons.history),
            _bottomAction(FontAwesomeIcons.chartPie),
            SizedBox(
              width: 32.0,
            ),
            _bottomAction(FontAwesomeIcons.wallet),
            _bottomAction(Icons.settings)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(children: <Widget>[
        _selector(),
        _expenses(),
        _graph(),
        _list(),
      ]),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(70.0),
      child: PageView(
        controller: _controller,
        children: <Widget>[
          Text("3 Meses"),
          Text("6 Meses"),
          Text("12 Meses"),
        ],
      ),
    );
  }

  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text(
          "\$2361.41",
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        Text(
          "Total Expenses",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _graph() {
    return Container(
      height: 250.0,
      child: LineChartSample2(),
    );
  }

  Widget _item(IconData icon, String name, int percent, double value) {
    return ListTile(
      leading: Icon(icon, size: 32.0),
      title: Text(name),
      subtitle: Text("$percent"),
      trailing: Text("\$$value"),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) =>
            _item(FontAwesomeIcons.shoppingCart, "mes", 14, 152.5),
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blue.withOpacity(0.15),
            height: 7.0,
          );
        },
      ),
    );
  }

  List<Widget> _drawItems(BuildContext context, AsyncSnapshot snapshot) {
    final List<Widget> solicitudes = [];

    if (snapshot.data.isNotEmpty) {
      snapshot.data.forEach((element) {
        final widgetTemp = _cardTanques(element);
        solicitudes.add(widgetTemp);
      });
    }
    return solicitudes;
  }

  Widget _cardTanques(dynamic element) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          ListTile(
            isThreeLine: true,
            //contentPadding: EdgeInsetsGeometry.infinity,
            title: Text(
              element.mes,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 25.1),
            ),
            //trailing: element.total,
            enabled: true,
          ),
        ],
      ),
    );
  }
}
