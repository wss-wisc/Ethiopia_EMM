* ============== Direct variables output ====================
PPX(c,s,%1,%2)                        = PP.L(c,s);
PCX(c,s,%1,%2)                        = PC.L(c,s);
PPZX(reg,zone,c,s,%1,%2)              = PPZ.L(reg,zone,c,s);
PCZX(reg,zone,c,s,%1,%2)              = PCZ.L(reg,zone,c,s);
QFZX(reg,zone,c,s,%1,%2)              = QFZ.L(reg,zone,c,s);
QFZpcX(reg,zone,c,s,%1,%2)            = QFZpc.L(reg,zone,c,s);
QFZHpcX(reg,zone,urbrur,c,s,%1,%2)    = QFZHpc.L(reg,zone,urbrur,c,s);
QLZX(reg,zone,c,s,%1,%2)              = QLZ.L(reg,zone,c,s);
QOZX(reg,zone,c,s,%1,%2)              = QOZ.L(reg,zone,c,s);
QDZX(reg,zone,c,s,%1,%2)              = QDZ.L(reg,zone,c,s);
ACZX(reg,zone,c,s,%1,%2)              = ACZ.L(reg,zone,c,s);
YCZX(reg,zone,c,s,%1,%2)              = YCZ.L(reg,zone,c,s);
QSZX(reg,zone,c,s,%1,%2)              = QSZ.L(reg,zone,c,s);
ACZ_inputX(reg,zone,c,type,s,%1,%2)   = ACZ_input.L(reg,zone,c,type,s);
YCZ_inputX(reg,zone,c,type,s,%1,%2)   = YCZ_input.L(reg,zone,c,type,s);
QSZ_inputX(reg,zone,c,type,s,%1,%2)   = QSZ_input.L(reg,zone,c,type,s);
TQSX(c,s,%1,%2)                       = TQS.L(c,s);
TACX(c,s,%1,%2)                       = TAC.L(c,s);
TACZX(reg,zone,s,%1,%2)               = TACZ.L(reg,zone,s);
GDPZpcX(reg,zone,s,%1,%2)             = GDPZpc.L(reg,zone,s);
GDPZHpcX(reg,zone,urbrur,s,%1,%2)     = GDPZHpc.L(reg,zone,urbrur,s);
EXRX(%1,%2)                         = EXR.L;
DQTZX(reg,zone,c,s,%1,%2)             = DQTZ.L(reg,zone,c,s);
QMX(c,s,%1,%2)                        = QM.L(c,s);
QEX(c,s,%1,%2)                        = QE.L(c,s);

* ===
QFZHX(reg,zone,urbrur,c,s,%1,%2)      = QFZH.L(reg,zone,urbrur,c,s);
QTX(c,s,%1,%2)                        = QT.L(c,s);

DQMZX(reg,zone,c,s,%1,%2)             = DQMZ.L(reg,zone,c,s);
DQEZX(reg,zone,c,s,%1,%2)             = DQEZ.L(reg,zone,c,s);

GDPZHX(reg,zone,urbrur,s,%1,%2)       = GDPZH.L(reg,zone,urbrur,s) ;


* ============= Export percentage =============
QEinQSX(ag,s,%1,%2)$TQS.L(ag,s)                              = 100*QE.L(ag,s)/TQS.L(ag,s);

* ================= Demand ===============
TQFX(c,s,%1,%2)                                           = sum((reg,zone),QFZ.L(reg,zone,c,s));
GrainQFX(s,%1,%2)                                         = sum((reg,zone,cereal),QFZ.L(reg,zone,cereal,s));
LVQFX(s,%1,%2)                                            = sum((reg,zone,lv),QFZ.L(reg,zone,lv,s));
TQLX(c,s,%1,%2)                                           = sum((reg,zone),QLZ.L(reg,zone,c,s));
TQOX(c,s,%1,%2)                                           = sum((reg,zone),QOZ.L(reg,zone,c,s));
TQDX(c,s,%1,%2)                                           = sum((reg,zone),QDZ.L(reg,zone,c,s));

* ================= Supply ===============
* ==== Total
TQSX(C,s,%1,%2)                                            = SUM((reg,zone),QSZ.L(reg,zone,c,s));
TVQSX(C,s,%1,%2)                                           = SUM((reg,zone),PPZ.L(reg,zone,c,s)*QSZ.L(reg,zone,c,s));
TVQS0X(C,s,%1,%2)                                          = SUM((reg,zone),PPZ0(reg,zone,c,s)*QSZ.L(reg,zone,c,s));

TQSX(C,s,%1,%2)                                            = SUM((reg,zone,type),QSZ_input.L(reg,zone,c,type,s));
TVQSX(C,s,%1,%2)                                            = SUM((reg,zone,type),PPZ.L(reg,zone,c,s)*QSZ_input.L(reg,zone,c,type,s));
TVQS0X(C,s,%1,%2)                                            = SUM((reg,zone,type),PPZ0(reg,zone,c,s)*QSZ_input.L(reg,zone,c,type,s));

TQSX(lv,s,%1,%2)                                            = SUM((reg,zone),QSZ.L(reg,zone,lv,s));
TVQSX(lv,s,%1,%2)                                           = SUM((reg,zone),PPZ.L(reg,zone,lv,s)*QSZ.L(reg,zone,lv,s));
TVQS0X(lv,s,%1,%2)                                          = SUM((reg,zone),PPZ0(reg,zone,lv,s)*QSZ.L(reg,zone,lv,s));

TQSX(NAG,s,%1,%2)                                            = SUM((reg,zone),QSZ.L(reg,zone,nag,s));
TVQSX(NAG,s,%1,%2)                                           = SUM((reg,zone),PPZ.L(reg,zone,nag,s)*QSZ.L(reg,zone,nag,s));
TVQS0X(NAG,s,%1,%2)                                          = SUM((reg,zone),PPZ0(reg,zone,nag,s)*QSZ.L(reg,zone,nag,s));

 TQSirrX(C,s,%1,%2)                                            = SUM((reg,zone,wtype),QSZ_input.L(reg,zone,c,wtype,s));
 TVQSirrX(C,s,%1,%2)                                           = SUM((reg,zone,wtype),PPZ.L(reg,zone,c,s)*QSZ_input.L(reg,zone,c,wtype,s));
 TVQS0irrX(C,s,%1,%2)                                          = SUM((reg,zone,wtype),PPZ0(reg,zone,c,s)*QSZ_input.L(reg,zone,c,wtype,s));

 TQSdryX(C,s,%1,%2)                                            = SUM((reg,zone,nwtype),QSZ_input.L(reg,zone,c,nwtype,s));
 TVQSdryX(C,s,%1,%2)                                           = SUM((reg,zone,nwtype),PPZ.L(reg,zone,c,s)*QSZ_input.L(reg,zone,c,nwtype,s));
 TVQS0dryX(C,s,%1,%2)                                          = SUM((reg,zone,nwtype),PPZ0(reg,zone,c,s)*QSZ_input.L(reg,zone,c,nwtype,s));

