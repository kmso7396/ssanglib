import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/common_size.dart';
import '../constants/screen_size.dart';


class ProfileBody extends StatefulWidget{

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  bool selectedLeft = true;
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size.width;
  @override
  Widget build(BuildContext context){
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
                  _username(),_userBio(),_editProfileBtn(),
                _tabButtons(),_selectedIndicator()]
            ),
          ),
          _imagesPager()],
      ),
    );
  }

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
        child:Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              transform: Matrix4.translationValues(_leftImagesPageMargin,0,0),
              curve: Curves.fastOutSlowIn,
              child: _images(),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              transform: Matrix4.translationValues(_rightImagesPageMargin,0,0),
              curve: Curves.fastOutSlowIn,
              child: _images(),
            )
          ],
        ));
  }

  GridView _images() {
    return GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1,
                children: List.generate(
                    30,
                        (index) => CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: "https://picsum.photos/id/$index/100/100"
                    )));
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      alignment: _selectedTab == SelectedTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        height: 3,
        width: size.width / 2,
        color: Colors.black87,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }

  Row _tabButtons() {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                  child:IconButton(icon: ImageIcon(
                    AssetImage('assets/images/grid.png'),
                    color: _selectedTab == SelectedTab.left
                        ? Colors.black
                        : Colors.black26,
                  ),
                  onPressed: (){
                    setState(() {
                      _tabSelected(SelectedTab.left);
                    });
                  },)),
                  Expanded(
                      child:IconButton(icon: ImageIcon(
                        AssetImage('assets/images/saved.png'),color: _selectedTab == SelectedTab.left
                          ? Colors.black
                          : Colors.black26,
                      ),
                        onPressed: (){
                        setState(() {
                          _tabSelected(SelectedTab.right);
                        });
                        },))
                  ],
              );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.left:
          _selectedTab = SelectedTab.left;
          _leftImagesPageMargin = 0;
          _rightImagesPageMargin = size.width;
          break;
        case SelectedTab.right:
          _selectedTab = SelectedTab.right;
          _leftImagesPageMargin = -size.width;
          _rightImagesPageMargin = 0;
          break;
      }
    });
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap),
      child: SizedBox(
        height: 24,
        child: OutlinedButton(
            onPressed: (){},
            child:Text(
              '수정',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
        ),
      ),
    );
  }

  Widget _username(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'username',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _userBio(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        '바둑 프로필',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }
}

enum SelectedTab { left, right }