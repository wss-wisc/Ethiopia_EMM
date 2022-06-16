set

sim        simulation scenarios   /fcst_100/
y          year                   /1981*2020/
;

parameter
cyf(reg,zone,c,s,y)
cyf81(s,reg,zone,c),cyf82(s,reg,zone,c)
cyf83(s,reg,zone,c),cyf84(s,reg,zone,c),cyf85(s,reg,zone,c),cyf86(s,reg,zone,c),cyf87(s,reg,zone,c)
cyf88(s,reg,zone,c),cyf89(s,reg,zone,c),cyf90(s,reg,zone,c),cyf91(s,reg,zone,c),cyf92(s,reg,zone,c)
cyf93(s,reg,zone,c),cyf94(s,reg,zone,c),cyf95(s,reg,zone,c),cyf96(s,reg,zone,c),cyf97(s,reg,zone,c)
cyf98(s,reg,zone,c),cyf99(s,reg,zone,c),cyf00(s,reg,zone,c),cyf01(s,reg,zone,c),cyf02(s,reg,zone,c)
cyf03(s,reg,zone,c),cyf04(s,reg,zone,c),cyf05(s,reg,zone,c),cyf06(s,reg,zone,c),cyf07(s,reg,zone,c)
cyf08(s,reg,zone,c),cyf09(s,reg,zone,c),cyf10(s,reg,zone,c),cyf11(s,reg,zone,c),cyf12(s,reg,zone,c)
cyf13(s,reg,zone,c),cyf14(s,reg,zone,c),cyf15(s,reg,zone,c),cyf16(s,reg,zone,c),cyf17(s,reg,zone,c)
cyf18(s,reg,zone,c),cyf19(s,reg,zone,c),cyf20(s,reg,zone,c) climate yield factor 1981-2020

ygain_onset(s,reg,zone,y)                yield gains from onset forecast-informed planting
ygain_onset_reshape(reg,zone,s,y)        reshape because I'm sketched out by GAMS's indexing

PPX(c,s,sim,y)                            producer price
PCX(c,s,sim,y)                            consumer price
PPZX(reg,zone,c,s,sim,y)                  zonal producer price
PCZX(reg,zone,c,s,sim,y)                  zonal consumer price
QFZX(reg,zone,c,s,sim,y)                  zonal food demand
QFZpcX(reg,zone,c,s,sim,y)                zonal per capita food demand
QFZHpcX(reg,zone,urbrur,c,s,sim,y)        zonal per capita food demand urban or rural
QLZX(reg,zone,c,s,sim,y)                  zonal livestock demand
QOZX(reg,zone,c,s,sim,y)                  zonal other demand
QDZX(reg,zone,c,s,sim,y)                  zonal total demand
ACZX(reg,zone,c,s,sim,y)                  zonal crop area
YCZX(reg,zone,c,s,sim,y)                  zonal crop yield
QSZX(reg,zone,c,s,sim,y)                  zonal supply
ACZ_inputX(reg,zone,c,type,s,sim,y)       with technology input
YCZ_inputX(reg,zone,c,type,s,sim,y)       with technology input
QSZ_inputX(reg,zone,c,type,s,sim,y)       with technology input
TQSX(c,s,sim,y)                           total supply
TACX(c,s,sim,y)                           total area
TACZX(reg,zone,s,sim,y)                   total area by zone
GDPZpcX(reg,zone,s,sim,y)                 zonal per capita GDP
GDPZHpcX(reg,zone,urbrur,s,sim,y)         zonal per capita GDP urban or rural
CPIX(s,sim,y)                             consumer price index
EXRX (sim,y)                            exchange rate
DQTZX(reg,zone,c,s,sim,y)                 net balance volume by zone
QMX(c,s,sim,y)                            imports
QEX(c,s,sim,y)                            exports

QFZHX(reg,zone,urbrur,c,s,sim,y)
QTX(c,s,sim,y)
DQMZX(reg,zone,c,s,sim,y)
DQEZX(reg,zone,c,s,sim,y)
GDPZHX(reg,zone,urbrur,s,sim,y)
;
$include paramsetup.inc

*$CALL 'GDXXRW Input/newcyf_updated2020.xls se=0 index=Index!A1'
*$CALL 'GDXXRW Input/yieldgains_onsetfcst.xls se=0 index=Index!A1'
$CALL 'GDXXRW Input/newcyf_updated2020_shifted.xls se=0 index=Index!A1'
$CALL 'GDXXRW Input/yieldgains_onsetfcst_shifted.xls se=0 index=Index!A1'

