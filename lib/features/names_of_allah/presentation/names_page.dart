import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';
class NamesPage extends StatelessWidget{const NamesPage({super.key});@override Widget build(BuildContext c)=>MadarPage(title:'أسماء الله الحسنى',child:ListView(padding:const EdgeInsets.all(18),children:const[
MadarGlassCard(child:ListTile(leading:Icon(Icons.auto_awesome_rounded),title:Text('الأسماء ومعانيها'),subtitle:Text('المعنى والشرح والمصدر عند الحاجة'))),
SizedBox(height:18),MadarFeatureTile(icon:Icons.search_rounded,title:'البحث',subtitle:'البحث في الأسماء والمعاني',onTap:_noop),
SizedBox(height:10),MadarFeatureTile(icon:Icons.favorite_border_rounded,title:'المفضلة',subtitle:'حفظ الأسماء للرجوع إليها',onTap:_noop),
]));} static void _noop(){}}
