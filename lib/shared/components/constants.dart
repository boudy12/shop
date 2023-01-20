import 'package:shop/modules/shop_app/login/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value)
    {
      navigateAndFinishSS(context, ShopAppLoginScreen());
    }
  });

}


bool isDark1 = CacheHelper.getData(key: 'isDark') ?? false;

String? token = '';

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');  // 800 is size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
