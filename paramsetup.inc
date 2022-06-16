parameter

* ================================ 1 parameters for simLoopSave.inc =======================
* === additional ===

TVQS0X(C,s,sim,y)
TVQS0irrX(C,s,sim,y)
TVQS0dryX(C,s,sim,y)
GrainVQS0X(s,sim,y)
GrainTVQSZ0_inputFertX(s,sim,y)
CashVQS0X(s,sim,y)
GRAINVQS0irrX(s,sim,y)
CASHVQS0irrX(s,sim,y)
GRAINVQS0dryX(s,sim,y)
CASHVQS0dryX(s,sim,y)
PPIX(s,sim,y)
AGCPIX(s,sim,y)
AGPPIX(s,sim,y)
AGCPIRX(reg,s,sim,y)
AGPPIRX(reg,s,sim,y)
AGCPIZX(reg,zone,s,sim,y)
AGPPIZX(reg,zone,s,sim,y)
ToTQSX(s,sim,y)
ToTVQSX(s,sim,y)
ToTAgQSX(s,sim,y)
ToTAgVQSX(s,sim,y)
ToTAgVQS0X(s,sim,y)
GDPZHX(reg,zone,urbrur,s,sim,y)
GDPZHpcX(REG,zone,urbrur,s,sim,y)
GDPpcX(s,sim,y)
AgGDPRpcX(REG,s,sim,y)
NAgGDPRpcX(REG,s,sim,y)
PoPRX(REG,sim,y)
PoPHRX(REG,urbrur,sim,y)
PoPZX(REG,ZONE,sim,y)


* ============= Export percentage =============
QEinQSX(ag,s,sim,y)                                       percentage (%) of export ag comm in total supply ag comm

* ================= Demand ===============
TQFX(c,s,sim,y)                                           total food demand for each comm
GrainQFX(s,sim,y)                                         total food cereal demand
LVQFX(s,sim,y)                                            total livestock demand
TQLX(c,s,sim,y)                                           total livestock demand for each livestock
TQOX(c,s,sim,y)                                           total other demand for each
TQDX(c,s,sim,y)                                           total demand for each comm

* ================= Supply ===============
* ==== Total
TQSX(c,s,sim,y)                                           total supply for each comm
TVQSX(c,s,sim,y)                                          total supply in $ for each comm

TQSirrX(c,s,sim,y)                                        total supply with wtype input technology
TVQSirrX(c,s,sim,y)                                       total supply with wtype input technology in $
TQSdryX(c,s,sim,y)                                        total supply with non-wtype input technology
TVQSdryX(c,s,sim,y)                                       total supply with non-wtype input technology in $

* ==== Grain & Cash
GrainQSX(s,sim,y)                                         total cereal supply
GrainVQSX(s,sim,y)                                        total cereal supply in $

GrainTQSZ_inputFertX(s,sim,y)                             total cereal supply with fertilizer type input
GrainTACZ_inputFertX(s,sim,y)                             total cereal area with fertilizer type input
GrainTVQSZ_inputFertX(s,sim,y)                            total cereal supply with fertilizer type input in $
GrainTYCZ_inputFertX(s,sim,y)                             total cereal yield with fertilizer type supply

CashQSX(s,sim,y)                                          total cash crop supply
CashVQSX(s,sim,y)                                         total cash crop supply in $

GrainQSirrX(s,sim,y)                                      total cereal supply with watertype input
GrainVQSirrX(s,sim,y)                                     total cereal supply with watertype input in $
CashQSirrX(s,sim,y)                                       total cash crop supply with watertype input
CashVQSirrX(s,sim,y)                                      total cash crop supply with watertype input in $

GrainVQSdryX(s,sim,y)                                     total cereal supply with non-watertype input in $
GrainQSdryX(s,sim,y)                                      total cereal supply with non-watertype input
CashVQSdryX(s,sim,y)                                      total cash crop supply with watertype input in $
CashQSdryX(s,sim,y)                                       total cash crop supply with watertype input

* ================ per capita Demand & Supply ===================
TQFpcX(c,s,sim,y)                                         total food demand per capita
GrainQFpcX(s,sim,y)                                       total cereal demand per capita
LVQFpcX(s,sim,y)                                          total livestock demand per capita
TQSpcX(c,s,sim,y)                                         total supply per capita
GrainQSpcX(s,sim,y)                                       total grain supply per capita
LVQSpcX(s,sim,y)                                          total livestock supply per capita

