import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicios_flutter/models/producto.dart';
import 'package:servicios_flutter/providers/producto_provider.dart';
import 'package:servicios_flutter/src/utils/LSColors.dart';
import 'package:servicios_flutter/src/utils/TextStyles.dart';

class ProductoShow extends StatefulWidget {
  final int productoId;
  const ProductoShow({Key key, this.productoId}) : super(key: key);

  @override
  State<ProductoShow> createState() => _ProductoShowState();
}

class _ProductoShowState extends State<ProductoShow> {
  Future<Producto> producto;

  @override
  void initState() {
    super.initState();
    updateProducto();
  }

  void updateProducto() {
    producto = productoProvider.getProducto(widget.productoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LSColorSecondary,
        appBar: AppBar(
            title: const Text('Información del producto', style: tituloAppBar)),
        body: SingleChildScrollView(
          child: FutureBuilder<Producto>(
              future: producto,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _drawDatos(snapshot.data);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }

  Container _drawDatos(Producto producto) {
    double espacio = 22;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 18, horizontal: 17),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        shape: BoxShape.rectangle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dato('Nombre', producto.nombre),
          Divider(height: espacio, thickness: 2),
          dato('Descripción', producto.descripcion),
          Divider(height: espacio, thickness: 2),
          dato('Precio de compra', producto.precioCompra),
          Divider(height: espacio, thickness: 2),
          dato('Precio de venta', producto.precioVenta),
          Divider(height: espacio, thickness: 2),
          dato('Estado', producto.estado),
          Divider(height: espacio, thickness: 2),
          dato(
              'Registrado',
              DateFormat('yyyy-MM-dd – kk:mm')
                  .format(producto.createdAt)
                  .toString()),
          Divider(height: espacio, thickness: 2),
          dato(
              'Ultima modificación',
              DateFormat('yyyy-MM-dd – kk:mm')
                  .format(producto.updatedAt)
                  .toString()),
        ],
      ),
    );
  }

  Row dato(String label, text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label + ':', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          flex: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label == 'Estado') ...[
                Text(text == true ? 'True' : 'falso',
                    style: TextStyle(color: Colors.black)),
              ] else ...[
                Text(text == null ? 'Sin registrar' : text,
                    style: TextStyle(color: Colors.black)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
