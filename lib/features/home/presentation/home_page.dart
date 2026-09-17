import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/madar_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:CustomScrollView(slivers:[
    SliverAppBar(pinned:true,title:const Text('مَدار'),actions:[IconButton(onPressed:()=>context.push('/search'),icon:const Icon(Icons.search_rounded))]),
    SliverPadding(padding:const EdgeInsets.fromLTRB(18,12,18,28),sliver:SliverList(delegate:SliverChildListDelegate([
      const MadarGlassCard(child:ListTile(title:Text('الصلاة القادمة'),subtitle:Text('اضبط موقعك أو اختر مدينة لعرض المواقيت'),trailing:Text('—:—'))),
      const SizedBox(height:18),
      MadarSection(title:'الوصول السريع',child:GridView.count(crossAxisCount:2,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),mainAxisSpacing:12,crossAxisSpacing:12,childAspectRatio:1.65,children:[
        _Quick('القرآن',Icons.menu_book_rounded,'/quran'),_Quick('الحديث',Icons.auto_stories_rounded,'/hadith'),_Quick('الأذكار',Icons.wb_sunny_outlined,'/adhkar'),_Quick('القبلة',Icons.explore_rounded,'/qibla'),
      ])),
      const SizedBox(height:22),
      MadarSection(title:'اليوم في مَدار',child:Column(children:[
        MadarFeatureTile(icon:Icons.menu_book_rounded,title:'متابعة القراءة',subtitle:'آخر موضع محفوظ يظهر هنا',onTap:()=>context.push('/quran')),
        const SizedBox(height:10),
        MadarFeatureTile(icon:Icons.track_changes_rounded,title:'متابعة العبادة',subtitle:'الصلاة والقرآن والأذكار والتسبيح',onTap:()=>context.push('/tasbeeh')),
      ])),
    ]))),
  ])));
}
class _Quick extends StatelessWidget{const _Quick(this.title,this.icon,this.route);final String title,route;final IconData icon;@override Widget build(BuildContext c)=>InkWell(borderRadius:BorderRadius.circular(22),onTap:()=>GoRouter.of(c).push(route),child:MadarGlassCard(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(icon,size:28),const SizedBox(height:8),Text(title)])));}