* =============== Consumption, GDP, Supply at national level ===============
CONX(s,sim,y)                              total food demand in $ (food consumption)
AgCONX(s,sim,y)                            total ag food consumption

CONpcX(s,sim,y)                            total consumption per capita
AgCONpcX(s,sim,y)                          total ag food consumption per capita

AgGDPX(s,sim,y)                            total ag supply in $ (GDP)
NAgGDPX(s,sim,y)                           total nag GDP
GDPX(s,sim,y)                              total GDP

ToTVQSX(s,sim,y)                           total supply in $ (should be same with GDPX)

AgGDPpcX(s,sim,y)                          total Ag GDP per capita
NAgGDPpcX(s,sim,y)                         total nonAg GDP per capita

* =============== Deficit & Surplus ==========
TDQTZX(c,s,sim,y)                                         total deficit aggregated in each zone
GrainDQTZX(s,sim,y)                                       total cereal deficit

* ================ Area & Yield =============
TYCX(c,s,sim,y)                                           total yield
TACirrX(c,s,sim,y)                                        total area with irrigation (wtype)
TACdryX(c,s,sim,y)                                        total area without irrigaiton (nwtype)
TYCirrX(c,s,sim,y)                                        total yield with irrigation
TYCdryX(c,s,sim,y)                                        total yield without irrigation

ALLACX(s,sim,y)                                           total area
ALLACirrX(s,sim,y)                                        total irrigation area
ALLACdryX(s,sim,y)                                        total non-irrigated area

GrainACX(s,sim,y)                                         total area for cereals
CashACX(s,sim,y)                                          total area for cash crops

GrainACirrX(s,sim,y)                                      total area for cereals with irri
GrainACdryX(s,sim,y)                                      total area for cereals without irri
CashACirrX(s,sim,y)                                       total area for cash crops with irri
CashACdryX(s,sim,y)                                       total area for cash crops without irri

GrainTYCX(s,sim,y)                                        total yield for cereal
CashTYCX(s,sim,y)                                         total yield for cash crop

GrainTYCirrX(s,sim,y)                                     total yield for cereal with irrigation
GrainTYCdryX(s,sim,y)                                     total yield for cereal without irrigaion
CashTYCirrX(s,sim,y)                                      total yield for cash crops with irrigation
CashTYCdryX(s,sim,y)                                      total yield for cash crops without irrigation

* =============== Calories ================
CALpcX(c,s,sim,y)                                  caleries per capita for each comm
TCALpcX(s,sim,y)                                   total caleries per capita

CALpc_DefX(c,s,sim,y)                              caleries per capita deficit
CALpc_SurX(c,s,sim,y)                              caleries per capita surplus

TCALpc_DefX(s,sim,y)                               caleries per capita deficit
TCALpc_SurX(s,sim,y)                               caleries per capita surplus

PMALNX(s,sim,y)                                    percentage of malnourished children
NMALNX(s,sim,y)                                    number of malnorished children

PMALN_defX(s,sim,y)                                percentage of malnourished children for deficit zones
NMALN_defX(s,sim,y)                                number of malnorished children for deficit zones

PMALN_surX(s,sim,y)                                percentage of malnourished children for surplus zones
NMALN_surX(s,sim,y)                                number of malnorished children for surplus zones

demshr(c,s,sim,y)                                  ratio of food demand for c ($) over total demand ($)
TIncomeBalX(s,sim,y)                               ratio of total food demand ($) over total supply ($)

* ============== REGIONAL RESULTS ====================
PPRX(reg,c,s,sim,y)                                regional producer price
PCRX(reg,c,s,sim,y)                                regional consumer price
QFRX(reg,c,s,sim,y)                                regional food demand
GrainQFRX(reg,s,sim,y)                             regional cereal demand
LVQFRX(reg,s,sim,y)                                regional lv demand
QSRX(reg,c,s,sim,y)                                regional supply
GrainQSRX(reg,s,sim,y)                             regional cereal supply
LVQSRX(reg,s,sim,y)                                regional lv supply
CashQSRX(reg,s,sim,y)                              regional cash crop supply
ACRX(reg,c,s,sim,y)                                regional area
YCRX(reg,c,s,sim,y)                                regional yield