$gdxin  newcyf_updated2020_shifted.gdx
$LOAD   cyf81,cyf82,cyf83,cyf84,cyf85,cyf86,cyf87,cyf88,cyf89,cyf90,cyf91,cyf92,cyf93
$LOAD   cyf94,cyf95,cyf96,cyf97,cyf98,cyf99,cyf00,cyf01,cyf02,cyf03,cyf04,cyf05
$LOAD   cyf06,cyf07,cyf08,cyf09,cyf10,cyf11,cyf12,cyf13,cyf14,cyf15,cyf16,cyf17
$LOAD   cyf18,cyf19,cyf20
$gdxin

$gdxin  yieldgains_onsetfcst_shifted.gdx
$LOAD   ygain_onset
$gdxin


cyf(reg,zone,c,s,'1981')= cyf81(s,reg,zone,c);
cyf(reg,zone,c,s,'1982')= cyf82(s,reg,zone,c);
cyf(reg,zone,c,s,'1983')= cyf83(s,reg,zone,c);
cyf(reg,zone,c,s,'1984')= cyf84(s,reg,zone,c);
cyf(reg,zone,c,s,'1985')= cyf85(s,reg,zone,c);
cyf(reg,zone,c,s,'1986')= cyf86(s,reg,zone,c);
cyf(reg,zone,c,s,'1987')= cyf87(s,reg,zone,c);
cyf(reg,zone,c,s,'1988')= cyf88(s,reg,zone,c);
cyf(reg,zone,c,s,'1989')= cyf89(s,reg,zone,c);
cyf(reg,zone,c,s,'1990')= cyf90(s,reg,zone,c);
cyf(reg,zone,c,s,'1991')= cyf91(s,reg,zone,c);
cyf(reg,zone,c,s,'1992')= cyf92(s,reg,zone,c);
cyf(reg,zone,c,s,'1993')= cyf93(s,reg,zone,c);
cyf(reg,zone,c,s,'1994')= cyf94(s,reg,zone,c);
cyf(reg,zone,c,s,'1995')= cyf95(s,reg,zone,c);
cyf(reg,zone,c,s,'1996')= cyf96(s,reg,zone,c);
cyf(reg,zone,c,s,'1997')= cyf97(s,reg,zone,c);
cyf(reg,zone,c,s,'1998')= cyf98(s,reg,zone,c);
cyf(reg,zone,c,s,'1999')= cyf99(s,reg,zone,c);
cyf(reg,zone,c,s,'2000')= cyf00(s,reg,zone,c);
cyf(reg,zone,c,s,'2001')= cyf01(s,reg,zone,c);
cyf(reg,zone,c,s,'2002')= cyf02(s,reg,zone,c);
cyf(reg,zone,c,s,'2003')= cyf03(s,reg,zone,c);
cyf(reg,zone,c,s,'2004')= cyf04(s,reg,zone,c);
cyf(reg,zone,c,s,'2005')= cyf05(s,reg,zone,c);
cyf(reg,zone,c,s,'2006')= cyf06(s,reg,zone,c);
cyf(reg,zone,c,s,'2007')= cyf07(s,reg,zone,c);
cyf(reg,zone,c,s,'2008')= cyf08(s,reg,zone,c);
cyf(reg,zone,c,s,'2009')= cyf09(s,reg,zone,c);
cyf(reg,zone,c,s,'2010')= cyf10(s,reg,zone,c);
cyf(reg,zone,c,s,'2011')= cyf11(s,reg,zone,c);
cyf(reg,zone,c,s,'2012')= cyf12(s,reg,zone,c);
cyf(reg,zone,c,s,'2013')= cyf13(s,reg,zone,c);
cyf(reg,zone,c,s,'2014')= cyf14(s,reg,zone,c);
cyf(reg,zone,c,s,'2015')= cyf15(s,reg,zone,c);
cyf(reg,zone,c,s,'2016')= cyf16(s,reg,zone,c);
cyf(reg,zone,c,s,'2017')= cyf17(s,reg,zone,c);
cyf(reg,zone,c,s,'2018')= cyf18(s,reg,zone,c);
cyf(reg,zone,c,s,'2019')= cyf19(s,reg,zone,c);
cyf(reg,zone,c,s,'2020')= cyf20(s,reg,zone,c);

ygain_onset_reshape(reg,zone,s,y) = ygain_onset(s,reg,zone,y) ;
cyf(reg,zone,'maize',s,y) = ygain_onset_reshape(reg,zone,s,y) * cyf(reg,zone,'maize',s,y) ;
*cyf(reg,zone,'maize','meher',y) = ygain_onset_reshape(reg,zone,'meher',y) * cyf(reg,zone,'maize','meher',y) ;

cyf(reg,zone,c,s,y)$(cyf(reg,zone,c,s,y) gt 1) = 1 ;