* ==== Grain & Cash

GrainQSX(s,%1,%2)                                         = SUM((reg,zone,cereal,type),QSZ_input.L(reg,zone,cereal,type,s));
GrainVQSX(s,%1,%2)                                         = SUM((reg,zone,cereal,type),PPZ.L(reg,zone,cereal,s)*QSZ_input.L(reg,zone,cereal,type,s));
GrainVQS0X(s,%1,%2)                                         = SUM((reg,zone,cereal,type),PPZ0(reg,zone,cereal,s)*QSZ_input.L(reg,zone,cereal,type,s));

 GrainTACZ_inputFertX(s,%1,%2)                              = SUM((reg,zone,cereal,Ftype),ACZ_input.L(reg,zone,cereal,Ftype,s));
 GrainTQSZ_inputFertX(s,%1,%2)                              = SUM((reg,zone,cereal,Ftype),QSZ_input.L(reg,zone,cereal,Ftype,s));
 GrainTVQSZ_inputFertX(s,%1,%2)                              = SUM((reg,zone,cereal,Ftype),PPZ.L(reg,zone,cereal,s)*QSZ_input.L(reg,zone,cereal,Ftype,s));
 GrainTVQSZ0_inputFertX(s,%1,%2)                              = SUM((reg,zone,cereal,Ftype),PPZ0(reg,zone,cereal,s)*QSZ_input.L(reg,zone,cereal,Ftype,s));
 GrainTYCZ_inputFertX(s,%1,%2)$GrainTACZ_inputFertX(s,%1,%2)  =  1000*GrainTQSZ_inputFertX(s,%1,%2)/GrainTACZ_inputFertX(s,%1,%2) ;

CashQSX(s,%1,%2)                                          = SUM((reg,zone,cash,type),QSZ_input.L(reg,zone,cash,type,s));
 CashVQSX(s,%1,%2)                                         = SUM((reg,zone,cash,type),PPZ.L(reg,zone,cash,s)*QSZ_input.L(reg,zone,cash,type,s));
 CashVQS0X(s,%1,%2)                                        = SUM((reg,zone,cash,type),PPZ0(reg,zone,cash,s)*QSZ_input.L(reg,zone,cash,type,s));

 GRAINVQSirrX(s,%1,%2)                                          = SUM((reg,zone,cereal,wtype),PPZ.L(reg,zone,cereal,s)*QSZ_input.L(reg,zone,cereal,wtype,s));
 GRAINVQS0irrX(s,%1,%2)                                         = SUM((reg,zone,cereal,wtype),PPZ0(reg,zone,cereal,s)*QSZ_input.L(reg,zone,cereal,wtype,s));
 GRAINQSirrX(s,%1,%2)                                          = SUM((reg,zone,cereal,wtype),QSZ_input.L(reg,zone,cereal,wtype,s));

 CASHVQSirrX(s,%1,%2)                                          = SUM((reg,zone,cash,wtype),PPZ.L(reg,zone,cash,s)*QSZ_input.L(reg,zone,cash,wtype,s));
 CASHVQS0irrX(s,%1,%2)                                         = SUM((reg,zone,cash,wtype),PPZ0(reg,zone,cash,s)*QSZ_input.L(reg,zone,cash,wtype,s));
 CashQSirrX(s,%1,%2)                                          = SUM((reg,zone,cash,wtype),QSZ_input.L(reg,zone,cash,wtype,s));

 GRAINVQSdryX(s,%1,%2)                                          = SUM((reg,zone,cereal,nwtype),PPZ.L(reg,zone,cereal,s)*QSZ_input.L(reg,zone,cereal,nwtype,s));
 GRAINVQS0dryX(s,%1,%2)                                         = SUM((reg,zone,cereal,nwtype),PPZ0(reg,zone,cereal,s)*QSZ_input.L(reg,zone,cereal,nwtype,s));
 GRAINQSdryX(s,%1,%2)                                          = SUM((reg,zone,cereal,nwtype),QSZ_input.L(reg,zone,cereal,nwtype,s));

 CASHVQSdryX(s,%1,%2)                                          = SUM((reg,zone,cash,nwtype),PPZ.L(reg,zone,cash,s)*QSZ_input.L(reg,zone,cash,nwtype,s));
 CASHVQS0dryX(s,%1,%2)                                         = SUM((reg,zone,cash,nwtype),PPZ0(reg,zone,cash,s)*QSZ_input.L(reg,zone,cash,nwtype,s));
 CashQSdryX(s,%1,%2)                                          = SUM((reg,zone,cash,nwtype),QSZ_input.L(reg,zone,cash,nwtype,s));

* ================ per capita Demand & Supply ===================
TQFpcX(c,s,%1,%2)                                         = sum((reg,zone),QFZ.L(reg,zone,c,s))/sum((reg,zone,urbrur),PopH(reg,zone,urbrur));
GrainQFpcX(s,%1,%2)                                       = sum((reg,zone,cereal),QFZ.L(reg,zone,cereal,s))/sum((reg,zone,urbrur),PopH(reg,zone,urbrur));
LVQFpcX(s,%1,%2)                                          = sum((reg,zone,lv),QFZ.L(reg,zone,lv,s))/sum((reg,zone,urbrur),PopH(reg,zone,urbrur));
TQSpcX(c,s,%1,%2)                                         = sum((reg,zone),QSZ.L(reg,zone,c,s))/sum((reg,zone,urbrur),PopH(reg,zone,urbrur));
GrainQSpcX(s,%1,%2)                                       = sum((reg,zone,cereal),QSZ.L(reg,zone,cereal,s))/sum((reg,zone,urbrur),PopH(reg,zone,urbrur));
LVQSpcX(s,%1,%2)                                          = sum((reg,zone,lv),QSZ.L(reg,zone,lv,s))/sum((reg,zone,urbrur),PopH(reg,zone,urbrur));