GrainACRX(reg,s,sim,y)                             regional cereal area
CashACRX(reg,s,sim,y)                              regional cash crop area
GrainYCRX(reg,s,sim,y)                             regional cereal yield
CashYCRX(reg,s,sim,y)                              regional cash crop yield

QFRpcX(reg,c,s,sim,y)                              regional food demand per capita
GrainQFRpcX(reg,s,sim,y)                           regional grain demand per capita
LVQFRpcX(reg,s,sim,y)                              regional lv demand per capita
QSRpcX(reg,c,s,sim,y)                              regional supply per capita
GrainQSRpcX(reg,s,sim,y)                           regional grain supply per capita
LVQSRpcX(reg,s,sim,y)                              regional lv supply per capita

GrainDefRX(reg,s,sim,y)                            regional grain deficit (demand -supply)
GrainDefshRX(reg,s,sim,y)                          regional grain deficit divided by regional graind demand

ALLACRX(reg,s,sim,y)                               regional total area
GDPRX(reg,s,sim,y)                                 regional GDP
GDPRpcX(reg,s,sim,y)                               regional per capita GDP
AgGDPRX(reg,s,sim,y)                                          regional Ag GDP
NAgGDPRX(reg,s,sim,y)                                         regional NAg GDP

CONRX(reg,s,sim,y)                                 regional food consumption ($)
AgCONRX(reg,s,sim,y)                               regional ag consumption ($)

CONRpcX(reg,s,sim,y)                               regional food consumption per capita ($)
AgCONRpcX(reg,s,sim,y)                             regional ag consumption per capita

CALRpcX(reg,c,s,sim,y)                             regional caleries per capita for each c
TCALRpcX(reg,s,sim,y)                              regional total caleries per capita

demshrR(reg,c,s,sim,y)                             regional food demand ($) divided by total food supply
IncomeBalRX(reg,s,sim,y)                           regional food demand ($) divided by total food supply

* ================== ZONAL RESULTS =======================
GrainQFZX(reg,zone,s,sim,y)                        zonal total cereal demand
LVQFZX(reg,zone,s,sim,y)                           zonal total lv demand

GrainQSZX(reg,zone,s,sim,y)                        zonal total cereal supply
LVQSZX(reg,zone,s,sim,y)                           zonal total lv supply
CashQSZX(reg,zone,s,sim,y)                         zonal total cash crop supply

GrainACZX(reg,zone,s,sim,y)                        zonal total grain area
CashACZX(reg,zone,s,sim,y)                         zonal total cash crop area

QFZpcX(reg,zone,c,s,sim,y)                         zonal food demand per capita
GrainQFZpcX(reg,zone,s,sim,y)                      zonal grain demand per capita
LVQFZpcX(reg,zone,s,sim,y)                         zonal lv demand per capita
QSZpcX(reg,zone,c,s,sim,y)                         zonal food supply per capita
GrainQSZpcX(reg,zone,s,sim,y)                      zonal grain supply per capita
LVQSZpcX(reg,zone,s,sim,y)                         zonal lv supply per capita

GrainDefZX(reg,zone,s,sim,y)                       zonal grain deficit
GrainDefshZX(reg,zone,s,sim,y)                     zonal grain deficit divided by zonal grain demand

ALLACZX(reg,zone,s,sim,y)                          zonal all area

CONZX(reg,zone,s,sim,y)                            zonal total consumption
AgCONZX(reg,zone,s,sim,y)                          zonal ag consumption

CONZpcX(reg,zone,s,sim,y)                          zonal total cons,simption per capita
AgCONZpcX(reg,zone,s,sim,y)                        zonal ag consumption per capita

GDPZX(reg,zone,s,sim,y)                            zonal GDP
NAgGDPZX(reg,zone,s,sim,y)                         zonal nag GDP
AgGDPZX(reg,zone,s,sim,y)                          zonel ag GDP

AgGDPZpcX(reg,zone,s,sim,y)                        zonal ag GDP per capita
NAgGDPZpcX(reg,zone,s,sim,y)                       zonal nag GDP per captia

