import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_layout/cubit/cubit.dart';
import 'package:shop/layout/shop_layout/cubit/states.dart';
import 'package:shop/modules/shop_app/Screens/search/search_screeen.dart';
import 'package:shop/modules/shop_app/Screens/sidebar_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/cubit.dart';

class ShopLayoutScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          drawer: SideBarScreen(),
          appBar: AppBar(
            title: Center(
              child: Text(
                'Salla',
              ),
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, ShopAppSearchScreen());
                  },
                  icon: Icon(
                    Icons.search_outlined
                  )
              ),

            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomIcon,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      }

    );
  }
}