* =============== Consumption, GDP, Supply at national level ===============

 CPIX(s,%1,%2)           = sum((reg,zone,c),PC.L(c,s)*QFZ0(reg,zone,c,s))/sum((reg,zone,c),PC0(c,s)*QFZ0(reg,zone,c,s));
 PPIX(s,%1,%2)           = sum((reg,zone,c),PPZ.L(reg,zone,c,s)*QSZ0(reg,zone,c,s))/sum((reg,zone,c),PPZ0(reg,zone,c,s)*QSZ0(reg,zone,c,s));

 AGCPIX(s,%1,%2)           = sum((reg,zone,ag),PCZ.L(reg,zone,ag,s)*QFZ0(reg,zone,ag,s))/sum((reg,zone,ag),PCZ0(reg,zone,ag,s)*QFZ0(reg,zone,ag,s));
 AGPPIX(s,%1,%2)           = sum((reg,zone,ag),PPZ.L(reg,zone,ag,s)*QSZ0(reg,zone,ag,s))/sum((reg,zone,ag),PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s));

 AGCPIRX(reg,s,%1,%2)$sum((zone,ag),PCZ0(reg,zone,ag,s)*QFZ0(reg,zone,ag,s))
               = sum((zone,ag),PCZ.L(reg,zone,ag,s)*QFZ0(reg,zone,ag,s))/sum((zone,ag),PCZ0(reg,zone,ag,s)*QFZ0(reg,zone,ag,s));
 AGPPIRX(reg,s,%1,%2)$sum((zone,ag),PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s))
              = sum((zone,ag),PPZ.L(reg,zone,ag,s)*QSZ0(reg,zone,ag,s))/sum((zone,ag),PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s));

 AGCPIZX(reg,zone,s,%1,%2)$sum(ag,PCZ0(reg,zone,ag,s)*QFZ0(reg,zone,ag,s))
               = sum(ag,PCZ.L(reg,zone,ag,s)*QFZ0(reg,zone,ag,s))/sum(ag,PCZ0(reg,zone,ag,s)*QFZ0(reg,zone,ag,s));
 AGPPIZX(reg,zone,s,%1,%2)$sum(ag,PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s))
              = sum(ag,PPZ.L(reg,zone,ag,s)*QSZ0(reg,zone,ag,s))/sum(ag,PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s));


 CONX(s,%1,%2)$PPIX(s,%1,%2)     = sum((reg,zone,c),PCZ0(reg,zone,c,s)*QFZ.L(reg,zone,c,s)) ;
 AgCONX(s,%1,%2)$PPIX(s,%1,%2)   = sum((reg,zone,ag),PCZ0(reg,zone,ag,s)*QFZ.L(reg,zone,ag,s)) ;

 CONpcX(s,%1,%2)$CONX(s,%1,%2)           = CONX(s,%1,%2)/(1000*sum((reg,zone,urbrur),PopH(reg,zone,urbrur)));
 AgCONpcX(s,%1,%2)$AgCONX(s,%1,%2)       = AgCONX(s,%1,%2)/(1000*sum((reg,zone,urbrur),PopH(reg,zone,urbrur)));

 AgGDPX(s,%1,%2)$PPIX(s,%1,%2)   = sum((reg,zone,ag),PPZ0(reg,zone,ag,s)*QSZ.L(reg,zone,ag,s)) ;
 NAgGDPX(s,%1,%2)$CPIX(s,%1,%2)   = sum((reg,zone,nag),PPZ0(reg,zone,nag,s)*QSZ.L(reg,zone,nag,s)) ;

 GDPX(s,%1,%2)                  = AgGDPX(s,%1,%2) + NAgGDPX(s,%1,%2) ;

 ToTQSX(s,%1,%2)$PPIX(s,%1,%2)   = sum((reg,zone,c),PPZ0(reg,zone,c,s)*QSZ.L(reg,zone,c,s)) ;
 ToTVQSX(s,%1,%2)$PPIX(s,%1,%2)   = sum((reg,zone,c),PPZ.L(reg,zone,c,s)*QSZ.L(reg,zone,c,s)) ;
 ToTAgQSX(s,%1,%2)$PPIX(s,%1,%2)   = sum((reg,zone,ag),PPZ0(reg,zone,ag,s)*QSZ.L(reg,zone,ag,s)) ;
 ToTAgVQSX(s,%1,%2)$PPIX(s,%1,%2)   = sum((reg,zone,ag),PPZ.L(reg,zone,ag,s)*QSZ.L(reg,zone,ag,s)) ;
 ToTAgVQS0X(s,%1,%2)$PPIX(s,%1,%2)   = sum((reg,zone,ag),PPZ0(reg,zone,ag,s)*QSZ.L(reg,zone,ag,s)) ;

 GDPpcX(s,%1,%2)$GDPX(s,%1,%2)           = GDPX(s,%1,%2)/(1000*sum((reg,zone,urbrur),PopH(reg,zone,urbrur)));
 AgGDPpcX(s,%1,%2)$AgGDPX(s,%1,%2)       = AgGDPX(s,%1,%2)/(1000*sum((reg,zone,urbrur),PopH(reg,zone,urbrur)));
 NAgGDPpcX(s,%1,%2)$NAgGDPX(s,%1,%2)     = NAgGDPX(s,%1,%2)/(1000*sum((reg,zone,urbrur),PopH(reg,zone,urbrur)));


* =============== Deficit & Surplus ==========
TDQTZX(c,s,%1,%2)                                         = sum((reg,zone)$(DQTZ.L(reg,zone,c,s) gt 0),DQTZ.L(reg,zone,c,s));
GrainDQTZX(s,%1,%2)                                       = sum((reg,zone,cereal)$(DQTZ.L(reg,zone,cereal,s) gt 0),DQTZ.L(reg,zone,cereal,s));

* ================ Area & Yield =============
TYCX(c,s,%1,%2)$TACX(c,s,%1,%2)                             = 1000*TQSX(c,s,%1,%2)/TACX(c,s,%1,%2);
TACirrX(c,s,%1,%2)                                        = sum((reg,zone,wtype),ACZ_input.L(reg,zone,c,wtype,s));
TACdryX(c,s,%1,%2)                                        = sum((reg,zone,nwtype),ACZ_input.L(reg,zone,c,nwtype,s));
TYCirrX(c,s,%1,%2)$TACirrX(c,s,%1,%2)                       = 1000*TQSirrX(c,s,%1,%2)/TACirrX(c,s,%1,%2);
TYCdryX(c,s,%1,%2)$TACdryX(c,s,%1,%2)                       = 1000*TQSdryX(c,s,%1,%2)/TACdryX(c,s,%1,%2);

ALLACX(s,%1,%2)                                           = sum((reg,zone,c),ACZ.L(reg,zone,c,s));
ALLACirrX(s,%1,%2)                                        = sum((reg,zone,c,wtype),ACZ_input.L(reg,zone,c,wtype,s));
ALLACdryX(s,%1,%2)                                        = sum((reg,zone,c,nwtype),ACZ_input.L(reg,zone,c,nwtype,s));

GrainACX(s,%1,%2)                                         = sum((reg,zone,cereal),ACZ.L(reg,zone,cereal,s));
CashACX(s,%1,%2)                                          = sum((reg,zone,cash),ACZ.L(reg,zone,cash,s));

GrainACirrX(s,%1,%2)                                      = sum((reg,zone,cereal,wtype),ACZ_input.L(reg,zone,cereal,wtype,s));
GrainACdryX(s,%1,%2)                                      = sum((reg,zone,cereal,nwtype),ACZ_input.L(reg,zone,cereal,nwtype,s));
CashACirrX(s,%1,%2)                                       = sum((reg,zone,cash,wtype),ACZ_input.L(reg,zone,cash,wtype,s));
CashACdryX(s,%1,%2)                                       = sum((reg,zone,cash,nwtype),ACZ_input.L(reg,zone,cash,nwtype,s));

GrainTYCX(s,%1,%2)$GrainACX(s,%1,%2)                        = 1000*sum(cereal,TQSX(cereal,s,%1,%2))/GrainACX(s,%1,%2);
CashTYCX(s,%1,%2)$CashACX(s,%1,%2)                          = 1000*sum(cash,TQSX(cash,s,%1,%2))/CashACX(s,%1,%2);

