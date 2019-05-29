import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 扩展的 NetworkImage 类
/// 支持图片占位符和加载进度显示
class NetworkImageEx extends StatefulWidget {
  final String imageUrl;
  final String assetName;
  final bool indicator;
  final double width;
  final double height;
  final BoxFit fit;

  NetworkImageEx(
      {Key key,
      this.imageUrl,
      this.assetName,
      this.indicator: false,
      this.width,
      this.height,
      this.fit: BoxFit.fitWidth})
      : assert(imageUrl != null),
        assert(assetName != null),
        super(key: key);

  _NetworkImageExState createState() => _NetworkImageExState();
}

class _NetworkImageExState extends State<NetworkImageEx> {
  @override
  Widget build(BuildContext context) {
    var stackChildren = <Widget>[
      Image.asset(
        widget.assetName,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      ),
    ];
    if (widget.indicator) stackChildren.add(CircularProgressIndicator());

    return Container(
      child: CachedNetworkImage(
        placeholder: (ctx, str) => Stack(
              alignment: AlignmentDirectional.center,
              children: stackChildren,
            ),
        // placeholder: (ctx, str) => Image.asset(widget.assetImage),
        imageUrl: widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      ),
    );
  }
}
