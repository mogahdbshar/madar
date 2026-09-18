import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';
import '../../../core/permissions/permission_explanation.dart';
import '../../../core/permissions/permission_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override Widget build(BuildContext context)=>MadarPage(title:'الإعدادات',child:ListView(padding:const EdgeInsets.all(18),children:[
    const MadarSection(title:'التطبيق',child:Column(children:[
      _Setting(icon:Icons.palette_outlined,title:'المظهر',subtitle:'فاتح أو داكن أو حسب النظام'),
      _Setting(icon:Icons.language_rounded,title:'اللغة',subtitle:'العربية والإنجليزية'),
    ])),
    const SizedBox(height:20),
    MadarSection(title:'الصلاحيات',child:Column(children:[
      _PermissionTile(explanation:PermissionCatalog.notifications,request:const MadarPermissionService().requestNotifications),
      _PermissionTile(explanation:PermissionCatalog.location,request:const MadarPermissionService().requestLocation),
    ])),
    const SizedBox(height:20),
    const MadarSection(title:'المحتوى والخصوصية',child:Column(children:[
      _Setting(icon:Icons.verified_outlined,title:'مصادر المحتوى',subtitle:'المصدر والمرجع والترخيص والتحقق'),
      _Setting(icon:Icons.lock_outline_rounded,title:'الخصوصية',subtitle:'البيانات الشخصية محلياً قدر الإمكان'),
    ])),
  ]));
}

class _PermissionTile extends StatelessWidget {
  const _PermissionTile({required this.explanation,required this.request});
  final PermissionExplanation explanation;
  final Future<bool> Function() request;
  @override Widget build(BuildContext context)=>ListTile(
    contentPadding:EdgeInsets.zero,leading:const Icon(Icons.verified_user_outlined),
    title:Text(explanation.title),subtitle:Text(explanation.reason),
    trailing:FilledButton.tonal(onPressed:()async{
      final granted=await request();
      if(context.mounted)ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(granted?'تم السماح.':'لم يتم السماح، ويمكنك تغيير القرار من إعدادات النظام.')));
    },child:const Text('طلب')),
  );
}
class _Setting extends StatelessWidget {
 const _Setting({required this.icon,required this.title,required this.subtitle});
 final IconData icon;final String title,subtitle;
 @override Widget build(BuildContext context)=>ListTile(contentPadding:EdgeInsets.zero,leading:Icon(icon),title:Text(title),subtitle:Text(subtitle),trailing:const Icon(Icons.chevron_left_rounded));
}