GrainTYCirrX(s,%1,%2)$GrainACirrX(s,%1,%2)                  = 1000*sum(cereal,TQSirrX(cereal,s,%1,%2))/GrainACirrX(s,%1,%2);
GrainTYCdryX(s,%1,%2)$GrainACdryX(s,%1,%2)                  = 1000*sum(cereal,TQSdryX(cereal,s,%1,%2))/GrainACdryX(s,%1,%2);
CashTYCirrX(s,%1,%2)$CashACirrX(s,%1,%2)                    = 1000*sum(cash,TQSirrX(cash,s,%1,%2))/CashACirrX(s,%1,%2);
CashTYCdryX(s,%1,%2)$CashACdryX(s,%1,%2)                    = 1000*sum(cash,TQSdryX(cash,s,%1,%2))/CashACdryX(s,%1,%2);

* =============== Calories ================
*CALpcX(c,s,%1,%2)          = 10*KcalRatio(c)*sum( (reg,zone),QFZ.L(reg,zone,c,s) ) / (365*sum((reg,zone,urbrur),PopH(reg,zone,urbrur))) ;
CALpcX(c,'belg',%1,%2)          = 10*KcalRatio(c)*sum( (reg,zone),QFZ.L(reg,zone,c,'belg') ) / (151*sum((reg,zone,urbrur),PopH(reg,zone,urbrur))) ;
CALpcX(c,'meher',%1,%2)          = 10*KcalRatio(c)*sum( (reg,zone),QFZ.L(reg,zone,c,'meher') ) / (214*sum((reg,zone,urbrur),PopH(reg,zone,urbrur))) ;
CALpcX(c,'annual',%1,%2)          = 10*KcalRatio(c)*sum( (reg,zone),QFZ.L(reg,zone,c,'annual') ) / (365*sum((reg,zone,urbrur),PopH(reg,zone,urbrur))) ;
TCALpcX(s,%1,%2)           = sum(c,CALpcX(c,s,%1,%2) ) ;

*CALpc_DefX(c,s,%1,%2)      = 10*KcalRatio(c)*sum( (reg,zone)$(sum(cereal,QFZ0(reg,zone,cereal,s) - QSZ0(reg,zone,cereal,s)) gt 0),QFZ.L(reg,zone,c,s) )/
*                          (365*sum((reg,zone,urbrur)$(sum(cereal,QFZ0(reg,zone,cereal,s) - QSZ0(reg,zone,cereal,s)) gt 0),PopH(reg,zone,urbrur))) ;
*CALpc_SurX(c,s,%1,%2)      = 10*KcalRatio(c)*sum((reg,zone)$(sum(cereal,QFZ0(reg,zone,cereal,s) - QSZ0(reg,zone,cereal,s)) le 0),QFZ.L(reg,zone,c,s))/
*                          (365*sum((reg,zone,urbrur)$(sum(cereal,QFZ0(reg,zone,cereal,s) - QSZ0(reg,zone,cereal,s)) le 0),PopH(reg,zone,urbrur))) ;

*CALpc_DefX(c,s,%1,%2)      = 10*KcalRatio(c)*sum( (reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,s) - QSZ.L(reg,zone,cereal,s)) gt 0),QFZ.L(reg,zone,c,s) )/
*                          (365*sum((reg,zone,urbrur)$(sum(cereal,QFZ.L(reg,zone,cereal,s) - QSZ.L(reg,zone,cereal,s)) gt 0),PopH(reg,zone,urbrur))) ;
CALpc_DefX(c,'belg',%1,%2)      = 10*KcalRatio(c)*sum( (reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,'belg') - QSZ.L(reg,zone,cereal,'belg')) gt 0),QFZ.L(reg,zone,c,'belg') )/
                          (151*sum((reg,zone,urbrur)$(sum(cereal,QFZ.L(reg,zone,cereal,'belg') - QSZ.L(reg,zone,cereal,'belg')) gt 0),PopH(reg,zone,urbrur))) ;
CALpc_DefX(c,'meher',%1,%2)      = 10*KcalRatio(c)*sum( (reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,'meher') - QSZ.L(reg,zone,cereal,'meher')) gt 0),QFZ.L(reg,zone,c,'meher') )/
                          (214*sum((reg,zone,urbrur)$(sum(cereal,QFZ.L(reg,zone,cereal,'meher') - QSZ.L(reg,zone,cereal,'meher')) gt 0),PopH(reg,zone,urbrur))) ;
CALpc_DefX(c,'annual',%1,%2)      = 10*KcalRatio(c)*sum( (reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,'annual') - QSZ.L(reg,zone,cereal,'annual')) gt 0),QFZ.L(reg,zone,c,'annual') )/
                          (365*sum((reg,zone,urbrur)$(sum(cereal,QFZ.L(reg,zone,cereal,'annual') - QSZ.L(reg,zone,cereal,'annual')) gt 0),PopH(reg,zone,urbrur))) ;
*CALpc_SurX(c,s,%1,%2)      = 10*KcalRatio(c)*sum((reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,s) - QSZ.L(reg,zone,cereal,s)) le 0),QFZ.L(reg,zone,c,s))/
*                          (365*sum((reg,zone,urbrur)$(sum(cereal,QFZ.L(reg,zone,cereal,s) - QSZ.L(reg,zone,cereal,s)) le 0),PopH(reg,zone,urbrur))) ;
CALpc_SurX(c,'belg',%1,%2)      = 10*KcalRatio(c)*sum((reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,'belg') - QSZ.L(reg,zone,cereal,'belg')) le 0),QFZ.L(reg,zone,c,'belg'))/
                          (151*sum((reg,zone,urbrur)$(sum(cereal,QFZ.L(reg,zone,cereal,'belg') - QSZ.L(reg,zone,cereal,'belg')) le 0),PopH(reg,zone,urbrur))) ;
CALpc_SurX(c,'meher',%1,%2)      = 10*KcalRatio(c)*sum((reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,'meher') - QSZ.L(reg,zone,cereal,'meher')) le 0),QFZ.L(reg,zone,c,'meher'))/
                          (214*sum((reg,zone,urbrur)$(sum(cereal,QFZ.L(reg,zone,cereal,'meher') - QSZ.L(reg,zone,cereal,'meher')) le 0),PopH(reg,zone,urbrur))) ;
CALpc_SurX(c,'annual',%1,%2)      = 10*KcalRatio(c)*sum((reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,'annual') - QSZ.L(reg,zone,cereal,'annual')) le 0),QFZ.L(reg,zone,c,'annual'))/
                          (365*sum((reg,zone,urbrur)$(sum(cereal,QFZ.L(reg,zone,cereal,'annual') - QSZ.L(reg,zone,cereal,'annual')) le 0),PopH(reg,zone,urbrur))) ;


TCALpc_DefX(s,%1,%2)       = sum(c,CALpc_DefX(c,s,%1,%2) ) ;
TCALpc_SurX(s,%1,%2)       = sum(c,CALpc_SurX(c,s,%1,%2) ) ;