CALZpcX(reg,zone,c,s,sim,y)                        zonal calories per capita
TCALZpcX(reg,zone,s,sim,y)                         zonal calories per capita

IncomeBalZX(reg,zone,s,sim,y)                      zonal demand divided by zonal supply
demshrZ(reg,zone,c,s,sim,y)                        zonal demand share

* ================ Income ===============
HHIZX(reg,zone,urbrur,HHS,s,sim,y)                 zonal household income
HHIZpcX(reg,zone,urbrur,HHS,s,sim,y)               zonal household income per capita

HHpoorX(reg,zone,urbrur,HHS,s,sim,y)               zonal income of poor household

PoPHZX(reg,zone,urbrur,sim,y)

PoPpoorZX(reg,zone,urbrur,s,sim,y)                 zonal population under poverty line
PoPpoorHX(urbrur,s,sim,y)                          national total population under poverty line for urban and rural
PoPpoorX(s,sim,y)                                  national total population under poverty line
PoorLineAllX(s,sim,y)                              ratio of poor pop over all
PoorLineHX(urbrur,s,sim,y)                         ratio of poor pop over all rural or all urban pop
PoorLineRuR_DEFX(s,sim,y)                          ratio of poor pop over all for cereal deficit zones in rural area
PoorLineRuR_SURX(s,sim,y)                          ratio of poor pop over all for cereal surplus zones in rural area
* ================ Inputtype ================
GrainACZ_inputTypeX(reg,zone,type,s,sim,y)                          zonal grain area for diff input types
GrainTACZ_inputTypeX(type,s,sim,y)                                  total grain area for diff input types
GrainTQSZ_inputTypeX(type,s,sim,y)                                  total grain supply for diff input types
GrainTYCZ_inputTypeX(type,s,sim,y)                                  total grain yield for diff input types

TACZ_inputTypeX(type,s,sim,y)                                       total area for diff input types
TQSZ_inputTypeX(type,s,sim,y)                                       total supply for diff input types
TYCZ_inputTypeX(type,s,sim,y)                                       total yield for diff input types

TYC_inputTypeX(crop,type,s,sim,y)                                   total yield for each crop and diff input types

TAC_inputX(c,type,s,sim,y)                                          total area for each crop and diff input types


* ================================ 2 parameters for simScDif.inc =======================

* ========================= (1) Absolute change from BASE Scenario ============================

* == Consumption (demand) and GDP (supply) =====
 CONCHX(s,sim,y)                    consumption  abs change from base sc
 AgCONCHX(s,sim,y)                  ag consumption  abs change from base sc
 GDPCHX(s,sim,y)                    GDP  abs change from base sc
 AgGDPCHX(s,sim,y)                  agGDP  abs change from base sc

 CONpcCHX(s,sim,y)                  consumption pc  abs change from base sc
 AgCONpcCHX(s,sim,y)                ag consumption  abs change from base sc
* GDPpcCHX(s,sim,y)                  GDP pc  abs change from base sc
 AgGDPpcCHX(s,sim,y)                agGDP pc  abs change from base sc

