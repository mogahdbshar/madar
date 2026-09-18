import 'dart:math' as math;
import '../../features/calendar/domain/hijri_models.dart';

class HijriConverter {
  const HijriConverter();
  HijriDate fromGregorian(DateTime date) {
    final jd=_julianDay(date.year,date.month,date.day);
    final l=jd-1948440+10632;
    final n=((l-1)/10631).floor();
    final l2=l-10631*n+354;
    final j=((10985-l2)/5316).floor()*((50*l2/17719).floor())+
      (l2/5670).floor()*((43*l2/15238).floor());
    final l3=l2-((30-j)*((17719*j/50).floor()))-((j/16).floor()*((15238*j/43).floor()))+29;
    final month=((24*l3)/709).floor();
    final day=l3-((709*month)/24).floor();
    final year=30*n+j-30;
    return HijriDate(year:year,month:month,day:day);
  }
  int _julianDay(int y,int m,int d){
    final a=((14-m)/12).floor(), yy=y+4800-a, mm=m+12*a-3;
    return d+((153*mm+2)/5).floor()+365*yy+(yy/4).floor()-(yy/100).floor()+(yy/400).floor()-32045;
  }
}