pmalnX(s,%1,%2)$log(TCALpcX(s,%1,%2))                          = intermal(s) + melas*log(TCALpcX(s,%1,%2)) ;
nmalnX(s,%1,%2)$pmalnX(s,%1,%2)                                = pmalnX(s,%1,%2)*Ninfant/100 ;

pmaln_defX(s,%1,%2)$log(TCALpc_defX(s,%1,%2))                  = intermal(s) + melas*log(TCALpc_defX(s,%1,%2)) ;
nmaln_defX(s,%1,%2)$pmaln_defX(s,%1,%2)                        = 0.63*pmaln_defX(s,%1,%2)*Ninfant/100 ;

pmaln_surX(s,%1,%2)$log(TCALpc_surX(s,%1,%2))                  = intermal(s) + melas*log(TCALpc_surX(s,%1,%2)) ;
nmaln_surX(s,%1,%2)$pmaln_surX(s,%1,%2)                        = 0.37*pmaln_surX(s,%1,%2)*Ninfant/100 ;

demshr(C,s,%1,%2)$sum((reg,zone,cp),QFZ0(reg,zone,cp,s))      =
                 sum((reg,zone),PCZ.L(reg,zone,c,s)*QFZ.L(reg,zone,c,s))/sum((reg,zone,cp),PCZ.L(reg,zone,cp,s)*QFZ.L(reg,zone,cp,s)) * 100;

 TIncomeBalX(s,%1,%2)$sum((reg,zone,c),PPZ.L(reg,zone,c,s)*QSZ.L(reg,zone,c,s)) =
                   sum((reg,zone,c),PCZ.L(reg,zone,c,s)*QFZ.L(reg,zone,c,s))/
                   sum((reg,zone,c),PPZ.L(reg,zone,c,s)*QSZ.L(reg,zone,c,s)) ;

* ============== REGIONAL RESULTS ====================
 PPRX(REG,C,s,%1,%2)$SUM(ZONE,QSZ0(reg,zone,c,s))  = SUM(ZONE,PPZ.L(REG,ZONE,c,s)*QSZ0(reg,zone,c,s))/SUM(ZONE,QSZ0(reg,zone,c,s));
 PCRX(REG,C,s,%1,%2)$SUM(ZONE,QFZ0(reg,zone,c,s))  = SUM(ZONE,PCZ.L(REG,ZONE,c,s)*QFZ0(reg,zone,c,s))/SUM(ZONE,QFZ0(reg,zone,c,s));

 QFRX(REG,C,s,%1,%2)                            = SUM(ZONE,QFZ.L(reg,zone,c,s));
 GRAINQFRX(REG,s,%1,%2)                         = SUM((zone,cereal),QFZ.L(reg,zone,cereal,s));
 LVQFRX(REG,s,%1,%2)                            = SUM((zone,lv),QFZ.L(reg,zone,lv,s));
 QSRX(REG,C,s,%1,%2)                            = SUM((zone),QSZ.L(reg,zone,c,s));
 GRAINQSRX(REG,s,%1,%2)                         = SUM((zone,cereal),QSZ.L(reg,zone,cereal,s));
 LVQSRX(REG,s,%1,%2)                            = SUM((zone,lv),QSZ.L(reg,zone,lv,s));
 CashQSRX(REG,s,%1,%2)                          = SUM((zone,cash),QSZ.L(reg,zone,cash,s));
 ACRX(REG,C,s,%1,%2)                            = SUM((zone),ACZ.L(reg,zone,c,s));
 YCRX(REG,C,s,%1,%2)$ACrX(REG,C,s,%1,%2)             = 1000*QSRX(REG,C,s,%1,%2)/ACRX(REG,C,s,%1,%2);

GrainACRX(reg,s,%1,%2)                          = sum((zone,cereal),ACZ.L(reg,zone,cereal,s));
CashACRX(reg,s,%1,%2)                           = sum((zone,cash),ACZ.L(reg,zone,cash,s));
GrainYCRX(reg,s,%1,%2)$GrainACrX(reg,s,%1,%2)     = 1000*sum(cereal,QSRX(reg,cereal,s,%1,%2))/GrainACRX(reg,s,%1,%2);
CashYCRX(reg,s,%1,%2)$CashACrX(reg,s,%1,%2)       = 1000*sum(cash,QSRX(reg,cash,s,%1,%2))/CashACRX(reg,s,%1,%2);

QFRpcX(reg,c,s,%1,%2)                      = sum((zone),QFZ.L(reg,zone,c,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));
GrainQFRpcX(reg,s,%1,%2)                   = sum((zone,cereal),QFZ.L(reg,zone,cereal,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));
LVQFRpcX(reg,s,%1,%2)                      = sum((zone,lv),QFZ.L(reg,zone,lv,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));
QSRpcX(reg,c,s,%1,%2)                      = sum((zone),QSZ.L(reg,zone,c,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));
GrainQSRpcX(reg,s,%1,%2)                   = sum((zone,cereal),QSZ.L(reg,zone,cereal,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));
LVQSRpcX(reg,s,%1,%2)                      = sum((zone,lv),QSZ.L(reg,zone,lv,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));

GrainACRX(reg,s,%1,%2)                          = sum((zone,cereal),ACZ.L(reg,zone,cereal,s));
CashACRX(reg,s,%1,%2)                           = sum((zone,cash),ACZ.L(reg,zone,cash,s));
GrainYCRX(reg,s,%1,%2)$GrainACrX(reg,s,%1,%2)     = 1000*sum(cereal,QSRX(reg,cereal,s,%1,%2))/GrainACRX(reg,s,%1,%2);
CashYCRX(reg,s,%1,%2)$CashACrX(reg,s,%1,%2)       = 1000*sum(cash,QSRX(reg,cash,s,%1,%2))/CashACRX(reg,s,%1,%2);