* ==== area, supply, value of supply ======

 ACCHX(s,sim,y)                     total area  abs change from base sc
 GrainACCHX(s,sim,y)                grain area  abs change from base sc
 CashACCHX(s,sim,y)                 cash crop area  abs change from base sc

 CROPQSCHX(s,sim,y)                 crop supply  abs change from base sc
 GrainQSCHX(s,sim,y)                grain supply  abs change from base sc
 CashQSCHX(s,sim,y)                 cash crop supply  abs change from base sc

 CROPVQSCHX(s,sim,y)                total value of crop supply  abs change from base sc
 GrainVQSCHX(s,sim,y)               total value of grain supply  abs change from base sc
 CashVQSCHX(s,sim,y)                total value of cash crop supply  abs change from base sc

 ACirrCHX(s,sim,y)                  total irri area  abs change from base sc
 GrainACirrCHX(s,sim,y)             irri grain area  abs change from base sc
 CashACirrCHX(s,sim,y)              irri cash crop area  abs change from base sc

 CROPQSirrCHX(s,sim,y)              supply from irri crops  abs change from base sc
 GrainQSirrCHX(s,sim,y)             supply from irri grain  abs change from base sc
 CashQSirrCHX(s,sim,y)              supply from irri cash crop  abs change from base sc

 CROPVQSirrCHX(s,sim,y)             total value of irri crop supply  abs change from base sc
 GrainVQSirrCHX(s,sim,y)            total value of irri grain supply  abs change from base sc
 CashVQSirrCHX(s,sim,y)             total value of irri cash crop supply  abs change from base sc

 ACdryCHX(s,sim,y)                  total non-irri area  abs change from base sc
 GrainACdryCHX(s,sim,y)             non-irri area of grain  abs change from base sc
 CashACdryCHX(s,sim,y)              non-irri area of cash crop  abs change from base sc

 CROPQSdryCHX(s,sim,y)              supply of non-irri crop  abs change from base sc
 GrainQSdryCHX(s,sim,y)             supply of non-irri grain  abs change from base sc
 CashQSdryCHX(s,sim,y)              supply of non-irri cash crop  abs change from base sc

 CROPVQSdryCHX(s,sim,y)             value of non-irri crop supply  abs change from base sc
 GrainVQSdryCHX(s,sim,y)            value of non-irri grain supply  abs change from base sc
 CashVQSdryCHX(s,sim,y)             value of non-irri cash crop supply  abs change from base sc


* ==== Demand and Supply =====
 TQFCHX(c,s,sim,y)                  food demand  abs change from base sc
 GRAINQFCHX(s,sim,y)                grain demand  abs change from base sc
 LVQFCHX(s,sim,y)                   livestock demand  abs change from base sc
 TQLCHX(c,s,sim,y)                  feed demand  abs change from base sc
 TQOCHX(c,s,sim,y)                  other demand  abs change from base sc
 TQDCHX(c,s,sim,y)                  total demand  abs change from base sc

 TQSCHX(c,s,sim,y)                  total supply  abs change from base sc
 TVQSCHX(c,s,sim,y)                 total value of supply  abs change from base sc
 TQFpcCHX(c,s,sim,y)                total food demand pc  abs change from base sc
 TQSpcCHX(c,s,sim,y)                total supply pc  abs change from base sc

 GrainQSpcCHX(s,sim,y)              grain supply pc  abs change from base sc
 GrainQFpcCHX(s,sim,y)              grain demand pc  abs change from base sc
 LVQSpcCHX(s,sim,y)                 livestock supply pc  abs change from base sc
 LVQFpcCHX(s,sim,y)                 livestock demand pc  abs change from base sc
* LVVQSCHX(s,sim,y)
* LVQSCHX(s,sim,y)

 TQSirrCHX(c,s,sim,y)               supply of irri crops  abs change from base sc
 TVQSirrCHX(c,s,sim,y)              value of irri crop supply  abs change from base sc
 TQSdryCHX(c,s,sim,y)               supply of non-irri crops  abs change from base sc
 TVQSdryCHX(c,s,sim,y)              value of non-irri crop supply  abs change from base sc

* === area & yield ===
 TACCHX(c,s,sim,y)                  total area  abs change from base sc  for each c
 TYCCHX(c,s,sim,y)                  total yield   abs change from base sc for each c
 GrainTYCCHX(s,sim,y)               total grain yield   abs change from base sc
 CashTYCCHX(s,sim,y)                total cash crop  yield   abs change from base sc

 TYCirrCHX(c,s,sim,y)               total yield of irri crops   abs change from base sc
 GrainTYCirrCHX(s,sim,y)            total irri grain yield  abs change from base sc
 CashTYCirrCHX(s,sim,y)             total irri cash crop yield   abs change from base sc

 TACdryCHX(c,s,sim,y)               total non-irri area   abs change from base sc
 TYCdryCHX(c,s,sim,y)               total non-irri  yield   abs change from base sc
 GrainTYCdryCHX(s,sim,y)            total non-irri grain yield   abs change from base sc
 CashTYCdryCHX(s,sim,y)             total non-irri cash crop yield   abs change from base sc

 ALLACirrCHX(s,sim,y)               total irri area   abs change from base sc
 ALLACdryCHX(s,sim,y)               total non-irri area   abs change from base sc


* === price ===
 PPCHX(c,s,sim,y)                   producer price   abs change from base sc  for each c
 PCCHX(c,s,sim,y)                   consumer price   abs change from base sc  for each c