loop(y,

display y, cyf ;

KcMean(reg,zone,c,s)$QSZ0(reg,zone,c,s) = 1 ;
KcMean(reg,zone,raincrop,s)           = cyf(reg,zone,raincrop,s,y) ;
KcMean(reg,zone,'Barley',s)           = cyf(reg,zone,'Sorghum',s,y) ;
KcMean(reg,zone,'Enset',s)            = max(cyf(reg,zone,'Maize',s,y),cyf(reg,zone,'Millet',s,y),
                                            cyf(reg,zone,'Teff',s,y),cyf(reg,zone,'Wheat',s,y),cyf(reg,zone,'Sorghum',s,y)) ;
*KcMean(reg,zone,cash,s)               = cyf(reg,zone,'Enset',s,y) ;
KcMean(reg,zone,cash,s)               = KcMean(reg,zone,'Enset',s) ;

display KcMean ;

SOLVE MULTIMKT USING MCP;
*display CPI.L;
*$BATINCLUDE simLoopSave.inc  "'base'" 'y'
$BATINCLUDE simLoopSave.inc  "'fcst_100'" 'y'

*Reset values
 PP.L(c,s)                = PP0(c,s);
 PC.L(c,s)                = PC0(c,s);
 PPZ.L(reg,zone,c,s)      = PPZ0(reg,zone,c,s);
 PCZ.L(reg,zone,c,s)      = PCZ0(reg,zone,c,s);

 QFZpc.L(reg,zone,c,s)             = QFZpc0(reg,zone,c,s);
 QFZHpc.L(reg,zone,urbrur,c,s)     = QFZHpc0(reg,zone,urbrur,c,s);
 QFZ.L(reg,zone,c,s)               = QFZ0(reg,zone,c,s);
 QFZH.L(reg,zone,urbrur,c,s)       = QFZH0(reg,zone,urbrur,c,s);

 QLZ.L(reg,zone,c,s)      = QLZ0(reg,zone,c,s);
 QOZ.L(reg,zone,c,s)      = QOZ0(reg,zone,c,s);
 QDZ.L(reg,zone,c,s)      = QDZ0(reg,zone,c,s);
 ACZ.L(reg,zone,c,s)      = ACZ0(reg,zone,c,s);
 YCZ.L(reg,zone,c,s)      = YCZ0(reg,zone,c,s);
 QSZ.L(reg,zone,c,s)      = QSZ0(reg,zone,c,s);

 ACZ_input.L(reg,zone,c,type,s)    = ACZ_input0(reg,zone,c,type,s);
 YCZ_input.L(reg,zone,c,type,s)    = YCZ_input0(reg,zone,c,type,s);
 QSZ_input.L(reg,zone,c,type,s)    = QSZ_input0(reg,zone,c,type,s);

 TQS.L(C,S)               = sum((reg,zone),QSZ0(reg,zone,c,s));
 TAC.L(C,S)               = sum((reg,zone),ACZ0(reg,zone,c,s));
 TACZ.L(reg,zone,s)       = sum(c,ACZ0(reg,zone,c,s));
 QM.L(C,S)                = QM0(C,S);
 QE.L(C,S)                = QE0(C,S);
 QT.L(C,S)                = QT0(C,S);

 totmargz.L(reg,zone,s)$sum(c,QFZ0(reg,zone,c,s)) = totmargz0(reg,zone,s) ;

 DQMZ.L(reg,zone,c,s) = DQMZ0(reg,zone,c,s);
 DQEZ.L(reg,zone,c,s) = DQEZ0(reg,zone,c,s);
 DQTZ.L(reg,zone,c,s) = DQTZ0(reg,zone,c,s);

 GDPZ.L(reg,zone,s)                = GDPZ0(reg,zone,s) ;
 GDPZH.L(reg,zone,urbrur,s)        = GDPZH0(reg,zone,urbrur,s) ;
 GDPZpc.L(reg,zone,s)              = GDPZpc0(reg,zone,s) ;
 GDPZHpc.L(reg,zone,urbrur,s)      = GDPZHpc0(reg,zone,urbrur,s) ;

 EXR.L                   = EXR0 ;
 DUMMY.L(reg,zone,c,s)     = 0 ;
 CPI.L(s)$sum((reg,zone,c),QFZ0(reg,zone,c,s))
                = sum((reg,zone,c),PC0(c,s)*QFZ0(reg,zone,c,s))/
                  sum((reg,zone,c),PC0(c,s)*QFZ0(reg,zone,c,s)) ;
* GAPZ.L(reg,zone,c) =  gapZ0(reg,zone,c);
);


Execute_Unload 'tmp1.gdx',PCX,PPX,PPZX,PCZX,QFZX,QFZpcX,QFZHpcX,QLZX,QOZX,QDZX,ACZX,YCZX,QSZX,ACZ_inputX,YCZ_inputX,QSZ_inputX,TQSX,TACX,TACZX,
GDPZpcX,GDPZHpcX,CPIX,EXRX,DQTZX,QMX,QEX,GDPX,AgGDPX,NAgGDPX,CALpcX,TCALpcX;
Execute 'GDXXRW.EXE tmp1.gdx O=simoutputY.xls index=INDEX!a1';