QFRpcX(reg,c,s,%1,%2)                      = sum((zone),QFZ.L(reg,zone,c,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));
GrainQFRpcX(reg,s,%1,%2)                   = sum((zone,cereal),QFZ.L(reg,zone,cereal,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));
LVQFRpcX(reg,s,%1,%2)                      = sum((zone,lv),QFZ.L(reg,zone,lv,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));
QSRpcX(reg,c,s,%1,%2)                      = sum((zone),QSZ.L(reg,zone,c,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));
GrainQSRpcX(reg,s,%1,%2)                   = sum((zone,cereal),QSZ.L(reg,zone,cereal,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));
LVQSRpcX(reg,s,%1,%2)                      = sum((zone,lv),QSZ.L(reg,zone,lv,s))/sum((zone,urbrur),PopH(reg,zone,urbrur));

 GRAINDEFRX(REG,s,%1,%2)$GRAINQFRX(REG,s,%1,%2)  = GRAINQFRX(REG,s,%1,%2) - GRAINQSRX(REG,s,%1,%2) ;
 GRAINDEFshRX(REG,s,%1,%2)$GRAINQFRX(REG,s,%1,%2)  = 100*GRAINDEFRX(REG,s,%1,%2)/GRAINQFRX(REG,s,%1,%2) ;

 ALLACRX(REG,s,%1,%2)                   = SUM((zone,c),ACZ.L(REG,zone,c,s));

 GDPRX(REG,s,%1,%2)                     = sum((zone),GDPZpc.L(reg,zone,s)*1000*sum((urbrur),PopH(reg,zone,urbrur))) ;

 AgGDPRX(REG,s,%1,%2)                   = sum((zone,ag)$(QSZ0(reg,zone,ag,s) and not cereal(ag)),PPZ.L(reg,zone,ag,s)*QSZ.L(reg,zone,ag,s))
                                      + sum((zone,cereal)$(QSZ0(reg,zone,cereal,s) and DQTZ0(reg,zone,cereal,s) gt 0),
                                  PPZ0(reg,zone,cereal,s)*PopHShare(reg,zone,'rur')*QSZ.L(reg,zone,cereal,s) +
                                  PPZ.L(reg,zone,cereal,s)*(1 - PopHShare(reg,zone,'rur'))*QSZ.L(reg,zone,cereal,s))
                                      + sum((zone,cereal)$(QSZ0(reg,zone,cereal,s) and DQTZ0(reg,zone,cereal,s) le 0),
                                  PPZ0(reg,zone,cereal,s)*PopHShare(reg,zone,'rur')*QFZ.L(reg,zone,cereal,s) +
                                  PPZ.L(reg,zone,cereal,s)*(QSZ.L(reg,zone,cereal,s) - PopHShare(reg,zone,'rur')*QFZ.L(reg,zone,cereal,s)));


 NAgGDPRX(REG,s,%1,%2)                  = sum((zone,nag),PPZ0(reg,zone,nag,s)*QSZ.L(reg,zone,nag,s)) ;


 GDPRpcX(REG,s,%1,%2)$GDPRX(REG,s,%1,%2)           = GDPRX(REG,s,%1,%2)/(1000*sum((zone,urbrur),PopH(reg,zone,urbrur)));
 AgGDPRpcX(REG,s,%1,%2)$AgGDPRX(REG,s,%1,%2)       = AgGDPRX(REG,s,%1,%2)/(1000*sum((zone,urbrur),PopH(reg,zone,urbrur)));
 NAgGDPRpcX(REG,s,%1,%2)$NAgGDPRX(REG,s,%1,%2)     = NAgGDPRX(REG,s,%1,%2)/(1000*sum((zone,urbrur),PopH(reg,zone,urbrur)));

 CONRX(reg,s,%1,%2)     = sum((zone,c),PCZ0(reg,zone,c,s)*QFZ.L(reg,zone,c,s)) ;
 AgCONRX(reg,s,%1,%2)   = sum((zone,ag),PCZ0(reg,zone,ag,s)*QFZ.L(reg,zone,ag,s)) ;

 CONRpcX(reg,s,%1,%2)$CONRX(reg,s,%1,%2)           = CONRX(reg,s,%1,%2)/(1000*sum((zone,urbrur),PopH(reg,zone,urbrur)));
 AgCONRpcX(reg,s,%1,%2)$AgCONRX(reg,s,%1,%2)       = AgCONRX(reg,s,%1,%2)/(1000*sum((zone,urbrur),PopH(reg,zone,urbrur)));

*Population
 PoPRX(REG,%1,%2)                      = sum((zone,urbrur),PopH(reg,zone,urbrur));
 PoPHRX(REG,urbrur,%1,%2)              = sum((zone),PopH(reg,zone,urbrur));
 PoPHZX(REG,zone,urbrur,%1,%2)         = PopH(reg,zone,urbrur);
 PoPZX(REG,ZONE,%1,%2)$sum(urbrur,PopH(reg,zone,urbrur))           = sum(urbrur,PopH(reg,zone,urbrur));

*CALRPCX(REG,C,s,%1,%2) = 10*KcalRatio(c,s)*sum((zone),QFZ.L(reg,zone,c,s))/(365*sum((zone,urbrur),PopH(reg,zone,urbrur))) ;
CALRPCX(REG,C,'belg',%1,%2) = 10*KcalRatio(c)*sum((zone),QFZ.L(reg,zone,c,'belg'))/(151*sum((zone,urbrur),PopH(reg,zone,urbrur))) ;
CALRPCX(REG,C,'meher',%1,%2) = 10*KcalRatio(c)*sum((zone),QFZ.L(reg,zone,c,'meher'))/(214*sum((zone,urbrur),PopH(reg,zone,urbrur))) ;
CALRPCX(REG,C,'annual',%1,%2) = 10*KcalRatio(c)*sum((zone),QFZ.L(reg,zone,c,'annual'))/(365*sum((zone,urbrur),PopH(reg,zone,urbrur))) ;

TCALRPCX(REG,s,%1,%2) = sum(C,CALRPCX(REG,C,s,%1,%2) ) ;

IncomeBalRX(reg,s,%1,%2)$sum((zone,c),PPZ.L(reg,zone,c,s)*QSZ.L(reg,zone,c,s)) =
                        sum((zone,c),PCZ.L(reg,zone,c,s)*QFZ.L(reg,zone,c,s))/
                        sum((zone,c),PPZ.L(reg,zone,c,s)*QSZ.L(reg,zone,c,s)) ;


 demshrR(REG,C,s,%1,%2)$sum((zone,cp),QFZ0(reg,zone,cp,s))      =
                 sum((zone),PCZ.L(reg,zone,c,s)*QFZ.L(reg,zone,c,s))/sum((zone,cp),PCZ.L(reg,zone,cp,s)*QFZ.L(reg,zone,cp,s)) * 100;


* ================== ZONAL RESULTS =======================
CONZX(reg,zone,s,%1,%2)     = sum((c),PCZ0(reg,zone,c,s)*QFZ.L(reg,zone,c,s)) ;
 AgCONZX(reg,zone,s,%1,%2)   = sum((ag),PCZ0(reg,zone,ag,s)*QFZ.L(reg,zone,ag,s)) ;

 CONZpcX(reg,zone,s,%1,%2)$CONZX(reg,zone,s,%1,%2)           = CONZX(reg,zone,s,%1,%2)/(1000*sum((urbrur),PopH(reg,zone,urbrur)));
 AgCONZpcX(reg,zone,s,%1,%2)$AgCONZX(reg,zone,s,%1,%2)       = AgCONZX(reg,zone,s,%1,%2)/(1000*sum((urbrur),PopH(reg,zone,urbrur)));

 GDPZX(REG,ZONE,s,%1,%2)                     = GDPZpc.L(reg,zone,s)*1000*sum((urbrur),PopH(reg,zone,urbrur)) ;