* === import/export ===
 QECHX(c,s,sim,y)                   export   abs change from base sc
 QMCHX(c,s,sim,y)                   import   abs change from base sc


*==== input type =====
 GrainTACZ_inputFertCHX(s,sim,y)           fertilized grain area   abs change from base sc
 GrainTQSZ_inputFertCHX(s,sim,y)           fertilized grain supply   abs change from base sc
 GrainTyCZ_inputFertCHX(s,sim,y)           fertilized grain yield   abs change from base sc

 GrainTACZ_inputTypeCHX(type,s,sim,y)      grain area   abs change from base sc  for input types
 GrainTYCZ_inputTypeCHX(type,s,sim,y)      grain yield   abs change from base sc  for input types
 GrainTQSZ_inputTypeCHX(type,s,sim,y)      grain supply   abs change from base sc  for input types

 TACZ_inputTypeCHX(type,s,sim,y)           total area   abs change from base sc  for input types
 TYCZ_inputTypeCHX(type,s,sim,y)           total yield   abs change from base sc  for input types
 TQSZ_inputTypeCHX(type,s,sim,y)           total supply   abs change from base sc  for input types

 TYC_inputTypeCHX(crop,type,s,sim,y)       total yield   abs change from base sc for input types and crops types

* ==== Calories ====
CALPCCHX(c,s,sim,y)                        cal pc   abs change from base sc  for each c
TCALPCCHX(s,sim,y)                         total cal pc   abs change from base sc
TCALpc_DefCHX(s,sim,y)                     total cal pc   abs change from base sc  for cereal deficit zones
TCALpc_SurCHX(s,sim,y)                     total cal pc   abs change from base sc  for cereal surplus zones

* === poverty ====
PoPpoorHCHX(urbrur,s,sim,y)                Poor pop   abs change from base sc
PoPpoorCHX(s,sim,y)                        Poor pop   abs change from base sc
PoorLineAllCHX(s,sim,y)                    Poor pop percentage   abs change from base sc
PoorLineHCHX(urbrur,s,sim,y)               Poor pop percentage   abs change from base sc
PoorLineRuR_DEFCHX(s,sim,y)                rural Poor pop percentage   abs change from base sc  for cereal deficit zones
PoorLineRuR_SURCHX(s,sim,y)                rural Poor pop percentage   abs change from base sc  for cereal surplus zones

* === for maize and teff (mt)====
mtPPCHX(RAINcrop,s,sim,y)                  maize and teff producer price   abs change from base sc
mtTQSCHX(RAINcrop,s,sim,y)                 maize and teff supply   abs change from base sc
mtTVQSCHX(RAINcrop,s,sim,y)                maize and teff value of supply  abs change from base sc
mtTYCCHX(RAINcrop,s,sim,y)                 maize and teff yield   abs change from base sc
mtTACCHX(RAINcrop,s,sim,y)                 maize and teff area   abs change from base sc

mtTCALpcCHX(RAINcrop,s,sim,y)              maize and teff cal pc   abs change from base sc

mtTVQSCHCX(s,sim)                 maize and teff cummulative   abs change from base sc  over yrs

$ontext
* ========= (2) percente change from calibrated BASE yr '2015' ==================

* == Consumption (demand) and GDP (supply) =====
 CONXPBASE(s,sim,y)                        consumption   percente change from calibrated BASE yr '2015'
 AgCONXPBASE(s,sim,y)                      ag consumption  percente change from calibrated BASE yr '2015'
 CONpcXPBASE(s,sim,y)                      consumption pc  percente change from calibrated BASE yr '2015'
 AgCONpcXPBASE(s,sim,y)                    ag consumnption  percente change from calibrated BASE yr '2015'

 GDPXPBASE(s,sim,y)                        GDP   percente change from calibrated BASE yr '2015'
 AgGDPXPBASE(s,sim,y)                      agGDP  percente change from calibrated BASE yr '2015'
 NAgGDPXPBASE(s,sim,y)                     NAgGDP  percente change from calibrated BASE yr '2015'

* === price percentage change ===
 PPXPBASE(c,s,sim,y)                       producer price   percente change from calibrated BASE yr '2015'
 PCXPBASE(c,s,sim,y)                       consumer price   percente change from calibrated BASE yr '2015'

