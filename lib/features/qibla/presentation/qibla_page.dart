import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';

class QiblaPage extends StatelessWidget {
  const QiblaPage({super.key});
  @override Widget build(BuildContext context) => MadarPage(title: 'القبلة', child: ListView(padding: const EdgeInsets.all(18), children: [
    MadarGlassCard(child: Column(children: [
      SizedBox(height: 250, child: CustomPaint(painter: _QiblaPainter())),
      Text('البوصلة', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 6),
      const Text('سيتم ربط الاتجاه الفعلي بحساسات الجهاز بعد منح الصلاحية اللازمة.'),
    ])),
    const SizedBox(height: 14),
    const MadarGlassCard(child: ListTile(leading: Icon(Icons.my_location_rounded), title: Text('الموقع'), subtitle: Text('يمكن اختيار المدينة أو الإحداثيات يدوياً دون موقع تلقائي'))),
  ]));
}
class _QiblaPainter extends CustomPainter {
  @override void paint(Canvas c, Size s) {
    final center=Offset(s.width/2,s.height/2), r=math.min(s.width,s.height)*.34;
    final p=Paint()..style=PaintingStyle.stroke..strokeWidth=2;
    c.drawCircle(center,r,p); c.drawLine(Offset(center.dx,center.dy-r),Offset(center.dx,center.dy+r),p); c.drawLine(Offset(center.dx-r,center.dy),Offset(center.dx+r,center.dy),p);
    final q=Paint()..style=PaintingStyle.fill; final path=Path()..moveTo(center.dx,center.dy-r-16)..lineTo(center.dx-12,center.dy-r+14)..lineTo(center.dx,center.dy-r+7)..lineTo(center.dx+12,center.dy-r+14)..close(); c.drawPath(path,q);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}
