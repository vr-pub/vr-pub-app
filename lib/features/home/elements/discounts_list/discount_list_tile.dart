import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/discount.dart';
import 'package:palette_generator/palette_generator.dart';

class DiscountListTile extends StatefulWidget {
  final Discount discount;
  static Color color = Colors.green[600];

  const DiscountListTile({Key key, this.discount}) : super(key: key);

  @override
  _DiscountListTileState createState() => _DiscountListTileState();
}

class _DiscountListTileState extends State<DiscountListTile> {
  bool loaded = false;
  Color backgroundColor;
  Color textColor;
  PaletteGenerator paletteGenerator;

  @override
  void initState() {
    getColors();
    super.initState();
  }

  Future<bool> getColors() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.discount.thumbnail),
    );
    if (paletteGenerator.lightMutedColor != null) {
      backgroundColor = paletteGenerator.lightMutedColor.color;
      textColor = paletteGenerator.lightMutedColor.bodyTextColor;
    } else {
      backgroundColor = Colors.grey[200];
      textColor = Colors.black;
    }
    setState(() {
      loaded = true;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
        color: loaded ? backgroundColor : DiscountListTile.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            bottomSheet(context);
          },
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(children: [
                Text(
                  widget.discount.name,
                  style: TextStyle(
                    color: loaded ? textColor : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image(
                    image: NetworkImage(widget.discount.thumbnail),
                    height: 110,
                  ),
                )
              ])),
        ),
      ),
    );
  }

  void bottomSheet(BuildContext context) {
    showBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * .75,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: loaded ? backgroundColor : DiscountListTile.color,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      widget.discount.name,
                      style: TextStyle(
                          color: loaded ? textColor : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image(
                      image: NetworkImage(widget.discount.picture),
                      height: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      formatDescription(),
                      style: TextStyle(
                          color: loaded ? textColor : Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ],
              ));
        });
  }

  String formatDescription() {
    switch (widget.discount.type) {
      case DiscountType.gl:
        return '';
      case DiscountType.pf:
        return widget.discount.product.description;
      case DiscountType.pp:
        return widget.discount.product.description;
      case DiscountType.cp:
        return 'category'
            .tr(namedArgs: {'name': widget.discount.category.name});
      default:
        return 'error'.tr();
    }
  }

  String formatDate() {
    return '${widget.discount.dateStart.day}.${widget.discount.dateStart.month} - ${widget.discount.dateEnd.day}.${widget.discount.dateEnd.month}';
  }
}