* === import/export percentage change ===
 QEXPBASE(c,s,sim,y)                       export    percente change from calibrated BASE yr '2015'
 QMXPBASE(c,s,sim,y)                       import    percente change from calibrated BASE yr '2015'

* === demand & supply percemtage change ===
 TQFXPBASE(c,s,sim,y)                      food demand   percente change from calibrated BASE yr '2015'
 GRAINQFXPBASE(s,sim,y)                    grain demand   percente change from calibrated BASE yr '2015'
 LVQFXPBASE(s,sim,y)                       livestock demand   percente change from calibrated BASE yr '2015'
 TQLXPBASE(c,s,sim,y)                      feed demand    percente change from calibrated BASE yr '2015'
 TQOXPBASE(c,s,sim,y)                      other demand   percente change from calibrated BASE yr '2015'
 TQDXPBASE(c,s,sim,y)                      total demand   percente change from calibrated BASE yr '2015'

 TQSXPBASE(c,s,sim,y)                      total supply   percente change from calibrated BASE yr '2015'
 TVQSXPBASE(c,s,sim,y)                     total value of supply     percente change from calibrated BASE yr '2015'


*        === per capita ====
 TQFpcXPBASE(c,s,sim,y)                    food demand pc    percente change from calibrated BASE yr '2015'
 TQSpcXPBASE(c,s,sim,y)                    total supply pc   percente change from calibrated BASE yr '2015'

 GrainQSpcXPBASE(s,sim,y)                  grain supply pc   percente change from calibrated BASE yr '2015'
 GrainQFpcXPBASE(s,sim,y)                  grain demand pc   percente change from calibrated BASE yr '2015'
 LVQSpcXPBASE(s,sim,y)                     livestock supply pc   percente change from calibrated BASE yr '2015'
 LVQFpcXPBASE(s,sim,y)                     livestock demand pc   percente change from calibrated BASE yr '2015'
*        ====

 GRAINVQSXPBASE(s,sim,y)                   total value of grain supply   percente change from calibrated BASE yr '2015'
 GRAINQSXPBASE(s,sim,y)                    total grain supply   percente change from calibrated BASE yr '2015'

 LVVQSXPBASE(s,sim,y)                      total value of livestock supply   percente change from calibrated BASE yr '2015'
 LVQSXPBASE(s,sim,y)                       total livestock supply   percente change from calibrated BASE yr '2015'

 CashVQSXPBASE(s,sim,y)                    total value of cash crop supply   percente change from calibrated BASE yr '2015'
 CashQSXPBASE(s,sim,y)                     total cash crop supply   percente change from calibrated BASE yr '2015'

 TQSirrXPBASE(c,s,sim,y)                   total value of irri crop supply   percente change from calibrated BASE yr '2015'
 TVQSirrXPBASE(c,s,sim,y)                  total irri crop supply   percente change from calibrated BASE yr '2015'

 GRAINVQSirrXPBASE(s,sim,y)                total value of irri grain supply   percente change from calibrated BASE yr '2015'
 GRAINQSirrXPBASE(s,sim,y)                 total irri grain supply   percente change from calibrated BASE yr '2015'

 CashVQSirrXPBASE(s,sim,y)                 total value of irri cash crop supply   percente change from calibrated BASE yr '2015'
 CashQSirrXPBASE(s,sim,y)                  total irri cash crop supply   percente change from calibrated BASE yr '2015'

 TQSdryXPBASE(c,s,sim,y)                   total value of non-irri crop supply   percente change from calibrated BASE yr '2015'
 TVQSdryXPBASE(c,s,sim,y)                  total non-irri crop supply   percente change from calibrated BASE yr '2015'

 GRAINVQSdryXPBASE(s,sim,y)                total value of non-irri grain supply   percente change from calibrated BASE yr '2015'
 GRAINQSdryXPBASE(s,sim,y)                 total non-irri grain supply   percente change from calibrated BASE yr '2015'

 CashVQSdryXPBASE(s,sim,y)                 total value of non-irri cash crop supply   percente change from calibrated BASE yr '2015'
 CashQSdryXPBASE(s,sim,y)                  total non-irri cash crop supply   percente change from calibrated BASE yr '2015'

