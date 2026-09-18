import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';
import '../domain/qibla_sensor_service.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});
  @override State<QiblaPage> createState()=>_State();
}
class _State extends State<QiblaPage> {
  final lat=TextEditingController(text:'12.7855');
  final lon=TextEditingController(text:'45.0187');
  @override void dispose(){lat.dispose();lon.dispose();super.dispose();}
  @override Widget build(BuildContext context){
    final latitude=double.tryParse(lat.text), longitude=double.tryParse(lon.text);
    final valid=latitude!=null&&longitude!=null;
    return MadarPage(title:'القبلة',child:ListView(padding:const EdgeInsets.all(18),children:[
      MadarGlassCard(child:Column(children:[
        Row(children:[
          Expanded(child:TextField(controller:lat,keyboardType:const TextInputType.numberWithOptions(decimal:true),decoration:const InputDecoration(labelText:'خط العرض'))),
          const SizedBox(width:10),
          Expanded(child:TextField(controller:lon,keyboardType:const TextInputType.numberWithOptions(decimal:true),decoration:const InputDecoration(labelText:'خط الطول'))),
        ]),
        const SizedBox(height:12),
        if(valid) StreamBuilder<QiblaReading>(
          stream:const QiblaSensorService().stream(latitude:12.7855,longitude:45.0187),
          builder:(context,snapshot){
            final r=snapshot.data;
            if(r==null)return const Column(children:[Icon(Icons.explore_rounded,size:150),Text('بانتظار حساس الاتجاه...')]);
            return Column(children:[
              Transform.rotate(angle:-r.heading*math.pi/180,child:const Icon(Icons.navigation_rounded,size:150)),
              Text('اتجاه القبلة: '+r.qiblaBearing.toStringAsFixed(1)+'°'),
              Text('الانحراف: '+r.relative.abs().toStringAsFixed(1)+'°'),
              const SizedBox(height:8),
              const Text('المعايرة وحالة الحساس قد تؤثران على الدقة.'),
            ]);
          })
        else const Text('أدخل إحداثيات صحيحة لبدء البوصلة.'),
      ])),
      const SizedBox(height:14),
      const MadarGlassCard(child:Text('يمكن استخدام الإحداثيات يدوياً بدون صلاحية الموقع. الموقع التلقائي سيطلب إذناً واضحاً قبل الاستخدام.')),
    ]));
  }
}
