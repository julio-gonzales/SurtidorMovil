import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:servicios_flutter/models/producto.dart';
import 'package:servicios_flutter/providers/firebase_provider.dart';
import 'package:servicios_flutter/providers/producto_provider.dart';
import 'package:servicios_flutter/src/pages/producto/producto_show_page.dart';
import 'package:servicios_flutter/src/utils/LSColors.dart';
import 'package:servicios_flutter/src/utils/LSImages.dart';
import 'package:servicios_flutter/src/utils/textStyles.dart';

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

  String searchString = "";
  TextEditingController searchController;
  Widget customSearchBar;
  Icon customIcon = const Icon(Icons.search);
  bool asc = true;
  String _sortBy = "nombre";
  bool _sortValue = true; //true=asc, false=desc

  @override
  Widget build(BuildContext context) {
    Future<List<Producto>> productos = productoProvider.getProductos();
    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: customSearchBar),
        actions: [
          buscador(),
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                          builder: (context, setStateCustom) {
                        return Container(
                          color: Colors.transparent,
                          margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('Ordenar por', style: titleSmall),
                              itemRadioButton(
                                  'Nombre', 'nombre', setStateCustom),
                              itemRadioButton(
                                  'Stock', 'cantidad', setStateCustom),
                              itemRadioButton('Precio de compra',
                                  'precioCompra', setStateCustom),
                              itemRadioButton('Precio de venta', 'precioVenta',
                                  setStateCustom),
                              itemRadioButton('Fecha de creación', 'createdAt',
                                  setStateCustom),
                              const Divider(height: 25, thickness: 2),
                              const Text('Orden', style: tituloAppBar),
                              sortRadioButton(
                                  'Ascendente', true, setStateCustom),
                              sortRadioButton(
                                  'Descendente', false, setStateCustom),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancelar')),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: const Text('Ordenar'))
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.white,
                    isScrollControlled: true);
              },
              icon: const Icon(Icons.sort))
        ],
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
                    return snapshot.data[index].nombre
                            .toLowerCase()
                            .contains(searchString)
                        ? const Divider(height: 0.1, thickness: 2)
                        : Container();
                  },
                  itemCount: snapshot.data.length,
                  shrinkWrap: false,
                  itemBuilder: (_, int index) {
                    if (_sortBy != "") {
                      switch (_sortBy) {
                        case 'nombre':
                          {
                            snapshot.data.sort((a, b) => _sortValue
                                ? a.nombre.compareTo(b.nombre)
                                : b.nombre.compareTo(a.nombre));
                          }
                          break;
                        case 'cantidad':
                          {
                            snapshot.data.sort((a, b) => _sortValue
                                ? a.cantidad.compareTo(b.cantidad)
                                : b.cantidad.compareTo(a.cantidad));
                          }
                          break;
                        case 'precioCompra':
                          {
                            snapshot.data.sort((a, b) => _sortValue
                                ? a.precioCompra.compareTo(b.precioCompra)
                                : b.precioCompra.compareTo(a.precioCompra));
                          }
                          break;
                        case 'precioVenta':
                          {
                            snapshot.data.sort((a, b) => _sortValue
                                ? a.precioVenta.compareTo(b.precioVenta)
                                : b.precioVenta.compareTo(a.precioVenta));
                          }
                          break;
                        case 'createdAt':
                          {
                            snapshot.data.sort((a, b) => _sortValue
                                ? a.createdAt.compareTo(b.createdAt)
                                : b.createdAt.compareTo(a.createdAt));
                          }
                          break;
                      }
                    }
                    return snapshot.data[index].nombre
                            .toLowerCase()
                            .contains(searchString)
                        ? InkWell(
                            onTap: () {
                              final ruta = MaterialPageRoute(
                                  builder: (context) => ProductoShow(
                                        productoId: snapshot.data[index].id,
                                      ));
                              Navigator.push(context, ruta);
                            },
                            child: _drawItem(snapshot.data[index]))
                        : Container();
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
      padding: const EdgeInsets.all(15),
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
                          height: imgHeight,
                          width: imgWidth,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return imageWidget(snapshot.data);
                    }
                  } else {
                    return Container(
                        padding: const EdgeInsets.all(17),
                        height: imgHeight,
                        width: imgWidth,
                        child: const CircularProgressIndicator());
                  }
                },
              )),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(producto.nombre, style: titleSmall),
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
                const SizedBox(height: 3),
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

  IconButton buscador() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (customIcon.icon == Icons.search) {
            customIcon = const Icon(Icons.cancel);
            customSearchBar = ListTile(
              leading: const Icon(
                Icons.search,
                size: 28,
              ),
              title: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Buscar un producto...',
                    hintStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchString = value;
                    });
                  }),
            );
          } else {
            customIcon = const Icon(Icons.search);
            customSearchBar = null;
            searchString = '';
          }
        });
      },
      icon: customIcon,
    );
  }

  ListTile itemRadioButton(String label, String valor, setStateCustom) {
    return ListTile(
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        title: Text(label),
        leading: Radio(
          value: valor,
          groupValue: _sortBy,
          onChanged: (value) {
            setStateCustom(() {
              _sortBy = value;
            });
          },
        ),
        onTap: () {
          setStateCustom(() {
            _sortBy = valor;
          });
        });
  }

  ListTile sortRadioButton(String label, bool valor, setStateCustom) {
    return ListTile(
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        title: Text(label),
        leading: Radio(
          value: valor,
          groupValue: _sortValue,
          onChanged: (value) {
            setStateCustom(() {
              _sortValue = value;
            });
          },
        ),
        onTap: () {
          setStateCustom(() {
            _sortValue = valor;
          });
        });
  }
}