*$ontext
 AgGDPZX(REG,ZONE,s,%1,%2)                   = sum(ag$(QSZ0(reg,zone,ag,s) and not cereal(ag)),PPZ.L(reg,zone,ag,s)*QSZ.L(reg,zone,ag,s))
                                      + sum(cereal$(QSZ0(reg,zone,cereal,s) and DQTZ0(reg,zone,cereal,s) gt 0),
                                  PPZ0(reg,zone,cereal,s)*PopHShare(reg,zone,'rur')*QSZ.L(reg,zone,cereal,s) +
                                  PPZ.L(reg,zone,cereal,s)*(1 - PopHShare(reg,zone,'rur'))*QSZ.L(reg,zone,cereal,s))
                                      + sum(cereal$(QSZ0(reg,zone,cereal,s) and DQTZ0(reg,zone,cereal,s) le 0),
                                  PPZ0(reg,zone,cereal,s)*PopHShare(reg,zone,'rur')*QFZ.L(reg,zone,cereal,s) +
                                  PPZ.L(reg,zone,cereal,s)*(QSZ.L(reg,zone,cereal,s) - PopHShare(reg,zone,'rur')*QFZ.L(reg,zone,cereal,s)));
*$offtext
* AgGDPZX(REG,ZONE,s,%1,%2)                  = sum(ag,PPZ.L(reg,zone,ag,s)*QSZ.L(reg,zone,ag,s)) ;
 NAgGDPZX(REG,ZONE,s,%1,%2)                  = sum(nag,PPZ.L(reg,zone,nag,s)*QSZ.L(reg,zone,nag,s)) ;
* NAgGDPZX(REG,ZONE,s,%1,%2)                  = sum(nag,PPZ0(reg,zone,nag,s)*QSZ.L(reg,zone,nag,s)) ;

 GDPZpcX(REG,ZONE,s,%1,%2)$sum(urbrur,PopH(reg,zone,urbrur))        = GDPZpc.L(reg,zone,s);
 AgGDPZpcX(REG,ZONE,s,%1,%2)$sum(urbrur,PopH(reg,zone,urbrur))      = AgGDPZX(REG,ZONE,s,%1,%2)/(1000*sum(urbrur,PopH(reg,zone,urbrur)));
 NAgGDPZpcX(REG,ZONE,s,%1,%2)$sum(urbrur,PopH(reg,zone,urbrur))     = NAgGDPZX(REG,ZONE,s,%1,%2)/(1000*sum(urbrur,PopH(reg,zone,urbrur)));


*CALZPCX(REG,ZONE,C,s,%1,%2)$sum(urbrur,PopH(reg,zone,urbrur)) = 10*KcalRatio(c)*QFZ.L(reg,zone,c,s)/(365*sum(urbrur,PopH(reg,zone,urbrur))) ;
CALZPCX(REG,ZONE,C,'belg',%1,%2)$sum(urbrur,PopH(reg,zone,urbrur)) = 10*KcalRatio(c)*QFZ.L(reg,zone,c,'belg')/(151*sum(urbrur,PopH(reg,zone,urbrur))) ;
CALZPCX(REG,ZONE,C,'meher',%1,%2)$sum(urbrur,PopH(reg,zone,urbrur)) = 10*KcalRatio(c)*QFZ.L(reg,zone,c,'meher')/(214*sum(urbrur,PopH(reg,zone,urbrur))) ;
CALZPCX(REG,ZONE,C,'annual',%1,%2)$sum(urbrur,PopH(reg,zone,urbrur)) = 10*KcalRatio(c)*QFZ.L(reg,zone,c,'annual')/(365*sum(urbrur,PopH(reg,zone,urbrur))) ;
TCALZPCX(REG,ZONE,s,%1,%2)$SUM(URBRUR,PopH(reg,zone,urbrur))  = sum(C,CALZPCX(REG,ZONE,C,s,%1,%2) ) ;

IncomeBalZX(reg,zone,s,%1,%2)$sum(c,PPZ.L(reg,zone,c,s)*QSZ.L(reg,zone,c,s)) =
          sum(c,PCZ.L(reg,zone,c,s)*QFZ.L(reg,zone,c,s))/sum(c,PPZ.L(reg,zone,c,s)*QSZ.L(reg,zone,c,s)) ;


* ================ Income (from GDP) ===============
HHIZX(reg,zone,'urb',HHS,s,%1,%2)          = HHIZshare(reg,zone,'urb',HHS,s)*NAgGDPZX(reg,zone,s,%1,%2);
HHIZX(reg,zone,'rur',HHS,s,%1,%2)          = HHIZshare(reg,zone,'rur',HHS,s)*AgGDPZX(reg,zone,s,%1,%2);

HHIZX(reg,zone,'rur',HHS,s,%1,%2)$(sum(HHSP,HHIZshare(reg,zone,'urb',HHSP,s)) eq 0)
          = HHIZshare(reg,zone,'rur',HHS,s)*(AgGDPZX(reg,zone,s,%1,%2) + NAgGDPZX(reg,zone,s,%1,%2));

HHIZX(reg,zone,'urb',HHS,s,%1,%2)$(sum(HHSP,HHIZshare(reg,zone,'rur',HHSP,s)) eq 0)
          = HHIZshare(reg,zone,'urb',HHS,s)*(AgGDPZX(reg,zone,s,%1,%2) + NAgGDPZX(reg,zone,s,%1,%2));

PoPHZX(reg,zone,urbrur,%1,%2)            = PopH(reg,zone,urbrur);
HHIZpcX(reg,zone,urbrur,HHS,s,%1,%2)$HHIZX(reg,zone,urbrur,HHS,s,%1,%2) =
                    HHIZX(reg,zone,urbrur,HHS,s,%1,%2)/(0.1*1000*PopHZX(reg,zone,urbrur,%1,%2));

*HHpoorX(reg,zone,'rur',HHS,s,%1,%2)$(HHIZpcX(reg,zone,'rur',HHS,s,%1,%2) gt 0 and HHIZpcX(reg,zone,'rur',HHS,s,%1,%2) le 0.7531*97.54) =
*                    HHIZpcX(reg,zone,'rur',HHS,s,%1,%2);
*HHpoorX(reg,zone,'urb',HHS,s,%1,%2)$(HHIZpcX(reg,zone,'urb',HHS,s,%1,%2) gt 0 and HHIZpcX(reg,zone,'urb',HHS,s,%1,%2) le 1.2427*115.26) =
*                    HHIZpcX(reg,zone,'urb',HHS,s,%1,%2) ;
HHpoorX(reg,zone,'rur',HHS,'belg',%1,%2)$(HHIZpcX(reg,zone,'rur',HHS,'belg',%1,%2) gt 0 and HHIZpcX(reg,zone,'rur',HHS,'belg',%1,%2) le 0.7531*97.54*1.82*5/12) =
                    HHIZpcX(reg,zone,'rur',HHS,'belg',%1,%2);
HHpoorX(reg,zone,'urb',HHS,'belg',%1,%2)$(HHIZpcX(reg,zone,'urb',HHS,'belg',%1,%2) gt 0 and HHIZpcX(reg,zone,'urb',HHS,'belg',%1,%2) le 1.2427*115.26*2.43*5/12) =
                    HHIZpcX(reg,zone,'urb',HHS,'belg',%1,%2) ;