* === area & yield percent change ===
 TACXPBASE(c,s,sim,y)                      total area     percente change from calibrated BASE yr '2015'
 TYCXPBASE(c,s,sim,y)                      total yield    percente change from calibrated BASE yr '2015'
 GrainACXPBASE(s,sim,y)                    grain area     percente change from calibrated BASE yr '2015'
 CashACXPBASE(s,sim,y)                     cash crop area     percente change from calibrated BASE yr '2015'
 GrainTYCXPBASE(s,sim,y)                   grain yield    percente change from calibrated BASE yr '2015'
 CashTYCXPBASE(s,sim,y)                    cash crop yield    percente change from calibrated BASE yr '2015'

 TACirrXPBASE(c,s,sim,y)                   total irri area    percente change from calibrated BASE yr '2015'
 TYCirrXPBASE(c,s,sim,y)                   total irri yield   percente change from calibrated BASE yr '2015'
 GrainACirrXPBASE(s,sim,y)                 irri grain area    percente change from calibrated BASE yr '2015'
 CashACirrXPBASE(s,sim,y)                  irri cash crop area     percente change from calibrated BASE yr '2015'
 GrainTYCirrXPBASE(s,sim,y)                irri grain yield   percente change from calibrated BASE yr '2015'
 CashTYCirrXPBASE(s,sim,y)                 irri cash crop yield    percente change from calibrated BASE yr '2015'

 TACdryXPBASE(c,s,sim,y)                   total non-irri area    percente change from calibrated BASE yr '2015'
 TYCdryXPBASE(c,s,sim,y)                   total non-irri yield   percente change from calibrated BASE yr '2015'
 GrainACdryXPBASE(s,sim,y)                 non-irri grain area    percente change from calibrated BASE yr '2015'
 CashACdryXPBASE(s,sim,y)                  non-irri cash crop area     percente change from calibrated BASE yr '2015'
 GrainTYCdryXPBASE(s,sim,y)                non-irri grain yield   percente change from calibrated BASE yr '2015'
 CashTYCdryXPBASE(s,sim,y)                 non-irri cash crop yield    percente change from calibrated BASE yr '2015'

 ALLACXPBASE(s,sim,y)                      total area   percente change from calibrated BASE yr '2015'
 ALLACirrXPBASE(s,sim,y)                   total irri area     percente change from calibrated BASE yr '2015'
 ALLACdryXPBASE(s,sim,y)                   total non-irri area     percente change from calibrated BASE yr '2015'

*==== input type =====
 GrainTACZ_inputFertXPBASE(s,sim,y)        fertilized grain area     percente change from calibrated BASE yr '2015'
 GrainTQSZ_inputFertXPBASE(s,sim,y)        fertilized grain supply     percente change from calibrated BASE yr '2015'
 GrainTyCZ_inputFertXPBASE(s,sim,y)        fertilized grain yield     percente change from calibrated BASE yr '2015'

 GrainTACZ_inputTypeXPBASE(type,s,sim,y)   grain area     percente change from calibrated BASE yr '2015'    for input types
 GrainTYCZ_inputTypeXPBASE(type,s,sim,y)   grain yield     percente change from calibrated BASE yr '2015'   for input types
 GrainTQSZ_inputTypeXPBASE(type,s,sim,y)   grain supply     percente change from calibrated BASE yr '2015'  for input types

 TACZ_inputTypeXPBASE(type,s,sim,y)        total area     percente change from calibrated BASE yr '2015'     for input types
 TYCZ_inputTypeXPBASE(type,s,sim,y)        total yield     percente change from calibrated BASE yr '2015'    for input types
 TQSZ_inputTypeXPBASE(type,s,sim,y)        total supply     percente change from calibrated BASE yr '2015'   for input types

 TYC_inputTypeXPBASE(crop,type,s,sim,y)    total area     percente change from calibrated BASE yr '2015'     for input types and crop types

* ==== Calories ====
CALPCXPBASE(c,s,sim,y)                    cal pc      percente change from calibrated BASE yr '2015'     for each c
TCALPCXPBASE(s,sim,y)                     total cal pc    percente change from calibrated BASE yr '2015'
$offtext

;
