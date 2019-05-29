import 'package:flutter/material.dart';
import 'network_image_ex.dart';

/// 用户头像组件
class CppAvatar extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  CppAvatar(
      {Key key,
      this.imageUrl,
      this.width: 40,
      this.height: 40,
      this.fit: BoxFit.fitHeight})
      : assert(imageUrl != null),
        super(key: key);

  _CppAvatarState createState() => _CppAvatarState();
}

class _CppAvatarState extends State<CppAvatar> {
  @override
  Widget build(BuildContext context) {
    /// 头像要加上一点点圆边
    /// 缓存 & 占位符加载图片
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: NetworkImageEx(
        assetName: 'images/default_hd_avatar.png',
        indicator: false,
        imageUrl: widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      ),
    );
  }
}