HHpoorX(reg,zone,'rur',HHS,'meher',%1,%2)$(HHIZpcX(reg,zone,'rur',HHS,'meher',%1,%2) gt 0 and HHIZpcX(reg,zone,'rur',HHS,'meher',%1,%2) le 0.7531*97.54*1.82*7/12) =
                    HHIZpcX(reg,zone,'rur',HHS,'meher',%1,%2);
HHpoorX(reg,zone,'urb',HHS,'meher',%1,%2)$(HHIZpcX(reg,zone,'urb',HHS,'meher',%1,%2) gt 0 and HHIZpcX(reg,zone,'urb',HHS,'meher',%1,%2) le 1.2427*115.26*2.43*7/12) =
                    HHIZpcX(reg,zone,'urb',HHS,'meher',%1,%2) ;
HHpoorX(reg,zone,'rur',HHS,'annual',%1,%2)$(HHIZpcX(reg,zone,'rur',HHS,'annual',%1,%2) gt 0 and HHIZpcX(reg,zone,'rur',HHS,'annual',%1,%2) le 0.7531*97.54*1.82) =
                    HHIZpcX(reg,zone,'rur',HHS,'annual',%1,%2);
HHpoorX(reg,zone,'urb',HHS,'annual',%1,%2)$(HHIZpcX(reg,zone,'urb',HHS,'annual',%1,%2) gt 0 and HHIZpcX(reg,zone,'urb',HHS,'annual',%1,%2) le 1.2427*115.26*2.43) =
                    HHIZpcX(reg,zone,'urb',HHS,'annual',%1,%2) ;

PoPpoorZX(reg,zone,urbrur,s,%1,%2)$sum(HHS,HHpoorX(reg,zone,urbrur,HHS,s,%1,%2)) =
                sum(HHS$HHpoorX(reg,zone,urbrur,HHS,s,%1,%2),HHIZX(reg,zone,urbrur,HHS,s,%1,%2)/
                                         HHIZpcX(reg,zone,urbrur,HHS,s,%1,%2)) ;

PoPpoorHX(urbrur,s,%1,%2)  = sum((reg,zone),PoPpoorZX(reg,zone,urbrur,s,%1,%2));
PoPpoorX(s,%1,%2)          = sum((reg,zone,urbrur),PoPpoorZX(reg,zone,urbrur,s,%1,%2));

PoorLineAllX(s,%1,%2)$sum(urbrur,PoPpoorHX(urbrur,s,%1,%2)) =
       100*sum(urbrur,PoPpoorHX(urbrur,s,%1,%2))/sum((reg,zone,urbrur),1000*PoPHZX(reg,zone,urbrur,%1,%2)) ;

PoorLineHX(urbrur,s,%1,%2)$PoPpoorHX(urbrur,s,%1,%2) =
       100*PoPpoorHX(urbrur,s,%1,%2)/sum((reg,zone),1000*PoPHZX(reg,zone,urbrur,%1,%2)) ;

PoorLineRuR_DEFX(s,%1,%2) =
          100*sum((reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,s) - QSZ.L(reg,zone,cereal,s)) gt 0),
          PoPpoorZX(reg,zone,'rur',s,%1,%2))/sum((reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,s) - QSZ.L(reg,zone,cereal,s)) gt 0),
          1000*PoPHZX(reg,zone,'rur',%1,%2)) ;

PoorLineRuR_SURX(s,%1,%2) =
          100*sum((reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,s) - QSZ.L(reg,zone,cereal,s)) le 0),
          PoPpoorZX(reg,zone,'rur',s,%1,%2))/sum((reg,zone)$(sum(cereal,QFZ.L(reg,zone,cereal,s) - QSZ.L(reg,zone,cereal,s)) le 0),
          1000*PoPHZX(reg,zone,'rur',%1,%2)) ;



GDPZHX(Naddis,zone,'urb',s,%1,%2)        = incomenagsh(Naddis,zone,'urb',s)*sum(nag$QSZ0(Naddis,zone,nag,s),
                                       PPZ0(Naddis,zone,nag,s)*QSZ.L(Naddis,zone,nag,s)) ;

GDPZHX('addisAbaba',zone,'urb',s,%1,%2)  = sum(c$QSZ0('AddisAbaba',zone,c,s),PPZ0('AddisAbaba',zone,c,s)*QSZ.L('AddisAbaba',zone,c,s)) ;

GDPZHX(Naddis,zone,'rur',s,%1,%2)$(GDPZH0(Naddis,zone,'rur',s) and AGCPIX(s,%1,%2))        = (incomenagsh(Naddis,zone,'rur',s)*
             sum(nag$QSZ0(Naddis,zone,nag,s),PPZ0(Naddis,zone,nag,s)*QSZ.L(Naddis,zone,nag,s))
           + sum(ag,PPZ0(Naddis,zone,ag,s)*QSZ.L(Naddis,zone,ag,s)) ) ;

GDPZHpcX(REG,zone,urbrur,s,%1,%2)$GDPZHX(REG,zone,urbrur,s,%1,%2)         = GDPZHX(REG,zone,urbrur,s,%1,%2)/(1000*PopH(reg,zone,urbrur)) ;



* ================ Inputtype ================
GrainACZ_inputTypeX(reg,zone,type,s,%1,%2)                          = sum(cereal,ACZ_input.L(reg,zone,cereal,type,s));
GrainTACZ_inputTypeX(type,s,%1,%2)                                  = sum((reg,zone,cereal),ACZ_input.L(reg,zone,cereal,type,s));
GrainTQSZ_inputTypeX(type,s,%1,%2)                                  = sum((reg,zone,cereal),QSZ_input.L(reg,zone,cereal,type,s));
GrainTYCZ_inputTypeX(type,s,%1,%2)$GrainTACZ_inputTypeX(type,s,%1,%2) = 1000*GrainTQSZ_inputTypeX(type,s,%1,%2)/GrainTACZ_inputTypeX(type,s,%1,%2);

TACZ_inputTypeX(type,s,%1,%2)                                       = sum((reg,zone,c),ACZ_input.L(reg,zone,c,type,s));
TQSZ_inputTypeX(type,s,%1,%2)                                       = sum((reg,zone,c),QSZ_input.L(reg,zone,c,type,s));
TYCZ_inputTypeX(type,s,%1,%2)$TACZ_inputTypeX(type,s,%1,%2)           = 1000*TQSZ_inputTypeX(type,s,%1,%2)/TACZ_inputTypeX(type,s,%1,%2);

TYC_inputTypeX(crop,type,s,%1,%2)$sum((reg,zone),ACZ_input.L(reg,zone,crop,type,s))
                                                                  = 1000*sum((reg,zone),QSZ_input.L(reg,zone,crop,type,s))/sum((reg,zone),ACZ_input.L(reg,zone,crop,type,s));
TAC_inputX(c,type,s,%1,%2)                                          = sum((reg,zone),ACZ_input.L(reg,zone,c,type,s));


