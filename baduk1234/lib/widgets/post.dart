
import 'package:baduk1234/widgets/rounded_avater.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/common_size.dart';

import 'comment.dart';
import 'my_progress_indicator.dart';

class Post extends StatelessWidget {
  final int index;
  Size size;

  Post(this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    if(size==null) size = MediaQuery.of(context).size;


    return Column(
      children: <Widget>[
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption()
      ],
    );
  }
  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(),
    );
  }

  Padding _postLikes() {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap
        ),
        child: Comment(
          showImage: false,
          username: 'user',
          text:'....'
        )
      );
  }

  Row _postActions() {
    return Row(
      children: <Widget>[
      IconButton(
      onPressed: null,
      icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
      color: Colors.black87,
      ),
      IconButton(
      onPressed: null,
      icon: ImageIcon(AssetImage('assets/images/comment.png')),
      color: Colors.black87,
      ),
      IconButton(
      onPressed: null,
      icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
      color: Colors.black87,
  ),
  Spacer(),
  IconButton(
  onPressed: null,
  icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
  color: Colors.black87)
  ],
  );
  }
  Widget _postHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ),
        Expanded(child: Text('username')),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
        )
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
        imageUrl: 'https://picsum.photos/id/$index/200/300',
        placeholder: (BuildContext context, String url){
          return MyProgressIndicator(
            containerSize: size.width,
          );
        },
        imageBuilder: (BuildContext context, ImageProvider imageProvider){
        return AspectRatio(
          aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover)
          ),
        ),
        );
      },);
  }
}

class RoundedAvatar extends StatelessWidget {
  const RoundedAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: 'https://picsum.photos/100',
        width: avatar_size,
        height: avatar_size,
      ),
    );
  }
}
