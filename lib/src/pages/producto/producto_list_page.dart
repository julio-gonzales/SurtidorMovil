import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:servicios_flutter/models/producto.dart';
import 'package:servicios_flutter/providers/firebase_provider.dart';
import 'package:servicios_flutter/providers/producto_provider.dart';
import 'package:servicios_flutter/src/pages/producto/producto_show_page.dart';
import 'package:servicios_flutter/src/utils/LSColors.dart';
import 'package:servicios_flutter/src/utils/LSImages.dart';
import 'package:servicios_flutter/src/utils/TextStyles.dart';

class ProductoList extends StatefulWidget {
  const ProductoList({Key key}) : super(key: key);

  @override
  State<ProductoList> createState() => _ProductoListState();
}

class _ProductoListState extends State<ProductoList> {
  Future<List<Producto>> productos;

  @override
  void initState() {
    super.initState();
    productos = productoProvider.getProductos();
  }

  double imgWidth = 85;
  double imgHeight = 85;

  @override
  Widget build(BuildContext context) {
    Future<List<Producto>> productos = productoProvider.getProductos();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return productoProvider.getProductos();
        },
        child: FutureBuilder<List<Producto>>(
          future: productos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(height: 0.1, thickness: 2);
                  },
                  itemCount: snapshot.data.length,
                  shrinkWrap: false,
                  itemBuilder: (_, int index) {
                    return InkWell(
                        onTap: () {
                          final ruta = MaterialPageRoute(
                              builder: (context) => ProductoShow(
                                    productoId: snapshot.data[index].id,
                                  ));
                          Navigator.push(context, ruta);
                        },
                        child: _drawItem(snapshot.data[index]));
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Container _drawItem(Producto producto) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FutureBuilder<String>(
                future: firebaseProvider.getUrlImagen(producto.imagen),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == 'no') {
                      return Container(
                        child: Image.asset(
                          productoImagenDefault,
                          height: 85,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return imageWidget(snapshot.data);
                    }
                  } else {
                    return Container(
                        padding: EdgeInsets.all(17),
                        height: imgWidth,
                        width: imgWidth,
                        child: CircularProgressIndicator());
                  }
                },
              )),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(producto.nombre,
                        style: titleSmall),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${producto.cantidad} unids.',
                              style: const TextStyle(color: LSColorPrimary)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Text('Compra: Bs. ${producto.precioCompra}'),
                Text('Venta: Bs. ${producto.precioVenta}')
              ],
            ),
          ),
        ],
      ),
    );
  }

  CachedNetworkImage imageWidget(String imageUrl) {
    return CachedNetworkImage(
        alignment: Alignment.center,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: imgHeight,
        width: imgWidth,
        placeholder: (context, url) => Image.asset(
              loadingPoints,
              height: imgWidth,
              fit: BoxFit.cover,
            ),
        errorWidget: (context, url, error) => Container(
            height: imgHeight,
            width: imgWidth,
            alignment: Alignment.center,
            child: const Icon(Icons.error)));
  }
}
