$TITLE Multimarket model for Ethiopia agriculture
* Revised by JONATHAN LALA (JL) 2021/02 based on script by Ying ZHANG 2016/10 based on script ZonalModel4Input.gms  cleaner version
* ying 6 - adjusted for zero kcmean situations
*===================================================================================================================
* Developed by Xinshen, 12/2003
* Disaggregate production to zonal level
* Zonal level demand but with national market to balance supply and demand
*1. There are 11 regions and 56 zones in production in the model ***JL: THERE ARE NOW 93 ZONES***
*2. There are cross price elasticities in area function and for livestock it is the number of the head,
*3. There is only own price elasticity in yield function of prices, but technical shift parameter links with
*   a technical model done by Charles
*4. Food demand for each commodity at zonal level is a function of all prices and income
*   from the zone, taking into account of rural and urban income and demand, add up to national level
*5. By-product is modeled as a function of main product
*6. Feed demand is modeled as a function of livestock production but is very small
*7. For tradable goods, world prices are exgenous and domestic producer and consumer prices are function of
*   world prices with marketing margins which are exogenous
*8. For non-traded good, domestic prices are endogenously determined by market clearing condition and there
*   are marketing margins on both proudction and consumption sides
*9. Growth in income, area, yields are exogenous variable
*10. MCP is used for shift from non-traded to imports/exports
*===================================================================================================================

*CHANGES BY P. BLOCK:    added two excel dump commands to analyze irrigation area
*                        gave a Kcmean (CYF) to cash crops equal to the maximum cereal CYF for any given zone
*                        split final yield equation into water-type (Kcmean=1) and no water-type (Kcmean as reported)
*                        added a "crop intensity" factor that allows for multiple crop rotations per NEW irri area per year.
*                                doubling the newly irrigated area is a surrogate way of saying 2 crop harvests/year
*                                currently set at 2 rotations/year for cereals.  cash crops left at 1 rotation/year
* Ying Zhang
* PARAMETER with '0' is the calculated value under calibration which will be assigned to varibale w/o '0' for solving the model
* parameter redefined without '0' to enter the real model/ seperate from calibratiob process
* CHANGES BY J. LALA:    updated zones and data to ~2015 (some data from 2011-2016)
*                        disaggregated area/production and consumption/expenditure into two seasons: Belg (Jan-May) and Meher (June-Dec)

SET
* ying -we will only use t=2003 for calibration and no growth rate over t is considered in simulations ***JL: t=2015 in this updated version***
* i.e. only change kcmean with other parameters constant
T          Time     /2015*2032/

* JL: new index/set: seasons
S        two seasons plus annual
 /belg, meher, annual/

* ========= commodity SETs =============
C         34 ag commodities
 /Maize,Wheat,Teff,Sorghum,Barley,Millet,Oats,Rice,Potatoes,SweetPotatoes,Enset,RootsOther,SugarRawEquivalent,Beans,Peas
PulsesOther,Ground_nuts,Rapeseed,OilcropsOther,Sesame,Tomato_Onion,VegetablesOther,Bananas,Fruits,Coffee,Beverage_spices
Stimulants from chat - a type of stimulating plant
CottonLint,BovineMeat,Mutton_GoatMeat,Poultry_Egg,MeatOther,Milk,Fish
Nagtrade,Nagntrade/

AG(c)     Agricultural commodities
 /Maize,Wheat,Teff,Sorghum,Barley,Millet,Oats,Rice,Potatoes,SweetPotatoes,Enset,RootsOther,SugarRawEquivalent,Beans,Peas
PulsesOther,Ground_nuts,Rapeseed,OilcropsOther,Sesame,Tomato_Onion,VegetablesOther,Bananas,Fruits,Coffee,Beverage_spices
Stimulants,CottonLint,BovineMeat,Mutton_GoatMeat,Poultry_Egg,MeatOther,Milk,Fish/

CROP(c)   crops
 /Maize,Wheat,Teff,Sorghum,Barley,Millet,Oats,Rice,Potatoes,SweetPotatoes,Enset,RootsOther,SugarRawEquivalent,Beans,Peas
PulsesOther,Ground_nuts,Rapeseed,OilcropsOther,Sesame,Tomato_Onion,VegetablesOther,Bananas,Fruits,Coffee,Beverage_spices
Stimulants,CottonLint/

RAINcrop(c) crops which are affected by climatic factors (CYFs)
 /Maize,Wheat,Teff,Sorghum,Barley,Millet/

CEREAL(c)
/Maize,Wheat,Teff,Sorghum,Barley,Millet,Oats,Rice/

CASH(c)      cash ag commodities
 /Enset,RootsOther,Beans,Peas,PulsesOther,Potatoes,SweetPotatoes,SugarRawEquivalent,Ground_nuts,Rapeseed,OilcropsOther
Sesame,Tomato_Onion,VegetablesOther,Bananas,Fruits,Coffee,Beverage_spices,Stimulants,CottonLint/

STAPLE(c)
 /Maize,Wheat,Teff,Sorghum,Barley,Millet,Oats,Rice,Potatoes,SweetPotatoes,Enset,RootsOther,Beans,Peas,PulsesOther,Ground_nuts,
Rapeseed,OilcropsOther,BovineMeat,Mutton_GoatMeat,Poultry_Egg,MeatOther,Milk,Fish/

OSTAPLE(c)
 /Potatoes,SweetPotatoes,Enset,RootsOther,Beans,Peas,PulsesOther,Ground_nuts,Rapeseed,OilcropsOther/

OSTAPLESM(c)
 /Potatoes,SweetPotatoes,Enset,RootsOther,Beans,Peas,PulsesOther/

smallcereal(c)
 /Sorghum,Barley,Millet,Oats/

pulse(c)
 /Beans,Peas,PulsesOther/

roots(c)
 /Potatoes,SweetPotatoes,Enset,RootsOther/

oilseed(c)
 /Ground_nuts,Rapeseed,Sesame,OilcropsOther/

Allothfod(c)
 /Coffee,Beverage_spices,SugarRawEquivalent/

LV(c)        Livestock
 /BovineMeat,Mutton_GoatMeat,Poultry_Egg,MeatOther,Milk,Fish/

meat(C)      Livestock
 /BovineMeat,Mutton_GoatMeat,Poultry_Egg,MeatOther,Fish/

veg_fruit(C)
 /Tomato_Onion,VegetablesOther,Fruits,Bananas/

ntradition(c)
/SugarRawEquivalent,Sesame,Tomato_Onion,VegetablesOther,Bananas,Fruits,Stimulants,CottonLint/

ofood(C)       other food
 /Potatoes,SweetPotatoes,Enset,RootsOther,SugarRawEquivalent,Beans,Peas,PulsesOther,Ground_nuts,
Rapeseed,OilcropsOther,Sesame,Tomato_Onion,VegetablesOther,Bananas,Fruits,Coffee,Beverage_spices,Stimulants/

CROPinput(C)      Agricultural commodities
 /Maize,Wheat,Teff,Sorghum,Barley,Millet,Oats,PulsesOther,Sesame,OilcropsOther/

CROPnone(C)       Agricultural commodities
 /Rice,Potatoes,SweetPotatoes,Enset,RootsOther,SugarRawEquivalent,Beans,Peas,Ground_nuts,Rapeseed,Tomato_Onion,
VegetablesOther,Bananas,Fruits,Coffee,Beverage_spices,Stimulants,CottonLint/


NCR(c)    Noncrops without yield function  /BovineMeat,Mutton_GoatMeat,Poultry_Egg,MeatOther,Milk,Fish,Nagtrade,Nagntrade/

*JL: traded/imported/exported commodity list much bigger than 2005 list. Several options here:

* Option 1: Original list
*$ontext
TC(C)     Traded commodities
/Wheat,Rice,Sesame,Tomato_Onion,Coffee,Stimulants,CottonLint/

MC(c)     Imported commodities
/Wheat,Rice/

EC(c)     Exported commodities
/Sesame,Tomato_Onion,Coffee,Stimulants,CottonLint/

NTC2(c)     Non-traded commodities
/PulsesOther,Enset,RootsOther,MeatOther,Milk,nagtrade,nagntrade/
*$offtext

* Option 2: complete list of traded and nontraded commodities (see NationQ)
$ontext
TC(C)     Traded commodities
/Wheat,Barley,Maize,Oats,Millet,Sorghum,Teff,Rice,Potatoes,SugarRawEquivalent,Beans,Peas,PulsesOther,Ground_nuts,
OilcropsOther,Sesame,Tomato_Onion,VegetablesOther,Bananas,Fruits,Stimulants,Coffee,Beverage_spices,CottonLint,
BovineMeat,Mutton_GoatMeat,Poultry_Egg,MeatOther,Milk,Fish/

MC(c)     Imported commodities
/Wheat,Barley,Oats,Sorghum,Rice,SugarRawEquivalent,Peas,
OilcropsOther,Fruits,Beverage_spices,
Poultry_Egg,Milk/

EC(c)     Exported commodities
/Maize,Millet,Teff,Potatoes,Beans,PulsesOther,Ground_nuts,
Sesame,Tomato_Onion,VegetablesOther,Bananas,Stimulants,Coffee,CottonLint,
BovineMeat,Mutton_GoatMeat,MeatOther,Fish/

NTC2(c)     Non-traded commodities
*JL: seems like only this combo (or the original, above) will actually run
/Enset,RootsOther,nagtrade,nagntrade/
*/SweetPotatoes,Enset,RootsOther,Rapeseed,nagtrade,nagntrade/
*/PulsesOther,Enset,RootsOther,Rapeseed,MeatOther,Milk,nagtrade,nagntrade/
$offtext


* Option 3: curated list of traded and nontraded commodities (see NationQ)
$ontext
TC(C)     Traded commodities
/Wheat,Barley,Maize,Sorghum,Teff,Rice,Potatoes,SugarRawEquivalent,Beans,Peas,PulsesOther,Ground_nuts,
OilcropsOther,Sesame,Tomato_Onion,VegetablesOther,Bananas,Fruits,Stimulants,Coffee,Beverage_spices,CottonLint,
BovineMeat,Mutton_GoatMeat/

MC(c)     Imported commodities
/Maize,Wheat,Barley,Sorghum,Rice,SugarRawEquivalent,Peas,Ground_nuts,
OilcropsOther,Fruits,Beverage_spices/

EC(c)     Exported commodities
/Maize,Teff,Potatoes,Beans,PulsesOther,Ground_nuts,
Sesame,Tomato_Onion,VegetablesOther,Bananas,Stimulants,Coffee,CottonLint,
BovineMeat,Mutton_GoatMeat/

NTC2(c)     Non-traded commodities
*JL: seems like only this combo (or the original, above) will actually run
/Enset,RootsOther,nagtrade,nagntrade/
*/SweetPotatoes,Enset,RootsOther,Rapeseed,nagtrade,nagntrade/
*/PulsesOther,Enset,RootsOther,Rapeseed,MeatOther,Milk,nagtrade,nagntrade/
$offtext



AIDC(c)   food adi commodities  /Wheat/

NTR_NAG(c)      not include nagntrade and transpt
NTC(c)          Non-traded commodities



CR(c)           crops
NAG(c)          non-ag commodities

* ============= region, zone, urban or rural SETs =============
REG        11 Regions plus two foreign regions
 /Afar, Amhara, Benshangul, Gambella, Oromia, Somali, Tigray, Southern, AddisAbaba, DireDawa, Harari/

Naddis(reg)
/Afar, Amhara, Benshangul, Gambella, Oromia, Somali, Tigray, Southern, DireDawa, Harari /

ZONE 93 zones
 /
NorthwestTigray          North Western Tigray (Tigray)
CentralTigray            Central Tigray (Tigray)
EastTigray               Eastern Tigray (Tigray)
SouthTigray              South Tigray (Tigray)
WestTigray               Western Tigray (Tigray)
MekeleSpecial            Mekele Especial Zone (Tigray)
Afar1                    Zone 1 (Afar)
Afar2                    Zone 2 (Afar)
Afar3                    Zone 3 (Afar)
Afar4                    Zone 4 (Afar)
Afar5                    Zone 5 (Afar)
NorthGondar              North Gondar (Amhara)
SouthGondar              South Gondar (Amhara)
NorthWollo               North Wollo (Amhara)
SouthWolo                South Wolo (Amhara)
NorthShewaAm             North Shewa (Amhara)
EastGojjam               East Gojjam (Amhara)
WestGojjam               West Gojjam (Amhara)
WagHimra                 Wag Himra (Amhara)
Awi                      Awi (Amhara)
Oromiya                  Oromiya (Amhara)
BahirDarLiyu             Bahir Dar Liyu (Amhara)
ArgobaSpecial            Argoba Special woreda (Amhara)
WestWellega              West Wellega (Oromia)
EastWellega              East Wellega (Oromia)
IluAbaBora               Ilu Aba Bora (Oromia)
Jimma                    Jimma (Oromia)
WestShewa                West Shewa (Oromia)
NorthShewaOr             North Shewa (Oromia)
EastShewa                East Shewa (Oromia)
Arsi                     Arsi (Oromia)
WestHararge              West Hararge (Oromia)
EastHararge              East Hararge (Oromia)
Bale                     Bale (Oromia)
Borena                   Borena (Oromia)
SouthwestShewa           South West Shewa (Oromia)
Guji                     Guji (Oromia)
AdamaSpecial             Adama Special Zone (Oromia)
JimmaSpecial             Jimma Special Town (Oromia)
WestArsi                 West Arsi (Oromia)
QelemeWellega            Qeleme Wellega (Oromia)
HoroGudruWellega         Horo Gudru Wellega (Oromia)
Shinile                  Shinile (Somali)
Jijiga                   Jijiga (Somali)
Degahabur                Degahabur (Somali)
Warder                   Warder (Somali)
Korahe                   Korahe (Somali)
Gode                     Gode (Somali)
Afder                    Afder (Somali)
Liben                    Liben (Somali)
Metekel                  Metekel (Benshangul)
Assosa                   Assosa (Benshangul)
Kamashi                  Kamashi (Benshangul)
PaweSpecial              Pawe Special (Benshangul)
MaokomoSpecial           Maokomo Special (Benshangul)
Gurage                   Gurage (Southern)
Hadiya                   Hadiya (Southern)
KembataTimbaro           Kembata Timbaro (Southern)
Sidama                   Sidama (Southern)
Gedeo                    Gedeo (Southern)
Wolayita                 Wolayita (Southern)
SouthOmo                 South Omo (Southern)
Sheka                    Sheka (Southern)
Kefa                     Kefa (Southern)
GamoGofa                 Gamo Gofa (Southern)
BenchMaji                Bench Maji (Southern)
Yem                      Yem (Southern)
AmaroSpecial             Amaro Special (Southern)
BurjiSpecial             Burji Special (Southern)
KonsoSpecial             Konso Special (Southern)
DerasheSpecial           Derashe Special Wereda (Southern)
Dawuro                   Dawuro (Southern)
Basketo                  Basketo (Southern)
Konta                    Konta (Southern)
Siliti                   Siliti (Southern)
Alaba                    Alaba (Southern)
AwassaTown               Awassa Town (Southern)
Agnuwak                  Agnuwak (Gambella)
Nuwer                    Nuwer (Gambella)
Mejenger                 Mejenger (Gambella)
EtangSpecial             Etang Special Wereda (Gambella)
Harari                   Harari (Harari)
AddisAkakiKaliti         Akaki Kaliti (AddisAbaba)
AddisNefasSilkLafto      Nefas Silk Lafto (AddisAbaba)
AddisKolfeKeraniyo       Kolfe Keraniyo (AddisAbaba)
AddisGulele              Gulele (AddisAbaba)
AddisLideta              Lideta (AddisAbaba)
AddisChirkos             Chirkos (AddisAbaba)
AddisArada               Arada (AddisAbaba)
AddisKetema              Addis Ketema (AddisAbaba)
AddisYeka                Yeka (AddisAbaba)
AddisBole                Bole (AddisAbaba)
DireDawa                 Dire Dawa (DireDawa)
/

NAddisZone(zone)
 /
NorthwestTigray          North Western Tigray (Tigray)
CentralTigray            Central Tigray (Tigray)
EastTigray               Eastern Tigray (Tigray)
SouthTigray              South Tigray (Tigray)
WestTigray               Western Tigray (Tigray)
MekeleSpecial            Mekele Especial Zone (Tigray)
Afar1                    Zone 1 (Afar)
Afar2                    Zone 2 (Afar)
Afar3                    Zone 3 (Afar)
Afar4                    Zone 4 (Afar)
Afar5                    Zone 5 (Afar)
NorthGondar              North Gondar (Amhara)
SouthGondar              South Gondar (Amhara)
NorthWollo               North Wollo (Amhara)
SouthWolo                South Wolo (Amhara)
NorthShewaAm             North Shewa (Amhara)
EastGojjam               East Gojjam (Amhara)
WestGojjam               West Gojjam (Amhara)
WagHimra                 Wag Himra (Amhara)
Awi                      Awi (Amhara)
Oromiya                  Oromiya (Amhara)
BahirDarLiyu             Bahir Dar Liyu (Amhara)
ArgobaSpecial            Argoba Special woreda (Amhara)
WestWellega              West Wellega (Oromia)
EastWellega              East Wellega (Oromia)
IluAbaBora               Ilu Aba Bora (Oromia)
Jimma                    Jimma (Oromia)
WestShewa                West Shewa (Oromia)
NorthShewaOr             North Shewa (Oromia)
EastShewa                East Shewa (Oromia)
Arsi                     Arsi (Oromia)
WestHararge              West Hararge (Oromia)
EastHararge              East Hararge (Oromia)
Bale                     Bale (Oromia)
Borena                   Borena (Oromia)
SouthwestShewa           South West Shewa (Oromia)
Guji                     Guji (Oromia)
AdamaSpecial             Adama Special Zone (Oromia)
JimmaSpecial             Jimma Special Town (Oromia)
WestArsi                 West Arsi (Oromia)
QelemeWellega            Qeleme Wellega (Oromia)
HoroGudruWellega         Horo Gudru Wellega (Oromia)
Shinile                  Shinile (Somali)
Jijiga                   Jijiga (Somali)
Degahabur                Degahabur (Somali)
Warder                   Warder (Somali)
Korahe                   Korahe (Somali)
Gode                     Gode (Somali)
Afder                    Afder (Somali)
Liben                    Liben (Somali)
Metekel                  Metekel (Benshangul)
Assosa                   Assosa (Benshangul)
Kamashi                  Kamashi (Benshangul)
PaweSpecial              Pawe Special (Benshangul)
MaokomoSpecial           Maokomo Special (Benshangul)
Gurage                   Gurage (Southern)
Hadiya                   Hadiya (Southern)
KembataTimbaro           Kembata Timbaro (Southern)
Sidama                   Sidama (Southern)
Gedeo                    Gedeo (Southern)
Wolayita                 Wolayita (Southern)
SouthOmo                 South Omo (Southern)
Sheka                    Sheka (Southern)
Kefa                     Kefa (Southern)
GamoGofa                 Gamo Gofa (Southern)
BenchMaji                Bench Maji (Southern)
Yem                      Yem (Southern)
AmaroSpecial             Amaro Special (Southern)
BurjiSpecial             Burji Special (Southern)
KonsoSpecial             Konso Special (Southern)
DerasheSpecial           Derashe Special Wereda (Southern)
Dawuro                   Dawuro (Southern)
Basketo                  Basketo (Southern)
Konta                    Konta (Southern)
Siliti                   Siliti (Southern)
Alaba                    Alaba (Southern)
AwassaTown               Awassa Town (Southern)
Agnuwak                  Agnuwak (Gambella)
Nuwer                    Nuwer (Gambella)
Mejenger                 Mejenger (Gambella)
EtangSpecial             Etang Special Wereda (Gambella)
Harari                   Harari (Harari)
*AddisAkakiKaliti         Akaki Kaliti (AddisAbaba)
*AddisNefasSilkLafto      Nefas Silk Lafto (AddisAbaba)
*AddisKolfeKeraniyo       Kolfe Keraniyo (AddisAbaba)
*AddisGulele              Gulele (AddisAbaba)
*AddisLideta              Lideta (AddisAbaba)
*AddisChirkos             Chirkos (AddisAbaba)
*AddisArada               Arada (AddisAbaba)
*AddisKetema              Addis Ketema (AddisAbaba)
*AddisYeka                Yeka (AddisAbaba)
*AddisBole                Bole (AddisAbaba)
DireDawa                 Dire Dawa (DireDawa)
/


URBRUR  Urban and rural /RUR, URB /

city(reg)
/AddisAbaba, DireDawa /

* ============= technology SETs =============   * JL: add "s_ip" to correspond to SWP
TYPE              Area yield and production type according to the use of inputs
/
none              Area where no inputs are used
sfip              Area where fertilizer improved seed irrigation  pesticide
seed              Area where improved seed
fert              Area where fertilizer
irri              Area where irrigation
pest              Area where persticide
s_f               Area where improved seed and fertilizer
s_i               Area where improved seed amd irrigation
s_p               Area where improved seed and pesticide
f_i               Area where fertilizer and irrigation
f_p               Area where fertilizer and pesticide
i_p               Area where irrigation and pesticide
s_fp              Area where improved seed fertilizer and pesticide
s_fi              Area where improved seed fertilizer and irrigation
f_ip              Area where fertilizer irrigation and pesticide
s_ip              Area where improved seed irrigation and pesticide
/

INPtype(type)     Area yield and production type according to the use of inputs except 'none'
/
sfip              Area where fertilizer improved seed irrigation pesticide
seed              Area where improved seed
fert              Area where fertilizer
irri              Area where irrigation
pest              Area where pesticide
s_f               Area where improved seed and fertilizer
s_i               Area where improved seed and irrigation
s_p               Area where improved seed and pesticide
f_i               Area where fertilizer and irrigation
f_p               Area where fertilizer and pesticide
i_p               Area where irrigation and pesticide
s_fp              Area where improved seed fertilizer and pesticide
s_fi              Area where improved seed fertilizer and irrigation
f_ip              Area where fertilizer irrigation and pesticide
s_ip              Area where improved seed irrigation and pesticide
/

Ftype(type)        use fertilizer
/
sfip               Area where fertilizer improved seed irrigation  pesticide
fert               Area where fertilizer
s_f                Area where improved seed and fertilizer
f_i                Area where fertilizer and irrigation
f_p                Area where fertilizer pesticide
s_fp               Area where improved seed fertilizer and pesticide
s_fi               Area where improved seed fertilizer and irrigation
f_ip               Area where fertilizer irrigation and pesticide
/

Wtype(type)        use irrigation
/
sfip               Area where fertilizer improved seed irrigation  pesticide
irri               Area where irrigation
s_i                Area where improved seed and irrigation
f_i                Area where fertilizer and irrigation
i_p                Area where irrigation and pesticide
s_fi               Area where improved seed fertilizer and irrigation
f_ip               Area where fertilizer irrigation and pesticide
s_ip               Area where improved seed irrigation and pesticide
/

NWtype(type)       Area yield and production type according to the use of inputs (no irrigation)
/
seed               Area where seed
fert               Area where fertilizer
pest               Area where pesticide
s_f                Area where improved seed and fertilizer
s_p                Area where improved seed and pesticide
f_p                Area where fertilizer and pesticide
s_fp               Area where improved seed fertilizer and pesticide
none               Area where none
/

Stype(type)        use improved seed
/
sfip               Area where improved seed fertilizer irrigation  pesticide
seed               Area where improved seed
s_f                Area where improved seed and fertilizer
s_i                Area where improved seed and irrigation
s_p                Area where improved seed and pesticide
s_fp               Area where improved seed fertilizer and pesticide
s_fi               Area where improved seed fertilizer and irrigation
s_ip              Area where improved seed irrigation and pesticide
/

Ptype(type)        use pesticide
/
sfip               Area where improved seed fertilizer irrigation  pesticide
pest               Area where pesticide
s_p                Area where improved seed and pesticide
f_p                Area where fertilizer and pesticide
i_p                Area where irrigation and pesticide
s_fp               Area where improved seed fertilizer and pesticide
f_ip               Area where fertilizer irrigation and pesticide
s_ip              Area where improved seed irrigation and pesticide   /


IrriDat
/SS_short,SS_med,SS_long,LMS long med short/

IrriDatSS(irridat)
/SS_short,SS_med,SS_long/

* ============= house-hold survey SETs =============
HHaggData /totexp,foodexp,totexp_pc,foodexp_pc,rurpop,urbpop,totpop,rurHH,urbHH,totHH,RurPopshare/

HHObs        Sample observation /1*1000/

Obsname /totexp,samplewt,hhsize/

HHS          Household income group /group1,group2,group3,group4,group5,group6,group7,group8,group9,group10/

popDendat /AREA_SQKM squared km,POPDENS/

totdat       Set created for bring data /TQS0,TQSgr,TQM0,TQF0,TQL0,TQO0,TAC0,TACgr,TYC0,TYCgr/

domainvar    variables in domain classification
/LGP_count,LGP_MIN,LGP_MAX,LGP_MEAN,LGP_MAJ for majority,LGP_MEDIAN,popwt_LGP,LGP_popwtMean crop population weighted mean
HIGHLND_COUNT,HIGH_LOW,MKT_COUNT,MKT_MIN,MKT_MAX,MKT_MEAN/
;

ALIAS (c,cp),(zone,zonep),(reg,regp),(cereal,cerealp),(cash,cashp),(hhs,hhsp),(smallcereal,smallcerealp),
(pulse,pulsep), (roots,rootsp), (oilseed,oilseedp),(allothfod,allothfodp),(lv,lvp),(nag,nagp),(ag,agp),(urbrur,urbrurp),
(HHobs,HHobsP),(type,typep),(ntradition,ntraditionp)
;

NTR_NAG(c)                        = YES;
NTR_NAG('nagntrade')              = NO;

CR(c)$(NOT NCR(c))                = YES;
NTC(c)$(NOT MC(c) and not EC(c))  = YES;

NAG(c)$(NOT AG(c))                = YES;

display NTC;

PARAMETERS
 PW0(c)              World price (dollars per metric ton)
 PWM0(c,s)             World cif price (dollars per metric ton)
 PWE0(c,s)             World fob price (dollars per metric ton)
 PP0(c,s)              Domestic producer price
 PC0(c,s)              Domestic consumer price
 PPZ0(reg,zone,c,s)    Domestic producer price by region
 PCZ0(reg,zone,c,s)    Domestic consumer price by region
 PCAVGR0(reg,c,s)      average domestic consumer price by region
 PPAVGR0(reg,c,s)      average domestic producer price by region
 PCAVG0(c,s)           average domestic consumer price at national level
 PPAVG0(c,s)           average domestic producer price at national level

 TQF0(c,s)              Food demand (thousand metric tons)
 TQL0(c,s)              Feed demand (thousand metric tons)
 TQO0(c,s)              Total other demand (thousand metric tons)
 TQD0(c,s)              Total demand (thousand metric tons)

 QFZ0(reg,zone,c,s)     regional food demand
 QLZ0(reg,zone,c,s)     regional feed demand
 QOZ0(reg,zone,c,s)     regional other demand
 QDZ0(reg,zone,c,s)     regional total demand

 QFZH0(reg,zone,urbrur,c,s)     regional food demand
 QFZHsh0(reg,zone,urbrur,c,s)   regional food demand share
 RurDemand(s,reg,zone,c)        rural demand data by zone
 UrbDemand(s,reg,zone,c)        urban demand data by zone
 RurDemandpc(reg,zone,c,s)      rural demand data by zone
 UrbDemandpc(reg,zone,c,s)      urban demand data by zone

 Rur2ndLowshare(s,reg,zone,c)
 Urb2ndLowshare(s,c)

 QLZshare0(reg,zone,c,s)           share of feed demand in total production
 QOZshare0(reg,zone,c,s)           share of other demand in total production

 QLZshare(reg,zone,c,s)            share of feed demand in total production
 QOZshare(reg,zone,c,s)            share of other demand in total production

 CONshare0(s,reg,zone,c)           share of food demand by zone  CON-consumption
 CONHshare0(reg,zone,urbrur,c,s)   share of food demand by zone

 TQFpc0(c,s)                       Food demand (kg per capita)
 TQLpc0(c,s)                       Feed demand (kg per capita)
 TQDpc0(c,s)                       Total demand (kg per capita)
 TQFHpc0(urbrur,c,s)               Food demand (kg per capita)
 QFZpc0(reg,zone,c,s)              regional food demand
 QFZHpc0(reg,zone,urbrur,c,s)      regional food demand by household group


 ACR0(reg,c,s)                     Area - for non-exported crop commodities (thousand hectares)
 YCR0(reg,c,s)                     Yield - for non-exported crop commodities (kg per thousand ha)

 ACZ0(reg,zone,c,s)                Area - for non-exported crop commodities (thousand hectares)
 YCZ0(reg,zone,c,s)                Yield - for non-exported crop commodities (kg per thousand ha)
 ACZirr0(s,reg,zone,c)             Irrigated Area - for non-exported crop commodities (thousand hectares)
 YCZirr0(reg,zone,c,s)             Yield - for non-exported crop commodities (kg per thousand ha)
 ACZirrSh0(reg,zone,c,s)           Share of Irrigated Area by crop and zone
 irrinACZ0(reg,zone,c,s)           Share of Irrigated Area in total area by crop and zone
 irrACZgr0(reg,zone,c,irriDat,s)   Share of Irrigated Area in total area by crop and zone
 irrACZgr(reg,zone,c,irriDat,s)    Share of Irrigated Area in total area by crop and zone

 TACZ0(reg,zone,s)                 Total area by zone
 TYCZ0(reg,zone,s)                 Average yield for total area by zone
 TACZirr0(reg,zone,s)              Irrigated Area - for non-exported crop commodities (thousand hectares)
 TACZirrSh0(reg,zone,s)            Share of Irrigated Area - for non-exported crop commodities (thousand hectares)
 irrinTACZ0(reg,zone,s)            Share of Irrigated Area - for non-exported crop commodities (thousand hectares)
 irrinTACZ20(c,s)                  Share of Irrigated Area - for non-exported crop commodities (thousand hectares)

 QSR0(reg,c,s)                     Total supply by region (thousand metric tons)
 QSZ0(reg,zone,c,s)                Total supply by zone (thousand metric tons)
 QSZ0_old(reg,zone,c,s)            Placeholder for QSZ0 once supply is shifted
 QSZirr0(reg,zone,c,s)             Total supply by zone (thousand metric tons) for irrigated condition
 QSZfert0(reg,zone,c,s)            Total supply by zone (thousand metric tons) for fertilizer condition
 QSZnfert0(reg,zone,c,s)           Total supply by zone (thousand metric tons) for non-fertilizer condition
 QSZseed0(reg,zone,c,s)            Total supply by zone (thousand metric tons) for improved seed condition
 QSZnseed0(reg,zone,c,s)           Total supply by zone (thousand metric tons) for non-improved seed condition

AAGG(s,reg,zone,c)    Area aggregated
ANON(s,reg,zone,c)    Area where no inputs are used
AALL(s,reg,zone,c)    Area where all inputs are used -fertilizer(F) improved seed(S) irrigation(W) pesticide(P)
AFSW(s,reg,zone,c)    Area where fertilizer improved seed irrigation are used
AFSP(s,reg,zone,c)    Area where fertilizer improved seed persticide are used
AFWP(s,reg,zone,c)    Area where fertilizer irrigation persticide are used
ASWP(s,reg,zone,c)    Area where improved seed irrigation persticide are used
AF_S(s,reg,zone,c)    Area where fertilizer improved seed are used
AF_W(s,reg,zone,c)    Area where fertilizer irrigation are used
AF_P(s,reg,zone,c)    Area where fertilizer persticide are used
AS_W(s,reg,zone,c)    Area where improved seed irrigation are used
AS_P(s,reg,zone,c)    Area where improved seed persticide are used
AP_W(s,reg,zone,c)    Area where irrigation persticide are used
A_F(s,reg,zone,c)     Area where fertilizer is used
A_S(s,reg,zone,c)     Area where improved seed is used
A_W(s,reg,zone,c)     Area where irrigation is used
A_P(s,reg,zone,c)     Area where persticide is used

PAGG(s,reg,zone,c)         Production aggregated
PNON(s,reg,zone,c)         Production where no inputs are used
PALL(s,reg,zone,c)
PFSW(s,reg,zone,c)
PFSP(s,reg,zone,c)
PFWP(s,reg,zone,c)
PSWP(s,reg,zone,c)
PF_S(s,reg,zone,c)
PF_W(s,reg,zone,c)
PF_P(s,reg,zone,c)
PS_W(s,reg,zone,c)
PS_P(s,reg,zone,c)
PP_W(s,reg,zone,c)
P_F(s,reg,zone,c)
P_S(s,reg,zone,c)
P_W(s,reg,zone,c)
P_P(s,reg,zone,c)

YNON(reg,zone,c,s)          Yield where no inputs are used
YALL(reg,zone,c,s)
YFSW(reg,zone,c,s)
YFSP(reg,zone,c,s)
YFWP(reg,zone,c,s)
YSWP(s,reg,zone,c)
YF_S(reg,zone,c,s)
YF_W(reg,zone,c,s)
YF_P(reg,zone,c,s)
YS_W(reg,zone,c,s)
YS_P(reg,zone,c,s)
YP_W(reg,zone,c,s)
Y_F(reg,zone,c,s)
Y_S(reg,zone,c,s)
Y_W(reg,zone,c,s)
Y_P(reg,zone,c,s)

 ACZ_inputsh0(reg,zone,c,type,s)   share of Area with each input use only
 ACZ_input0(reg,zone,c,type,s)     Area with any of input use
 QSZ_inputsh0(reg,zone,c,type,s)   share of Supply with each input use only
 QSZ_input0(reg,zone,c,type,s)     Supply with any of input use
 QSZ_input0_old(reg,zone,c,type,s)   Placeholder for QSZ_input0 once supply is shifted
 PAGG_old(s,reg,zone,c)    Placeholder for PAGG once supply is shifted
 YCZ_input0(reg,zone,c,type,s)     Yield with any input use
* 'R' stands for 'regional' , 'T' stands for 'total'
 RACZ_input0(reg,c,type,s)         Area with any of input use
 TACZ_input0(c,type,s)             Area with any of input use
 RQSZ_input0(reg,c,type,s)         Supply with any of input use
 TQSZ_input0(c,type,s)             Supply with any of input use
 RQSZ_input0_old(reg,c,type,s)     Placeholder for RQSZ_input0 once supply is shifted
 TQSZ_input0_old(c,type,s)         Placeholder for TQSZ_input0 once supply is shifted
 RYCZ_input0(reg,c,type,s)         Yield with any of input use
 TYCZ_input0(c,type,s)             Yield with any of input use

 RACZ_inputsh0(reg,c,type,s)       share of Area with any of input use
 TACZ_inputsh0(c,type,s)           share of Area with any of input use
 RQSZ_inputsh0(reg,c,type,s)       share of Supply with any of input use
 TQSZ_inputsh0(c,type,s)           share of Supply with any of input use

 ACZ_inputTypesh0(reg,zone,c,type,s)       share of Area with each input use only
 ACZ_inputType0(reg,zone,c,type,s)         Area with each input use only
 QSZ_inputTypesh0(reg,zone,c,type,s)       share of Supply with each input use only
 QSZ_inputType0(reg,zone,c,type,s)         Supply with each input use only
 QSZ_inputType0_old(reg,zone,c,type,s)     Placeholder for QSZ_inputType0 once supply is shifted
 YCZ_inputType0(reg,zone,c,type,s)         Yield with each input use only

 RACZ_inputType0(reg,c,type,s)             Area with any of input use
 TACZ_inputType0(c,type,s)                 Area with any of input use
 RQSZ_inputType0(reg,c,type,s)             Supply with any of input use
 TQSZ_inputType0(c,type,s)                 Supply with any of input use
 RQSZ_inputType0_old(reg,c,type,s)         Placeholder for RQSZ_inputType0 once supply is shifted
 TQSZ_inputType0_old(c,type,s)             Placeholder for TQSZ_inputType0 once supply is shifted
 RYCZ_inputType0(reg,c,type,s)             Yield with any of input use
 TYCZ_inputType0(c,type,s)                 Yield with any of input use

 RACZ_inputTypesh0(reg,c,type,s)           Area with any of input use
 TACZ_inputTypesh0(c,type,s)               Area with any of input use
 RQSZ_inputTypesh0(reg,c,type,s)           Supply with any of input use
 TQSZ_inputTypesh0(c,type,s)               Supply with any of input use

 zoneareashare(s,reg,zone,c)       share of total area by zone
 zoneoutputshare(s,reg,zone,c)     share of total output by zone

 ownareashare(reg,zone,c,s)        share of zonal total area
 ownoutputshare(reg,zone,c,s)      share of zonal total output

 TQS0(c,s)                 Total supply
 TQS0_old(c,s)             Placeholder for TQS0 once supply is shifted
 TAC0(c,s)                 Total area
 TYC0(c,s)                 yield at national level
 TQSpc0(c,s)               Total supply per capita (kg per capita)

 QT0(c,s)                  Trade volume (thousand metric tons positive is imports)
 QM0(c,s)                  imports
 QE0(c,s)                  exports
 AID0(c,s)                 aid shipment

* 'D' stands for deficit, 'T' total, 'M' import, E 'export'
 DQTZ0(reg,zone,c,s)       Net balance volume by zone (thousand metric tons)
 DQMZ0(reg,zone,c,s)       deficit by zone  (domestic import from central market to zone)
 DQEZ0(reg,zone,c,s)       surplus by zone  (domestic export from zone to central market)

 QSZpc0(reg,zone,c,s)      Total supply per capita by zone (thousand metric tons)
 TQSpc0(c,s)               Total supply per capita
 QTpc0(c,s)                Trade volume per capita (thousand metric tons)
 QTRpc0(c,s)               Net balance volume per capita (thousand metric tons)

 EXR0                    exchange rate

 income0(s)                                 total income (million dollars)
 incomeR0(reg,s)                           regional income
 incomeZ0(reg,zone,s)                      zonal income
 incomeH0(reg,zone,urbrur,s)               zonal income by urban and rural
 incomeAgH0(reg,zone,urbrur,s)             zonal income by urban and rural
 incomeHpc0(reg,zone,urbrur,s)             zonal income by urban and rural
 incomeHsh0(reg,zone,urbrur,s)             share of zonal income by urban and rural
 Texpend0(s)                                total  expenditure
 expendR0(reg,s)                           regional  expenditure
 ExpendZ0(reg,zone,s)                      zonal  expenditure
 expendZH0(reg,zone,urbrur,s)              zonal  expenditure
 expendZHsh0(reg,zone,urbrur,s)            share of zonal expenditure
 Texpendpc0(s)                              per capita expenditure
 Agexpendpc0(s)                             per capita expenditure
 expendRpc0(reg,s)                         regional  expenditure
 AgexpendRpc0(reg,s)                       regional  expenditure
 expendZpc0(reg,zone,s)                    zonal expenditure
 expendZHpc0(reg,zone,urbrur,s)            zonal expenditure
 AgexpendZpc0(reg,zone,s)                  zonal expenditure
 expendZshare0(reg,zone,c,s)               share of zonal expenditure
 expendZHshare0(reg,zone,urbrur,c,s)       share of zonal expenditure
 expendRshare0(reg,c,s)                    share of zonal expenditure

 GDP0(S)                    total GDP (WDI million US$ 14_17 avg)
 AgrGDP0(S)                 agriculture GDP (WDI million US$ 14_17 avg)
 IndGDP0(S)                 industry GDP (WDI million US$ 14_17 avg)
 SerGDP0(S)                 service GDP (WDI million US$ 14_17 avg)

 AgGDP0(S)                  agr GDP (WDI million US$ 98_01 avg)
 NAgGDP0(S)                 non-agr GDP (WDI million US$ 98_01 avg)    -ying

 GDPR0(reg,s)                      regional GDP
 GDPZ0(reg,zone,s)                 zonal GDP
 AgGDPZ0(reg,zone,s)               zonal Ag GDP

 NAgGDPZ0(reg,zone,s)              zonal Non-Ag GDP
 GDPZH0(reg,zone,urbrur,s)         zonal GDP by urban and rural
 GDPZHsh0(reg,zone,urbrur,s)       share of zonal GDP by urban and rural
 GDPpc0(s)                          value of per capita GDP for all output at PC price
 GDPRpc0(reg,s)                    regional per capita GDP
 GDPZpc0(reg,zone,s)               zonal per capita GDP
 AgGDPZpc0(reg,zone,s)             zonal per capita Ag GDP
 NAgGDPZpc0(reg,zone,s)            zonal per capita Non-Ag GDP
 GDPZHpc0(reg,zone,urbrur,s)       zonal per capita GDP by urban and rural
 AgGDPpc0(s)                        value of per capita Ag GDP for all output at PC price
 AgGDPRpc0(reg,s)                  regional per capita Ag GDP
 AgGDPZpc0(reg,zone,s)             zonal per capita Ag GDP
 NAgGDPpc0(s)                       value of per capita Non-Ag GDP for all output at PC price
 NAgGDPRpc0(reg,s)                 regional per capita Non-Ag GDP
 NAgGDPZpc0(reg,zone,s)            zonal per capita Non-Ag GDP

 INCOMEag0(reg,zone,urbrur,s)      total ag income
 INCOMEnag0(reg,zone,urbrur,s)     total non-ag income
 INCOMEagPC0(reg,zone,urbrur,s)    per capita ag income
 INCOMEnagPC0(reg,zone,urbrur,s)   per capita non-ag income

 Tpop0                           Population (million)
 popUrb0                         Urban population (million)
 popRur0                         Rural population (million)
 popR0(reg)                      regional Population (million)
 popRH0(reg,urbrur)              regional urban and rural Population (million)
 popZ0(reg,zone)                 zonal Population (million)
 popH0(reg,zone,urbrur)          zonal Population by urban and rural (million)
 PopRurShare(reg)                Rural population share in total regional pop
 PopZShare(reg,zone)             zonal population share
 PopHShare0(reg,zone,urbrur)     zonal urban and rural population share
 PopHShare(reg,zone,urbrur)      zonal urban and rural population share
 PopRHShare(reg,urbrur)          regional urban and rural population share
 popH(reg,zone,urbrur)           zonal population by urban and rural (million)

 GDP_USD0(S)                value of all output at PC price in US Dollar
 GDPpc_USD0(s)              value of per capita all output at PC price in US Dollar

 edfiL(t,c)                      Income ealsticity of food demand low income
 edfiH(t,c)                      Income ealsticity of food demand high income
 edfiHH(urbrur,c,s)                Income ealsticity of food demand rural and urban
 edfi0(t,reg,zone,c,s)             Income elasticity of food demand
 edfiZH0(reg,zone,urbrur,c,s)      Income elasticity of food demand
 edfp0(t,reg,zone,c,cp,s)          Price elasticity of food demand
 edfpH0(reg,zone,urbrur,c,cp,s)    Price elasticity of food demand
 edfi(reg,zone,c,s)                Income elasticity of food demand
 edfp(reg,zone,c,cp,s)             Price elasticity of food demand
 edfiZH(reg,zone,urbrur,c,s)       Income elasticity of food demand
 edfpH(reg,zone,urbrur,c,cp,s)     Price elasticity of food demand

 eap0(reg,zone,c,cp,s)             Area own- and cross- price elasticities
 eyp0(s,reg,zone,c)                Yield own-price elasticity
 esp0(reg,zone,c,cp,s)             Output own- and cross- price elasticities - ()
*()-for production function with no yield-area distinction (livestock)
 eap(reg,zone,c,cp,s)              Area own- and cross- price elasticities
 eyp(reg,zone,c,s)                 Yield own-price elasticity
 esp(reg,zone,c,cp,s)              Output own- and cross- price elasticities - ()

*esp2 w and w/o '0'
 esp20(reg,zone,c,cp,s)            Output own- and cross- price elasticities - ()
 esp2(reg,zone,c,cp,s)             Output own- and cross- price elasticities - ()
 esl(c,cp,reg,zone,s)              Feed price elasticity of livestock demand

* ying2 - ay over years 1983-2011?
 af0(t,reg,zone,c,s)               food demand intercept for zone
 afH0(reg,zone,urbrur,c,s)         food demand intercept for zone
 aa0(reg,zone,c,s)                 Area intercept
 ay0(reg,zone,c,s)                 Yield intercept
 aaIrr0(reg,zone,c,s)              Area intercept
 ayIrr0(reg,zone,c,s)              Yield intercept

 eapInput0(reg,zone,c,cp,type,s)   Area own- and cross- price elasticities
 eypInput0(reg,zone,c,type,s)      Yield own-price elasticity
 espInput0(reg,zone,c,cp,type,s)   Output own- and cross- price elasticities - ()

 eapInput(reg,zone,c,cp,type,s)    Area own- and cross- price elasticities
 eypInput(reg,zone,c,type,s)       Yield own-price elasticity
 espInput(reg,zone,c,cp,type,s)    Output own- and cross- price elasticities - ()

 aaInput0(reg,zone,c,type,s)       Area intercept
 ayInput0(reg,zone,c,type,s)       Yield intercept
 aaInput(reg,zone,c,type,s)        Area intercept
 ayInput(reg,zone,c,type,s)        Yield intercept

 as0(reg,zone,c,s)                 Supply intercept - ()
 al0(reg,zone,c,s)                 feed demand intercept for zone ('l' for livestock)
 af(reg,zone,c,s)                  food demand intercept for zone
 afH(reg,zone,urbrur,c,s)          food demand intercept for zone
 aa(reg,zone,c,s)                  Area intercept
 aaIrr(reg,zone,c,s)               Area intercept
 ay(reg,zone,c,s)                  Yield intercept
 ayIrr(reg,zone,c,s)               Yield intercept
 as(reg,zone,c,s)                  Supply intercept - ()
 al(reg,zone,c,s)                  feed demand intercept for zone ('l' for livestock)

 margZ0(reg,zone,c,s)              Margin on domestic prices sold in domestic market (between PC and PP)
 margZ(reg,zone,c,s)               Margin on domestic prices sold in domestic market (between PC and PP)
 gapZ0(reg,zone,c,s)               Gap between consumer price at zonal level to overall consumer price PC(c s)
 gapZ(reg,zone,c,s)                Gap between consumer price at zonal level to overall consumer price PC(c s)
 gapZ2(reg,zone,c,s)               Gap between consumer price at zonal level to overall consumer price PC(c s)
 margW0(c,s)                       Margin on domestic prices from or to ROW (rest of world)
 margW(c,s)                        Margin on domestic prices from or to ROW
 margD0(c,s)                       Margin on domestic prices
 margD(c,s)                        Margin on domestic prices
 totmargZ0(reg,zone,s)             Margin on domestic prices sold in domestic market


domain_var0(s,reg,zone,domainvar)                  domain information

*=== Rainfall information  *JL: seasons added (Belg: m=2 for all)
*Kc is climate yield reduction factor
*Kc=1 means there is no rainfall constraint to yield
Kc_Mean(s,reg,zone,c)      40 years of mean value of Kc
KcMean0(reg,zone,c,s)      40 years of mean value of Kc
KcMean(reg,zone,c,s)       40 years of mean value of Kc

*==== HH survey data
HH                                       household
HHaggDat(s,reg,zone,HHaggData)             household aggregated data
HHaggDatUS(reg,zone,HHaggData,s)           household aggregated data
HHtotexpshare0(reg,zone,s)                 share of household total expenditure
HHfodexpshare0(reg,zone,s)                 share of household food expenditure
HHnfodexpshare0(reg,zone,s)                share of household non-food expenditure
HHnfoodexp0(reg,zone,s)                    share of household food expenditure
HHnfodexpshareH0(reg,zone,urbrur,s)        share of household non-food expenditure
HHnfoodexpH0(reg,zone,urbrur,s)            household non-food expenditure
HHnfoodexpHpc0(reg,zone,urbrur,s)          household non-food expenditure

Rurobs(reg,zone,HHObs,Obsname)           rural obs
Urbobs(reg,zone,HHObs,Obsname)           urban obs
HHobsDat(reg,zone,HHObs,urbrur,Obsname)  household obs
HHobsPop0(reg,zone,HHObs,urbrur)         population
HHobsPopsh0(reg,zone,HHObs,urbrur)       share of population
HHobsIncPC00(reg,zone,HHobs,urbrur)      income per capita 00 for adjusted value based on sample size
HHobsIncPC0(reg,zone,HHobs,urbrur)       income per capita
HHobsInc0(reg,zone,HHobs,urbrur)         income
HHobsIncsh0(reg,zone,HHobs,urbrur)       share of income
HHobsPCsh0(reg,zone,HHobs,urbrur)        share of income per capita

*===Irrigation investment data
IrriNew(reg,irriDat,s)                     regional irr
IrriZNew(reg,zone,irriDat,s)               zonal irr
IrriACZNew(reg,zone,c,irriDat,s)           zonal irr area
IrriACZNewSh(reg,zone,c,irriDat,s)         share of zonal irr area

 popHH0(urbrur,HHS)                      Population by hh group (million)
 popRHH0(reg,urbrur,HHS)                 regional Population by hh group (million)
 popZHH0(reg,zone,urbrur,HHS)            zonal Population by hh group (million)
 HHIshare(HHS)                           HH income group share in total
 HHI0(urbrur,HHS,s)                        HH income by group
 HHI00(urbrur,HHS,s)                       HH income by group
 HHIpc0(urbrur,HHS,s)                      per capita HH income by group
 HHIpc00(urbrur,HHS,s)                     per capita HH income by group
 HHIR0(reg,urbrur,HHS,s)                   HH income by group
 HHIR00(reg,urbrur,HHS,s)                  HH income by group
 HHIRpc0(reg,urbrur,HHS,s)                 per capita HH income by group
 HHIRpc00(reg,urbrur,HHS,s)                per capita HH income by group
 HHIRshare(reg,urbrur,HHS,s)               HH income group share in total
 HHIZ0(reg,zone,urbrur,HHS,s)              HH income by group
 HHIZ00(reg,zone,urbrur,HHS,s)             HH income by group
 HHIZpc0(reg,zone,urbrur,HHS,s)            per capita HH income by group
 HHIZpc00(reg,zone,urbrur,HHS,s)           per capita HH income by group
 HHIZpc00(reg,zone,urbrur,HHS,s)           per capita HH income by group
 HHIZshare0(reg,zone,urbrur,HHS,s)         HH income group share in total
 HHIshareZ0(reg,zone,urbrur,HHS,s)         HH income group share in zone total

 HHgroupRur0(s,reg,zone,HHS)               zonal household group in rural area
 HHgroupUrb0(s,reg,zone,HHS)               zonal household group in urban area
 HHgroupNation0(s,HHS,urbrur)              all household group in rural and urban area


 HHI(urbrur,HHS,s)                         HH income by group
 HHIpc(urbrur,HHS,s)                       per capita HH income by group
 HHIZshare(reg,zone,urbrur,HHS,s)          HH income group share in total by zone and urban rural
 HHIshareZ(reg,zone,urbrur,HHS,s)          HH income group share in total by zone and urban rural


*=== population desensity
PopDen0(reg,zone,PopDenDat)              zonal population density data
PopDenZ0(reg,zone)                       zonal population density

*==== import and export
* ying-CIF:Cost Insurance and Freight; FOB-Free On Board
 PW(c,s)                   World price (dollars per metric ton)
 PWM(c,s)                  World cif price (dollars per metric ton)
 PWE(c,s)                  World fob price (dollars per metric ton)
 margW(c,s)                Margin on domestic prices

*=== others
 tpop                    Population - updated yearly in loop according to gp
 popHH(urbrur,HHS)       Population by hh group (million)

 popr(reg,zone)          Population - updated yearly in loop according to gp

 KcalRatio               Calories per 0.1 kilogram
 intermal(s)                intercept in malnutriion equation
 ninfant0                number of childran 0_5
 ninfant                 number of childran 0_5
 pmaln0                  percent of malnourished child
 nmaln0         number of malnourished child
 melas                   elasticity in percent of malnourished child equation
 TCALPC0(s)        Calories consumed per capita per day
 CALPC0(c,s)      Calories consumed by commodity per capita per day
;
* undefined
$onundf
Parameter
 TOTDATA(s,totdat,c)         total data
;

* ================================== import data =====================================
* use 100-yr avg kcmean
*$CALL 'GDXXRW Input/inputdatafile.xls se=0 index=Index!A1'
* use kcmean for 2003
*$CALL 'GDXXRW Input/inputdatafile2.xls se=0 index=Index!A1'
* use 2015 data
$CALL 'GDXXRW Input/inputdatafile_updated2020.xls se=0 index=INDEX!A1'

*$gdxin inputdatafile.gdx
$gdxin inputdatafile_updated2020.gdx
$LOAD   TOTDATA
$LOAD   Tpop0 PopUrb0
$LOAD   GDP0 AgrGDP0 IndGDP0 SerGDP0
$LOAD   zoneareashare zoneoutputshare
$LOAD   PopZ0
$LOAD   PopRurshare  HHIshare
$LOAD   PW0
$LOAD   edfiL edfiH
$LOAD   eyp0
$LOAD   domain_var0
$LOAD   Kc_Mean
$LOAD   HHaggDat
$LOAD   PopDen0
$LOAD   HHgroupRur0
$LOAD   HHgroupUrb0
$LOAD   HHgroupNation0
$LOAD   margW0
$LOAD   CONshare0
$LOAD   ACZirr0
$LOAD   RurObs
$LOAD   UrbObs
$LOAD   RurDemand
$LOAD   UrbDemand
$LOAD   Rur2ndLowshare
$LOAD   Urb2ndLowshare
$LOAD   KcalRatio ninfant0

$gdxin

* inputfile showing area, production, yield in response to technology input
$CALL 'GDXXRW Input/inputusefile_updated2020.xls se=0 index=Index!A1'
* JL: SWP added (not present in original model or data)
$gdxin inputusefile_updated2020.gdx
$LOAD   ANON
$LOAD   PNON
$LOAD   AALL
$LOAD   PALL
$LOAD   AFSW
$LOAD   PFSW
$LOAD   AFSP
$LOAD   PFSP
$LOAD   AFWP
$LOAD   PFWP
$LOAD   ASWP
$LOAD   PSWP
$LOAD   AF_S
$LOAD   PF_S
$LOAD   AF_W
$LOAD   PF_W
$LOAD   AF_P
$LOAD   PF_P
$LOAD   AS_W
$LOAD   PS_W
$LOAD   AS_P
$LOAD   PS_P
$LOAD   AP_W
$LOAD   PP_W
$LOAD   A_F
$LOAD   P_F
$LOAD   A_S
$LOAD   P_S
$LOAD   A_W
$LOAD   P_W
$LOAD   A_P
$LOAD   P_P

$gdxin

* =========================================== Calibration =========================================
*==== Input: Population
parameter
chkurbshare              check urban population share
;
chkurbshare = 100*Popurb0/Tpop0  ;
display chkurbshare, Popurb0;

parameter
nonrurpop(reg,zone)      zone with no rural population but only urban pop
nonpopH(reg,zone)        zone with no population agg from urbrur but show up in popZ (which should not happen)
chkTpop                  check total populatin
chkpopH(urbrur)          check urban and rural population
;

PopZShare(reg,zone)$sum((regp,zonep),PopZ0(regp,zonep))  = PopZ0(reg,zone)/sum((regp,zonep),PopZ0(regp,zonep)) ;
PopHShare(reg,zone,'rur')                                = HHaggDat('annual',reg,zone,'RurPopshare');
*PopHShare('AddisAbaba',zone,'rur')                      = 0.0 ;
PopHShare(reg,zone,'urb')$HHaggDat('annual',reg,zone,'totexp')    = 1 - PopHShare(reg,zone,'rur') ;

PopZ0(reg,zone)          = PopZShare(reg,zone)*Tpop0;
PopR0(reg)               = sum(zone,PopZ0(reg,zone)) ;
popH0(reg,zone,urbrur)   = PopHShare(reg,zone,urbrur)*PopZ0(reg,zone)  ;
popRH0(reg,urbrur)       = sum(zone,popH0(reg,zone,urbrur)) ;

popRHshare(reg,urbrur)$sum(urbrurp,popRH0(reg,urbrurp) ) = popRH0(reg,urbrur)/sum(urbrurp,popRH0(reg,urbrurp) ) ;

nonrurpop(reg,zone)$(PopZ0(reg,zone) and PopHShare(reg,zone,'rur') eq 0)         = yes;
nonpopH(reg,zone)$(PopZ0(reg,zone) and sum(urbrur,popH0(reg,zone,urbrur)) eq 0)  = yes;
display nonpopH, nonrurpop, popHshare;

chkTpop          = sum((reg,zone,urbrur),popH0(reg,zone,urbrur)) - Tpop0 ;
chkPopH('urb')   = sum((reg,zone),popH0(reg,zone,'urb')) - PopUrb0 ;
chkPopH('rur')   = sum((reg,zone),popH0(reg,zone,'rur')) - (Tpop0 - Popurb0) ;

display chkTpop, chkPopH ;

PopZShare(reg,zone)$sum((regp,zonep,urbrur),popH0(regp,zonep,urbrur))
                  = sum(urbrur,popH0(reg,zone,urbrur))/sum((regp,zonep,urbrur),popH0(regp,zonep,urbrur));

PopRur0           = sum((reg,zone),popH0(reg,zone,'rur'));
Tpop0             = sum((reg,zone,urbrur),popH0(reg,zone,urbrur));
PopUrb0           = Tpop0 - PopRur0 ;

PopRurShare(reg)  = sum(zone,popH0(reg,zone,'rur'))/sum((zone,urbrur),popH0(reg,zone,urbrur));
chkurbshare       = 100*Popurb0/Tpop0 ;

display chkurbshare;

chkTpop          = sum((reg,zone,urbrur),popH0(reg,zone,urbrur)) - Tpop0 ;
chkPopH('urb')   = sum((reg,zone),popH0(reg,zone,'urb')) - PopUrb0 ;
chkPopH('rur')   = sum((reg,zone),popH0(reg,zone,'rur')) - (Tpop0 - Popurb0) ;

display chkTpop, chkPopH ;

PopDenZ0(reg,zone)$PopZ0(reg,zone)       = PopZ0(reg,zone)/popDen0(reg,zone,'AREA_SQKM') ;
display PopDenZ0;

* ==== Input: totexp, foodexp, zonal Population
*ying-8.746 - currency exchange rate at that time (2003)
*JL: exchange rate is 20.67 in 2015
HHaggDatUS(reg,zone,HHaggData,s)     = HHaggDat(s,reg,zone,HHaggData)/20.67 ;
HHaggdatUS(reg,zone,'rurpop',s)      = HHaggdat(s,reg,zone,'rurpop') ;
HHaggdatUS(reg,zone,'urbpop',s)      = HHaggdat(s,reg,zone,'urbpop') ;
HHaggdatUS(reg,zone,'totpop',s)      = HHaggdat(s,reg,zone,'totpop') ;
HHaggdatUS(reg,zone,'rurpopshare',s) = HHaggdat(s,reg,zone,'rurpopshare') ;
display HHaggdatUS;

* ==== Input: zonal Income  HHS:group 1-10
HHIZpc00(reg,zone,'rur',HHS,s) = HHgroupRur0(s,reg,zone,HHS)/20.67 ;
HHIZpc00(reg,zone,'urb',HHS,s) = HHgroupUrb0(s,reg,zone,HHS)/20.67 ;

incomeH0(reg,zone,'rur',s)          = sum(HHS,HHIZpc00(reg,zone,'rur',HHS,s))*0.1*HHaggDatUS(reg,zone,'rurpop',s) ;
incomeH0(reg,zone,'urb',s)$HHaggDatUS(reg,zone,'urbpop',s)
                                  = sum(HHS,HHIZpc00(reg,zone,'urb',HHS,s))*0.1*HHaggDatUS(reg,zone,'urbpop',s) ;
* addis ababa has two zones (addis1 and addis2), same income, use the average of two
* JL: change from 0.5 to 0.1  HERE AND BELOW
* JL: income is reported for individual Addis zones in new data, however we keep Addis homogeneous ...
* ... since it's the import/export center for the whole country
incomeH0('AddisAbaba',zone,'urb',s) = 0.1*sum((zonep,HHS),HHIZpc00('AddisAbaba',zonep,'urb',HHS,s)*0.1*HHaggDatUS('AddisAbaba',zonep,'urbpop',s)) ;

incomeHpc0(reg,zone,'rur',s)$HHaggDatUS(reg,zone,'rurpop',s) = incomeH0(reg,zone,'rur',s)/HHaggDatUS(reg,zone,'rurpop',s) ;
incomeHpc0(reg,zone,'urb',s)$HHaggDatUS(reg,zone,'urbpop',s) = incomeH0(reg,zone,'urb',s)/HHaggDatUS(reg,zone,'urbpop',s) ;
incomeHpc0('AddisAbaba',zone,'urb',s)$incomeH0('AddisAbaba',zone,'urb',s)
                                                         = incomeH0('AddisAbaba',zone,'urb',s)/(0.1*sum(zonep,HHaggDatUS('AddisAbaba',zonep,'urbpop',s))) ;
incomeHsh0(reg,zone,urbrur,s)$incomeH0(reg,zone,urbrur,s)    = incomeH0(reg,zone,urbrur,s)/sum(urbrurp,incomeH0(reg,zone,urbrurp,s)) ;
display incomeHpc0, incomeHsh0;

* ==== Input: zonal Demand for food
RurDemandpc(reg,zone,c,s)$RurDemand(s,reg,zone,c) = RurDemand(s,reg,zone,c)/HHaggDatUS(reg,zone,'rurpop',s) ;
UrbDemandpc(reg,zone,c,s)$UrbDemand(s,reg,zone,c) = UrbDemand(s,reg,zone,c)/HHaggDatUS(reg,zone,'urbpop',s) ;
UrbDemandpc('AddisAbaba',zone,c,s)$UrbDemand(s,'AddisAbaba',zone,c)
                                              = UrbDemand(s,'AddisAbaba',zone,c)/(0.1*sum(zonep,HHaggDatUS('AddisAbaba',zonep,'urbpop',s))) ;

* non-foodexp using data sources with rural and urban separation, here income is from agg HH survey
* non-foodexp = income - food demand(unit of $), in this model income is from the supply/yield
HHnfoodexpH0(reg,zone,'rur',s) = incomeH0(reg,zone,'rur',s) - sum(c,RurDemand(s,reg,zone,c)) ;
HHnfoodexpH0(reg,zone,'urb',s) = incomeH0(reg,zone,'urb',s) - sum(c,UrbDemand(s,reg,zone,c)) ;

HHnfoodexpHpc0(reg,zone,'rur',s)$HHaggDatUS(reg,zone,'rurpop',s) = HHnfoodexpH0(reg,zone,'rur',s)/HHaggDatUS(reg,zone,'rurpop',s) ;
HHnfoodexpHpc0(reg,zone,'urb',s)$HHaggDatUS(reg,zone,'urbpop',s) = HHnfoodexpH0(reg,zone,'urb',s)/HHaggDatUS(reg,zone,'urbpop',s) ;

HHnfodexpshareH0(reg,zone,urbrur,s)$incomeH0(reg,zone,urbrur,s)  = HHnfoodexpH0(reg,zone,urbrur,s)/incomeH0(reg,zone,urbrur,s) ;
display HHnfodexpshareH0;

*Demand in $
RurDemand(s,reg,zone,c)$RurDemandpc(reg,zone,c,s) = RurDemandpc(reg,zone,c,s)*PopH0(reg,zone,'rur') ;
UrbDemand(s,reg,zone,c)$UrbDemandpc(reg,zone,c,s) = UrbDemandpc(reg,zone,c,s)*PopH0(reg,zone,'urb') ;

RurDemand(s,reg,zone,c)$(PopH0(reg,zone,'rur') eq 0) = 0;
UrbDemand(s,reg,zone,c)$(PopH0(reg,zone,'urb') eq 0) = 0;

RurDemandpc(reg,zone,c,s)$RurDemand(s,reg,zone,c) = RurDemand(s,reg,zone,c)/PopH0(reg,zone,'rur') ;
UrbDemandpc(reg,zone,c,s)$UrbDemand(s,reg,zone,c) = UrbDemand(s,reg,zone,c)/PopH0(reg,zone,'urb') ;


parameter
chknegnfood(reg,zone,urbrur,s)             negative non-food expenditure
chkzonenfood(reg,zone,urbrur,s)            has income but non-food exp is zero (spending all income for food) (showing 'yes' if so)
;

chknegnfood(reg,zone,urbrur,s)$(HHnfoodexpH0(reg,zone,urbrur,s) lt 0) = HHnfoodexpH0(reg,zone,urbrur,s);
chkzonenfood(reg,zone,urbrur,s)$(incomeH0(reg,zone,urbrur,s) and HHnfoodexpH0(reg,zone,urbrur,s) eq 0) = yes;

display chknegnfood, chkzonenfood;

* non-food exp using data sources without rural and urban separation
* non-foodexp = totexp - foodexp
HHnfoodexp0(reg,zone,s)            = HHaggDatUS(reg,zone,'totexp',s) - HHaggDatUS(reg,zone,'foodexp',s) ;
HHnfodexpshare0(reg,zone,s)        = HHnfoodexp0(reg,zone,s)/sum((regp,zonep),HHnfoodexp0(regp,zonep,s)) ;
incomeH0(reg,zone,urbrur,s)        = incomeHpc0(reg,zone,urbrur,s)*PoPH0(reg,zone,urbrur);

incomeH0(reg,zone,'rur',s)$(PopH0(reg,zone,'rur') eq 0) = 0 ;
incomeH0(reg,zone,'urb',s)$(PopH0(reg,zone,'urb') eq 0) = 0 ;

HHnfoodexpH0(reg,zone,urbrur,s)$HHnfoodexpHpc0(reg,zone,urbrur,s) = HHnfoodexpHpc0(reg,zone,urbrur,s)*PoPH0(reg,zone,urbrur);
incomeHsh0(reg,zone,urbrur,s)$incomeH0(reg,zone,urbrur,s)         = incomeH0(reg,zone,urbrur,s)/sum(urbrurp,incomeH0(reg,zone,urbrurp,s)) ;

Parameter
chkI0(urbrur,s)                        check income by urban and rural
chkIpc0(urbrur,s)                      check per capita income by urban and rural
;
HHIZ00(reg,zone,urbrur,HHS,s)$PoPH0(reg,zone,urbrur)        = 0.1*PoPH0(reg,zone,urbrur)*HHIZpc00(reg,zone,urbrur,HHS,s) ;
HHIR00(reg,urbrur,HHS,s)                                    = sum(zone,HHIZ00(reg,zone,urbrur,HHS,s)) ;
HHI00(urbrur,HHS,s)                                         = sum((reg,zone),HHIZ00(reg,zone,urbrur,HHS,s)) ;
HHIRpc00(reg,urbrur,HHS,s)$sum(zone,PoPH0(reg,zone,urbrur)) = sum(zone,HHIZ00(reg,zone,urbrur,HHS,s))/(0.1*sum(zone,PoPH0(reg,zone,urbrur))) ;
HHIpc00(urbrur,HHS,s)                                       = sum((reg,zone),HHIZ00(reg,zone,urbrur,HHS,s))/(0.1*sum((reg,zone),PoPH0(reg,zone,urbrur))) ;

display HHIpc00 ;

HHIpc00(urbrur,HHS,s)      = HHgroupNation0(s,HHS,urbrur)/20.67 ;
HHI00(urbrur,HHS,s)        = 0.1*HHIpc00(urbrur,HHS,s)*sum((reg,zone),PoPH0(reg,zone,urbrur) );

chkI0(urbrur,s)            = sum(HHS,HHI00(urbrur,HHS,s));
chkIpc0(urbrur,s)          = sum(HHS,HHI00(urbrur,HHS,s))/sum((reg,zone),PoPH0(reg,zone,urbrur) );

HHIZshare0(reg,zone,urbrur,HHS,s)                                          = HHIZ00(reg,zone,urbrur,HHS,s)/sum(HHSP,HHI00(urbrur,HHSP,s));
HHIshareZ0(reg,zone,urbrur,HHS,s)$sum(HHSP,HHIZ00(reg,zone,urbrur,HHSP,s))   = HHIZ00(reg,zone,urbrur,HHS,s)/sum(HHSP,HHIZ00(reg,zone,urbrur,HHSP,s));

display HHIpc00, HHI00, chkI0, chkIpc0 ;

*=== Input: HH data of totexp, hhsize, samplewt to calculate income and poverty
Parameter
HHobsPoPZ0(reg,zone,urbrur)               household obs pop
HHobsPoPZsh0(reg,zone,urbrur)             share of household obs pop
HHobsPoPZdif0(reg,zone,urbrur)            ratio of pop calc by HHobs divided by pop calc by Tpop (should be ~1)

chkobsIncsh(reg,zone,urbrur)
;

HHobsDat(reg,zone,HHObs,'rur','totexp')          = Rurobs(reg,zone,HHObs,'totexp')/20.67 ;
HHobsDat(reg,zone,HHObs,'urb','totexp')          = Urbobs(reg,zone,HHObs,'totexp')/20.67 ;

HHobsDat(reg,zone,HHObs,'rur','hhsize')          = Rurobs(reg,zone,HHObs,'hhsize') ;
HHobsDat(reg,zone,HHObs,'urb','hhsize')          = Urbobs(reg,zone,HHObs,'hhsize') ;

HHobsDat(reg,zone,HHObs,'rur','samplewt')        = Rurobs(reg,zone,HHObs,'samplewt') ;
HHobsDat(reg,zone,HHObs,'urb','samplewt')        = Urbobs(reg,zone,HHObs,'samplewt') ;

*set income equal to total expenditure (no savings)
HHobsInc0(reg,zone,HHobs,urbrur)$HHobsDat(reg,zone,HHObs,urbrur,'hhsize') = HHobsDat(reg,zone,HHObs,urbrur,'totexp') ;
HHobsIncsh0(reg,zone,HHobs,urbrur)$HHobsInc0(reg,zone,HHobs,urbrur)
                 = HHobsInc0(reg,zone,HHobs,urbrur)/sum(HHobsP,HHobsInc0(reg,zone,HHobsP,urbrur) );

HHobsIncPC00(reg,zone,HHobs,urbrur)$HHobsDat(reg,zone,HHObs,urbrur,'hhsize')
                 = HHobsDat(reg,zone,HHObs,urbrur,'totexp')/HHobsDat(reg,zone,HHObs,urbrur,'hhsize') ;

HHobsPCsh0(reg,zone,HHobs,urbrur)$HHobsIncPC00(reg,zone,HHobs,urbrur)
                 = 100*(HHobsDat(reg,zone,HHObs,urbrur,'totexp')*HHobsDat(reg,zone,HHObs,urbrur,'samplewt'))/
                   sum(HHobsP,HHobsDat(reg,zone,HHObsP,urbrur,'totexp')*HHobsDat(reg,zone,HHObsP,urbrur,'samplewt'));

HHobsPCsh0(reg,zone,HHobs,urbrur)$HHobsIncPC00(reg,zone,HHobs,urbrur)
                 = HHobsPCsh0(reg,zone,HHobs,urbrur)/(HHobsDat(reg,zone,HHObs,urbrur,'hhsize')*HHobsDat(reg,zone,HHObs,urbrur,'samplewt')) ;

chkobsIncsh(reg,zone,urbrur)     = sum(HHobs,HHobsDat(reg,zone,HHObs,urbrur,'hhsize')*
                 HHobsDat(reg,zone,HHObs,urbrur,'samplewt')*HHobsPCsh0(reg,zone,HHobs,urbrur));

HHobsPoPZ0(reg,zone,urbrur)      = sum(HHobs$HHobsDat(reg,zone,HHObs,urbrur,'samplewt'),
                 HHobsDat(reg,zone,HHObs,urbrur,'samplewt')*HHobsDat(reg,zone,HHObs,urbrur,'HHsize'));

parameter
chkobsPoPZ0(reg,zone)    zonal pop calc by HHobs data
chkobsPoP0(urbrur)       overall urban and rural pop calc by HHobs data
;

HHobsPoPZ0(reg,zone,urbrur)      = sum(HHobs$HHobsDat(reg,zone,HHObs,urbrur,'samplewt'),
                 HHobsDat(reg,zone,HHObs,urbrur,'samplewt')*HHobsDat(reg,zone,HHObs,urbrur,'HHsize'));

chkobsPoPZ0(reg,zone)            = sum(urbrur,HHobsPoPZ0(reg,zone,urbrur));
chkobsPoP0(urbrur)               = sum((reg,zone),HHobsPoPZ0(reg,zone,urbrur));
display chkobsPoPZ0, chkobsPoP0;

HHobsPoPZdif0(reg,zone,urbrur)$HHobsPoPZ0(reg,zone,urbrur) = HHobsPoPZ0(reg,zone,urbrur)/(1000000*PoPH0(reg,zone,urbrur));
display   HHobsPoPZdif0;
* use the pop calc by Tpop as the correct version for reference
HHobsDat(reg,zone,HHObs,urbrur,'samplewt')$HHobsPoPZdif0(reg,zone,urbrur)
                                 = HHobsDat(reg,zone,HHObs,urbrur,'samplewt')/HHobsPoPZdif0(reg,zone,urbrur) ;

HHobsPoPZ0(reg,zone,urbrur)      = sum(HHobs$HHobsDat(reg,zone,HHObs,urbrur,'samplewt'),
         HHobsDat(reg,zone,HHObs,urbrur,'samplewt')*HHobsDat(reg,zone,HHObs,urbrur,'HHsize'));
chkobsPoPZ0(reg,zone)            = sum(urbrur,HHobsPoPZ0(reg,zone,urbrur));
chkobsPoP0(urbrur)               = sum((reg,zone),HHobsPoPZ0(reg,zone,urbrur));
HHobsPoPZdif0(reg,zone,urbrur)$HHobsPoPZ0(reg,zone,urbrur) = HHobsPoPZ0(reg,zone,urbrur)/(1000000*PoPH0(reg,zone,urbrur));
display chkobsPoPZ0, chkobsPoP0, HHobsPoPZdif0;


parameter
AvgIncomePc(urbrur)        overall average income per capita in US Dollar
AvgIncomePc2(urbrur)       overall average income per capita in Ethiopian Birr
AvgIncomePcAll             overall average income per capita in US Dollar
AvgIncomePcAll2            overall average income per capita in Ethiopian Birr
;

AvgIncomePc(urbrur)  = sum((reg,zone,HHobs),HHobsDat(reg,zone,HHObs,urbrur,'totexp')*HHobsDat(reg,zone,HHObs,urbrur,'samplewt'))/
                       sum((reg,zone,HHobs),HHobsDat(reg,zone,HHObs,urbrur,'hhsize')*HHobsDat(reg,zone,HHObs,urbrur,'samplewt')) ;
AvgIncomePcAll       = sum((reg,zone,HHobs,urbrur),HHobsDat(reg,zone,HHObs,urbrur,'totexp')*HHobsDat(reg,zone,HHObs,urbrur,'samplewt'))/
                       sum((reg,zone,HHobs,urbrur),HHobsDat(reg,zone,HHObs,urbrur,'hhsize')*HHobsDat(reg,zone,HHObs,urbrur,'samplewt')) ;
AvgIncomePc2(urbrur) = 20.67*AvgIncomePc(urbrur) ;
AvgIncomePcAll2      = 20.67*AvgIncomePcAll ;



* ====

Parameter
chkHHIshareZ(reg,zone,urbrur,s)   should be 1 when add up share of urban and rural
THHIZshare(reg,zone,urbrur,s)     zonal share of urban or rural in overall urban or rural area
;

chkHHIshareZ(reg,zone,urbrur,s) = sum(HHS,HHIshareZ0(reg,zone,urbrur,HHS,s)) ;

display chkHHIshareZ, HHIshareZ0;

THHIZshare(reg,zone,urbrur,s) = sum(HHS,HHIZ00(reg,zone,urbrur,HHS,s))/sum((regp,zonep,HHS),HHIZ00(regp,zonep,urbrur,HHS,s));

display THHIZshare;


* ==== Input: TOTAL supply, area, yield, demand,traded volume
TQS0(c,s)          = TOTDATA(s,'TQS0',c) ;
TAC0(c,s)          = TOTDATA(s,'TAC0',c) ;
TYC0(c,s)          = TOTDATA(s,'TYC0',c) ;
QT0(c,s)           = TOTDATA(s,'TQM0',c) ;
TQF0(c,s)          = TOTDATA(s,'TQF0',c) ;
TQL0(c,s)          = TOTDATA(s,'TQL0',c) ;
TQO0(c,s)          = TOTDATA(s,'TQO0',c) ;

*==== Input: zonal ouput/area share, multiply total value to get zonal values
Parameter
chkzonearea(c,s)          check shared area adds up to 100%
chkzoneoutput(c,s)        check shared ouput adds up to 100%
;

zoneareashare(s,reg,zone,c)$(zoneoutputshare(s,reg,zone,c) eq 0)             = 0 ;
zoneareashare(s,reg,zone,c)$(zoneareashare(s,reg,zone,c) le 0.00001)         = 0 ;
zoneoutputshare(s,reg,zone,c)$(zoneoutputshare(s,reg,zone,c) le 0.00001)     = 0 ;

chkzonearea(c,s)   = sum((reg,zone), zoneareashare(s,reg,zone,c) ) ;
chkzoneoutput(c,s) = sum((reg,zone), zoneoutputshare(s,reg,zone,c) ) ;
display chkzonearea, chkzoneoutput;

zoneoutputshare(s,reg,zone,c)$chkzoneoutput(c,s)                     = zoneoutputshare(s,reg,zone,c)/chkzoneoutput(c,s)*100 ;
zoneareashare(s,reg,zone,c)$(zoneoutputshare(s,reg,zone,c) eq 0)     = 0 ;
zoneareashare(s,reg,zone,c)$chkzonearea(c,s)                         = zoneareashare(s,reg,zone,c)/chkzonearea(c,s)*100 ;

chkzonearea(c,s)   = sum((reg,zone), zoneareashare(s,reg,zone,c) ) ;
chkzoneoutput(c,s) = sum((reg,zone), zoneoutputshare(s,reg,zone,c) ) ;
display chkzonearea, chkzoneoutput;

* total supply of non-import nor export commodities = total food demand + total livestock demand + total other demand
TQS0(NTC,s)$(QT0(NTC,s) gt 0) = TQF0(NTC,s) + TQL0(NTC,s) + TQO0(NTC,s) ;

QSZ0(reg,zone,c,s)  = zoneoutputshare(s,reg,zone,c)*TQS0(c,s)/100;
ACZ0(reg,zone,c,s)  = zoneareashare(s,reg,zone,c)*TAC0(c,s)/100 ;

ACZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) eq 0)         = 0 ;
QSZ0(reg,zone,crop,s)$(ACZ0(reg,zone,crop,s) eq 0)   = 0 ;

* JL: fix data inconsistencies in certain zones
ACZ0('Oromia','SouthwestShewa','RootsOther','belg') = ACZ0('Oromia','SouthwestShewa','RootsOther','annual') - ACZ0('Oromia','SouthwestShewa','RootsOther','meher') ;
ACZ0('Oromia','Dawuro','RootsOther','belg') = ACZ0('Oromia','Dawuro','RootsOther','annual') - ACZ0('Oromia','Dawuro','RootsOther','meher') ;


************** JL: major change to model--seasonal shift of supply due to storage or continuous harvest **************
TQS0_old(c,s) = TQS0(c,s) ;
QSZ0_old(reg,zone,c,s) = QSZ0(reg,zone,c,s) ;
*TAC0_old(c,s) = TAC0(c,s) ;
*ACZ0_old(reg,zone,c,s) = ACZ0(reg,zone,c,s) ;


TQS0('Teff','Meher') = 0.77*TQS0('Teff','Meher') + (1-0.77)*TQS0('Teff','Belg') ;
TQS0('Barley','Meher') = 0.79*TQS0('Barley','Meher') + (1-0.79)*TQS0('Barley','Belg') ;
TQS0('Wheat','Meher') = 0.76*TQS0('Wheat','Meher') + (1-0.76)*TQS0('Wheat','Belg') ;
TQS0('Maize','Meher') = 0.68*TQS0('Maize','Meher') + (1-0.68)*TQS0('Maize','Belg') ;
TQS0('Sorghum','Meher') = 0.83*TQS0('Sorghum','Meher') + (1-0.83)*TQS0('Sorghum','Belg') ;
TQS0('Millet','Meher') = 0.75*TQS0('Millet','Meher') + (1-0.75)*TQS0('Millet','Belg') ;
TQS0('Oats','Meher') = 0.75*TQS0('Oats','Meher') + (1-0.75)*TQS0('Oats','Belg') ;
TQS0('Rice','Meher') = 0.75*TQS0('Rice','Meher') + (1-0.75)*TQS0('Rice','Belg') ;
TQS0(pulse,'Meher') = 0.69*TQS0(pulse,'Meher') + (1-0.69)*TQS0(pulse,'Belg') ;
TQS0(oilseed,'Meher') = 0.79*TQS0(oilseed,'Meher') + (1-0.79)*TQS0(oilseed,'Belg') ;
*TQS0('Rapeseed','Meher') = (0.55/0.79)*TQS0('Rapeseed','Meher') ;
TQS0(LV,'Meher') = 0.553*TQS0(LV,'Meher') + (1-0.553)*TQS0(LV,'Belg') ;
TQS0('Stimulants','Meher') = 0.572*TQS0('Stimulants','Meher') + (1-0.572)*TQS0('Stimulants','Belg') ;
TQS0('Coffee','Meher') = 0.572*TQS0('Coffee','Meher') + (1-0.572)*TQS0('Coffee','Belg') ;
TQS0('Enset','Meher') = 0.583*TQS0('Enset','Meher') + (1-0.583)*TQS0('Enset','Belg') ;
TQS0('SugarRawEquivalent','Meher') = 0.583*TQS0('SugarRawEquivalent','Meher') + (1-0.583)*TQS0('SugarRawEquivalent','Belg') ;
TQS0('Bananas','Meher') = 0.583*TQS0('Bananas','Meher') + (1-0.583)*TQS0('Bananas','Belg') ;

TQS0(c,'Belg') = TQS0(c,'Annual') - TQS0(c,'Meher') ;

TQS0(c,s)$(TQS0(c,s) lt 0) = 0 ;


QSZ0(reg,zone,'Teff','Meher') = 0.77*QSZ0(reg,zone,'Teff','Meher') + (1-0.77)*QSZ0(reg,zone,'Teff','Belg') ;
QSZ0(reg,zone,'Barley','Meher') = 0.79*QSZ0(reg,zone,'Barley','Meher') + (1-0.79)*QSZ0(reg,zone,'Barley','Belg') ;
QSZ0(reg,zone,'Wheat','Meher') = 0.76*QSZ0(reg,zone,'Wheat','Meher') + (1-0.76)*QSZ0(reg,zone,'Wheat','Belg') ;
QSZ0(reg,zone,'Maize','Meher') = 0.68*QSZ0(reg,zone,'Maize','Meher') + (1-0.68)*QSZ0(reg,zone,'Maize','Belg') ;
QSZ0(reg,zone,'Sorghum','Meher') = 0.83*QSZ0(reg,zone,'Sorghum','Meher') + (1-0.83)*QSZ0(reg,zone,'Sorghum','Belg') ;
QSZ0(reg,zone,'Millet','Meher') = 0.75*QSZ0(reg,zone,'Millet','Meher') + (1-0.75)*QSZ0(reg,zone,'Millet','Belg') ;
QSZ0(reg,zone,'Oats','Meher') = 0.75*QSZ0(reg,zone,'Oats','Meher') + (1-0.75)*QSZ0(reg,zone,'Oats','Belg') ;
QSZ0(reg,zone,'Rice','Meher') = 0.75*QSZ0(reg,zone,'Rice','Meher') + (1-0.75)*QSZ0(reg,zone,'Rice','Belg') ;
QSZ0(reg,zone,pulse,'Meher') = 0.69*QSZ0(reg,zone,pulse,'Meher') + (1-0.69)*QSZ0(reg,zone,pulse,'Belg') ;
QSZ0(reg,zone,oilseed,'Meher') = 0.79*QSZ0(reg,zone,oilseed,'Meher') + (1-0.79)*QSZ0(reg,zone,oilseed,'Belg') ;
QSZ0(reg,zone,'Rapeseed','Meher') = (0.55/0.79)*QSZ0(reg,zone,'Rapeseed','Meher') ;
QSZ0(reg,zone,LV,'Meher') = 0.553*QSZ0(reg,zone,LV,'Meher') + (1-0.553)*QSZ0(reg,zone,LV,'Belg') ;
QSZ0(reg,zone,'Stimulants','Meher') = 0.572*QSZ0(reg,zone,'Stimulants','Meher') + (1-0.572)*QSZ0(reg,zone,'Stimulants','Belg') ;
QSZ0(reg,zone,'Coffee','Meher') = 0.572*QSZ0(reg,zone,'Coffee','Meher') + (1-0.572)*QSZ0(reg,zone,'Coffee','Belg') ;
QSZ0(reg,zone,'Enset','Meher') = 0.583*QSZ0(reg,zone,'Enset','Meher') + (1-0.583)*QSZ0(reg,zone,'Enset','Belg') ;
*QSZ0(reg,zone,'SugarRawEquivalent','Meher') = 0.583*QSZ0(reg,zone,'SugarRawEquivalent','Meher') + (1-0.583)*QSZ0(reg,zone,'SugarRawEquivalent','Belg') ;
QSZ0(reg,zone,'Bananas','Meher') = 0.583*QSZ0(reg,zone,'Bananas','Meher') + (1-0.583)*QSZ0(reg,zone,'Bananas','Belg') ;

QSZ0(reg,zone,c,'Belg') = QSZ0(reg,zone,c,'Annual') - QSZ0(reg,zone,c,'Meher') ;

QSZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) lt 0) = 0 ;


TAC0('Teff','Meher') = 0.77*TAC0('Teff','Meher') + (1-0.77)*TAC0('Teff','Belg') ;
TAC0('Barley','Meher') = 0.79*TAC0('Barley','Meher') + (1-0.79)*TAC0('Barley','Belg') ;
TAC0('Wheat','Meher') = 0.76*TAC0('Wheat','Meher') + (1-0.76)*TAC0('Wheat','Belg') ;
TAC0('Maize','Meher') = 0.68*TAC0('Maize','Meher') + (1-0.68)*TAC0('Maize','Belg') ;
TAC0('Sorghum','Meher') = 0.83*TAC0('Sorghum','Meher') + (1-0.83)*TAC0('Sorghum','Belg') ;
TAC0('Millet','Meher') = 0.75*TAC0('Millet','Meher') + (1-0.75)*TAC0('Millet','Belg') ;
TAC0('Oats','Meher') = 0.75*TAC0('Oats','Meher') + (1-0.75)*TAC0('Oats','Belg') ;
TAC0('Rice','Meher') = 0.75*TAC0('Rice','Meher') + (1-0.75)*TAC0('Rice','Belg') ;
TAC0(pulse,'Meher') = 0.69*TAC0(pulse,'Meher') + (1-0.69)*TAC0(pulse,'Belg') ;
TAC0(oilseed,'Meher') = 0.79*TAC0(oilseed,'Meher') + (1-0.79)*TAC0(oilseed,'Belg') ;
*TAC0('Rapeseed','Meher') = (0.55/0.79)*TAC0('Rapeseed','Meher') ;
TAC0(LV,'Meher') = 0.553*TAC0(LV,'Meher') + (1-0.553)*TAC0(LV,'Belg') ;
TAC0('Stimulants','Meher') = 0.572*TAC0('Stimulants','Meher') + (1-0.572)*TAC0('Stimulants','Belg') ;
TAC0('Coffee','Meher') = 0.572*TAC0('Coffee','Meher') + (1-0.572)*TAC0('Coffee','Belg') ;
TAC0('Enset','Meher') = 0.583*TAC0('Enset','Meher') + (1-0.583)*TAC0('Enset','Belg') ;
TAC0('SugarRawEquivalent','Meher') = 0.583*TAC0('SugarRawEquivalent','Meher') + (1-0.583)*TAC0('SugarRawEquivalent','Belg') ;
TAC0('Bananas','Meher') = 0.583*TAC0('Bananas','Meher') + (1-0.583)*TAC0('Bananas','Belg') ;

TAC0(c,'Belg') = TAC0(c,'Annual') - TAC0(c,'Meher') ;

TAC0(c,s)$(TAC0(c,s) lt 0) = 0 ;


ACZ0(reg,zone,'Teff','Meher') = 0.77*ACZ0(reg,zone,'Teff','Meher') + (1-0.77)*ACZ0(reg,zone,'Teff','Belg') ;
ACZ0(reg,zone,'Barley','Meher') = 0.79*ACZ0(reg,zone,'Barley','Meher') + (1-0.79)*ACZ0(reg,zone,'Barley','Belg') ;
ACZ0(reg,zone,'Wheat','Meher') = 0.76*ACZ0(reg,zone,'Wheat','Meher') + (1-0.76)*ACZ0(reg,zone,'Wheat','Belg') ;
ACZ0(reg,zone,'Maize','Meher') = 0.68*ACZ0(reg,zone,'Maize','Meher') + (1-0.68)*ACZ0(reg,zone,'Maize','Belg') ;
ACZ0(reg,zone,'Sorghum','Meher') = 0.83*ACZ0(reg,zone,'Sorghum','Meher') + (1-0.83)*ACZ0(reg,zone,'Sorghum','Belg') ;
ACZ0(reg,zone,'Millet','Meher') = 0.75*ACZ0(reg,zone,'Millet','Meher') + (1-0.75)*ACZ0(reg,zone,'Millet','Belg') ;
ACZ0(reg,zone,'Oats','Meher') = 0.75*ACZ0(reg,zone,'Oats','Meher') + (1-0.75)*ACZ0(reg,zone,'Oats','Belg') ;
ACZ0(reg,zone,'Rice','Meher') = 0.75*ACZ0(reg,zone,'Rice','Meher') + (1-0.75)*ACZ0(reg,zone,'Rice','Belg') ;
ACZ0(reg,zone,pulse,'Meher') = 0.69*ACZ0(reg,zone,pulse,'Meher') + (1-0.69)*ACZ0(reg,zone,pulse,'Belg') ;
ACZ0(reg,zone,oilseed,'Meher') = 0.79*ACZ0(reg,zone,oilseed,'Meher') + (1-0.79)*ACZ0(reg,zone,oilseed,'Belg') ;
ACZ0(reg,zone,'Rapeseed','Meher') = (0.55/0.79)*ACZ0(reg,zone,'Rapeseed','Meher') ;
ACZ0(reg,zone,LV,'Meher') = 0.553*ACZ0(reg,zone,LV,'Meher') + (1-0.553)*ACZ0(reg,zone,LV,'Belg') ;
ACZ0(reg,zone,'Stimulants','Meher') = 0.572*ACZ0(reg,zone,'Stimulants','Meher') + (1-0.572)*ACZ0(reg,zone,'Stimulants','Belg') ;
ACZ0(reg,zone,'Coffee','Meher') = 0.572*ACZ0(reg,zone,'Coffee','Meher') + (1-0.572)*ACZ0(reg,zone,'Coffee','Belg') ;
ACZ0(reg,zone,'Enset','Meher') = 0.583*ACZ0(reg,zone,'Enset','Meher') + (1-0.583)*ACZ0(reg,zone,'Enset','Belg') ;
*ACZ0(reg,zone,'SugarRawEquivalent','Meher') = 0.583*ACZ0(reg,zone,'SugarRawEquivalent','Meher') + (1-0.583)*ACZ0(reg,zone,'SugarRawEquivalent','Belg') ;
ACZ0(reg,zone,'Bananas','Meher') = 0.583*ACZ0(reg,zone,'Bananas','Meher') + (1-0.583)*ACZ0(reg,zone,'Bananas','Belg') ;

ACZ0(reg,zone,c,'Belg') = ACZ0(reg,zone,c,'Annual') - ACZ0(reg,zone,c,'Meher') ;

ACZ0(reg,zone,c,s)$(ACZ0(reg,zone,c,s) lt 0) = 0 ;

************************************************************************************************************


TAC0(c,s) = sum((reg,zone),ACZ0(reg,zone,c,s));
TQS0(c,s) = sum((reg,zone),QSZ0(reg,zone,c,s));

TACZ0(reg,zone,s)          = sum(c,ACZ0(reg,zone,c,s));

zoneareashare(s,reg,zone,c)$TAC0(c,s)       = 100*ACZ0(reg,zone,c,s)/TAC0(c,s) ;
* JL: change to original production values since supply has been shifted
* JL: new effort, make all values new (otherwise yield will mess with model calculations)
zoneoutputshare(s,reg,zone,c)$TQS0(c,s)     = 100*QSZ0(reg,zone,c,s)/TQS0(c,s) ;
*zoneoutputshare(s,reg,zone,c)$TQS0_old(c,s) = 100*QSZ0_old(reg,zone,c,s)/TQS0_old(c,s) ;

display zoneareashare, zoneoutputshare;

* export parameter 'ACZ0' to excel 'OrigAreas.xls' in tab 'TOTAL'
*$libinclude xldump ACZ0 OrigAreas.xls Total;


*==== Demand and Supply  =============
TQF0(NTC,s)$QT0(NTC,s) = TQS0(NTC,s)- TQL0(NTC,s) - TQO0(NTC,s) ;
QT0(NTC,s)           = 0 ;
QT0(TC,s)            = TQF0(TC,s) + TQL0(TC,s) + TQO0(TC,s) - TQS0(TC,s) ;

QM0(c,s)$(QT0(c,s) gt 0) = QT0(C,S);
QE0(c,s)$(QT0(c,s) lt 0) = -QT0(C,S);

QLZ0(reg,zone,c,s)$sum(lv,QSZ0(reg,zone,lv,s))       = TQL0(c,s)*sum(lv,QSZ0(reg,zone,lv,s))/sum((lv,regp,zonep),QSZ0(regp,zonep,lv,s)) ;
QLZshare0(reg,zone,c,s)$sum(lv,QSZ0(reg,zone,lv,s))  = QLZ0(reg,zone,c,s)/sum(lv,QSZ0(reg,zone,lv,s)) ;

QOZ0(reg,zone,c,s)$QSZ0(reg,zone,c,s)                = TQO0(c,s)*QSZ0(reg,zone,c,s)/sum((regp,zonep),QSZ0(regp,zonep,c,s)) ;
QOZshare0(reg,zone,c,s)$QSZ0(reg,zone,c,s)           = QOZ0(reg,zone,c,s)/QSZ0(reg,zone,c,s) ;

display TQS0, QM0, QE0, QLZshare0, QOZshare0, QLZ0, TQL0, TQO0;

TQF0(c,s) =  TQS0(c,s) + QT0(c,s) - sum((reg,zone),QLZ0(reg,zone,c,s) + QOZ0(reg,zone,c,s)) ;

* use pop to find per capita param.
TQFpc0(c,s)        = TQF0(c,s)/Tpop0 ;
TQSpc0(c,s)        = TQS0(c,s)/Tpop0 ;

*==== check yield use Demand and Supply
parameter
zeroTQS(c,s)       zero supply commodity
zeroQF(c,s)        zero demand food commodity
chkyield(c,s)      check yield (should =1)
;
* JL: check if X(c,s) eq 0 means both have to be 0
* JL: chkyield edited to require TYC0 because of shift in supply throws off calculations
* JL: also, set TYC0 to zero if TAC0 is zero
TYC0(c,s)$(TAC0(c,s) eq 0) = 0 ;
zeroTQS(c,s)$(TQS0(c,s) eq 0)        = yes;
zeroQF(c,s)$(TQF0(c,s) eq 0)         = yes;
*chkyield(c,s)$(TAC0(c,s)) = 1000*(TQS0(c,s)/TAC0(c,s))/ TYC0(c,s) ;
chkyield(c,s)$(TAC0(c,s) and TYC0(c,s)) = 1000*(TQS0_old(c,s)/TAC0(c,s))/ TYC0(c,s) ;
TYC0(c,s)$TAC0(c,s)                  = 1000*(TQS0(c,s)/TAC0(c,s)) ;

display zeroTQS, zeroQF, chkyield;

chkyield(c,s)$TAC0(c,s)              = 1000*(TQS0(c,s)/TAC0(c,s))/ TYC0(c,s) ;
display  chkyield;

*adjust 'nagntrade' and 'nagtrade' food demand values
QFZH0(reg,zone,'rur','nagntrade',s)$PoPH0(reg,zone,'rur') = incomeH0(reg,zone,'rur',s) - sum(c,RurDemand(s,reg,zone,c)) ;
QFZH0(reg,zone,'rur','nagntrade',s)$(PoPH0(reg,zone,'rur') eq 0) = 0 ;

QFZH0(reg,zone,'rur','nagtrade',s)$QFZH0(reg,zone,'rur','nagntrade',s) = 0.2*QFZH0(reg,zone,'rur','nagntrade',s) ;
QFZH0(reg,zone,'rur','nagntrade',s) = QFZH0(reg,zone,'rur','nagntrade',s) - QFZH0(reg,zone,'rur','nagtrade',s) ;

QFZH0(reg,zone,'urb','nagntrade',s)$PoPH0(reg,zone,'urb') = incomeH0(reg,zone,'urb',s) - sum(c,UrbDemand(s,reg,zone,c)) ;
QFZH0(reg,zone,'urb','nagntrade',s)$(PoPH0(reg,zone,'urb') eq 0) = 0 ;

QFZH0(reg,zone,'urb','nagtrade',s)$QFZH0(reg,zone,'urb','nagntrade',s) = 0.4*QFZH0(reg,zone,'urb','nagntrade',s) ;
QFZH0(reg,zone,'urb','nagntrade',s) = QFZH0(reg,zone,'urb','nagntrade',s) - QFZH0(reg,zone,'urb','nagtrade',s) ;

parameter
incomeagsh(reg,zone,urbrur,s)             urban and rural share in each zone over ag income
incomenagsh(reg,zone,urbrur,s)            urban and rural share in each zone over nag income
incomeagsh2(reg,zone,urbrur,s)            urban and rural ag income share in each zone over (ag+nag) income
incomenagsh2(reg,zone,urbrur,s)           urban and rural nag income share in each zone over (ag+nag) income
;
INCOMEag0(reg,zone,'rur',s)$sum(ag,QSZ0(reg,zone,ag,s)) = sum(ag,PW0(ag)*(1 + margW0(ag,s))*QSZ0(reg,zone,ag,s))/
                                 sum((regp,zonep,ag),PW0(ag)*(1 + margW0(ag,s))*QSZ0(regp,zonep,ag,s))*1.3*AgrGDP0(S) ;

INCOMEag0('AddisAbaba',zone,'urb',s)  = INCOMEag0('AddisAbaba',zone,'rur',s) ;
INCOMEag0('AddisAbaba',zone,'rur',s)  = 0 ;

INCOMEnag0(reg,zone,urbrur,s)$PoPH0(reg,zone,urbrur) = incomeH0(reg,zone,urbrur,s) - INCOMEag0(reg,zone,urbrur,s) ;
INCOMEnag0(reg,zone,urbrur,s)$(PoPH0(reg,zone,urbrur) eq 0) = 0 ;

INCOMEnag0(reg,zone,'rur',s)$(PoPH0(reg,zone,'urb') eq 0 and PoPH0(reg,zone,'rur') and incomeH0(reg,zone,'urb',s) ) =
                  sum(urbrur,incomeH0(reg,zone,urbrur,s) - INCOMEag0(reg,zone,urbrur,s)) ;
INCOMEnag0(reg,zone,'urb',s)$(PoPH0(reg,zone,'urb') and PoPH0(reg,zone,'rur') eq 0 and incomeH0(reg,zone,'rur',s) ) =
                  sum(urbrur,incomeH0(reg,zone,urbrur,s) - INCOMEag0(reg,zone,urbrur,s)) ;
INCOMEnag0(reg,zone,urbrur,s)$(PoPH0(reg,zone,urbrur) and INCOMEnag0(reg,zone,urbrur,s) lt 0) = 0.1*INCOMEag0(reg,zone,urbrur,s) ;

* JL: AwassaTown has no production data, resulting in 0 GDP that throws off calculations. Input its income as exogenous variable here.
* JL: ...total expenditure roughly matches that of neighboring Alaba
         INCOMEnag0('Southern','AwassaTown','urb',s) = 1.035 * sum(urbrur,(INCOMEag0('Southern','Alaba',urbrur,s)+INCOMEnag0('Southern','Alaba',urbrur,s)))  ;

incomeagsh(reg,zone,urbrur,s)$INCOMEag0(reg,zone,urbrur,s)   = INCOMEag0(reg,zone,urbrur,s)/sum(urbrurp,INCOMEag0(reg,zone,urbrurp,s));
incomenagsh(reg,zone,urbrur,s)$INCOMEnag0(reg,zone,urbrur,s) = INCOMEnag0(reg,zone,urbrur,s)/sum(urbrurp,INCOMEnag0(reg,zone,urbrurp,s));
incomeagsh2(reg,zone,urbrur,s)$INCOMEag0(reg,zone,urbrur,s)  = INCOMEag0(reg,zone,urbrur,s)/(INCOMEag0(reg,zone,urbrur,s) + INCOMEnag0(reg,zone,urbrur,s));
incomenagsh2(reg,zone,urbrur,s)$INCOMEnag0(reg,zone,urbrur,s)= INCOMEnag0(reg,zone,urbrur,s)/(INCOMEag0(reg,zone,urbrur,s) + INCOMEnag0(reg,zone,urbrur,s));

parameter
chknegnagincome(reg,zone,urbrur,s)   check QFZ 'incomenag<0' zones (should not be)
chknegnag(reg,zone,urbrur,c,s)       check QFZ 'nagtrade'<0 or 'nagntrade'<0 zones (should not be)
GDP_Redef(s)                          redefine GDP based on calculated income valules for all comm (include 'nagtrade' and 'nagntrade')
AgGDP_Redef(s)                        redefine Ag GDP
chkGDP(s)                             ratio of redefined GDP vs original GDP (should not be too different from one)
chkAgGDP(s)                           ratio of redefined AgGDP vs original AgGDP (should not be too different from one)
;

chknegnag(reg,zone,urbrur,'nagntrade',s)$(QFZH0(reg,zone,urbrur,'nagntrade',s) lt 0) = QFZH0(reg,zone,urbrur,'nagntrade',s) ;
chknegnag(reg,zone,urbrur,'nagtrade',s)$(QFZH0(reg,zone,urbrur,'nagtrade',s) lt 0)   = QFZH0(reg,zone,urbrur,'nagtrade',s) ;
chknegnagincome(reg,zone,urbrur,s)$(INCOMEnag0(reg,zone,urbrur,s) lt 0)              = INCOMEnag0(reg,zone,urbrur,s) ;


GDP_Redef(s)   = sum((reg,zone,urbrur),INCOMEnag0(reg,zone,urbrur,s) + INCOMEag0(reg,zone,urbrur,s));
AgGDP_Redef(s) = sum((reg,zone,urbrur),INCOMEag0(reg,zone,urbrur,s));

chkGDP(s)   = GDP_Redef(s)/GDP0(S) ;
chkAgGDP(s) = AgGDP_Redef(s)/AgrGDP0(S) ;

display chknegnag, chknegnagincome, GDP_Redef, AgGDP_Redef, chkGDP, chkAgGDP ;

$ontext
INCOMEnag0(reg,zone,'urb') = PopHshare(reg,zone,'urb')*HHnfodexpshare0(reg,zone,s)*(1.2*GDP0(S) - 1.2*AgrGDP0(S)) ;
INCOMEnag0(reg,zone,’rur’,s) = (1 - PopHshare(reg,zone,'urb'))*HHnfodexpshare0(reg,zone,s)*(1.2*GDP0(S) - 1.2*AgrGDP0(S)) ;
INCOMEnag0(reg,zone,’rur’,s)$(PopHshare(reg,zone,'rur') and INCOMEnag0(reg,zone,'urb') eq 0) =
              HHnfodexpshare0(reg,zone,s)*(1.2*GDP0(S) - 1.2*AgrGDP0(S)) ;


chkAgIncome(reg,zone,s)$INCOMEag0(reg,zone,'rur') = sum(HHS,HHIZ00(reg,zone,'rur',HHS))/INCOMEag0(reg,zone,'rur') ;
chkNAgIncome(reg,zone,s)$INCOMEnag0(reg,zone,'urb') = sum(HHS,HHIZ00(reg,zone,'urb',HHS))/INCOMEnag0(reg,zone,'urb') ;
display chkAgincome, chkNagincome;

display PopHshare;
$offtext

parameter
chkincomeag(s)          total ag income
chkincomenag(s)         total nag income
;

chkincomeag(s)  = sum((reg,zone,urbrur),INCOMEag0(reg,zone,urbrur,s) ) ;
chkincomenag(s) = sum((reg,zone,urbrur),INCOMEnag0(reg,zone,urbrur,s) ) ;

display incomenag0, chkincomeag, chkincomenag;

* redefine GDP   JL: again, check GDP calculations based on IFPRI recommendations
GDPZH0(reg,zone,urbrur,s)$PopH0(reg,zone,urbrur)    =  INCOMEag0(reg,zone,urbrur,s) + INCOMEnag0(reg,zone,urbrur,s) ;
GDPZHsh0(reg,zone,urbrur,s)$GDPZH0(reg,zone,urbrur,s) =  GDPZH0(reg,zone,urbrur,s)/SUM(urbrurp,GDPZH0(reg,zone,urbrurp,s)) ;

GDPZHpc0(reg,zone,urbrur,s)$GDPZH0(reg,zone,urbrur,s) = GDPZH0(reg,zone,urbrur,s)/PopH0(reg,zone,urbrur) ;

INCOMEagPC0(reg,zone,urbrur,s)$PopH0(reg,zone,urbrur)  = INCOMEag0(reg,zone,urbrur,s)/PopH0(reg,zone,urbrur) ;
INCOMEnagPC0(reg,zone,urbrur,s)$PopH0(reg,zone,urbrur) = INCOMEnag0(reg,zone,urbrur,s)/PopH0(reg,zone,urbrur) ;

GDPZ0(reg,zone,s)$sum(urbrur,PopH0(reg,zone,urbrur))   =  sum(urbrur,INCOMEag0(reg,zone,urbrur,s) + INCOMEnag0(reg,zone,urbrur,s)) ;
GDPZpc0(reg,zone,s)$sum(urbrur,PopH0(reg,zone,urbrur)) =  GDPZ0(reg,zone,s)/sum(urbrur,PopH0(reg,zone,urbrur)) ;
GDPRpc0(reg,s)$sum((zone,urbrur),PopH0(reg,zone,urbrur))
       =  sum((zone,urbrur),INCOMEag0(reg,zone,urbrur,s) + INCOMEnag0(reg,zone,urbrur,s))/sum((zone,urbrur),PopH0(reg,zone,urbrur)) ;
GDPPC0(S) =  sum((reg,zone,urbrur),INCOMEag0(reg,zone,urbrur,s) + INCOMEnag0(reg,zone,urbrur,s))/sum((reg,zone,urbrur),PopH0(reg,zone,urbrur)) ;

* JL: as above, change 0.5 to 0.1; comment out one line that screws up nagntrade calculations
QSZ0(reg,zone,nag,s) = 0 ;
QSZ0(reg,zone,'nagntrade',s)$sum(urbrur,PopH0(reg,zone,urbrur))   = 0.85*sum(urbrur,INCOMEnag0(reg,zone,urbrur,s)) ;
QSZ0(city,zone,'nagntrade',s)$sum(urbrur,PopH0(city,zone,urbrur)) = 0.60*sum(urbrur,INCOMEnag0(city,zone,urbrur,s)) ;
*QSZ0('AddisAbaba',zone,'nagntrade',s)$QSZ0('AddisAbaba',zone,'nagntrade',s) = 2.0*QSZ0('AddisAbaba',zone,'nagntrade',s) ;
QSZ0(city,zone,'nagtrade',s)$sum(urbrur,PopH0(city,zone,urbrur)) = 0.1*sum(urbrur,INCOMEnag0(city,zone,urbrur,s)) ;
QSZ0('AddisAbaba',zone,'nagtrade',s)$QSZ0('AddisAbaba',zone,'nagntrade',s) = 0.1*(sum((reg,zonep,urbrur),INCOMEnag0(reg,zonep,urbrur,s)) -
            sum((reg,zonep,nag),QSZ0(reg,zonep,nag,s))) + QSZ0('AddisAbaba',zone,'nagtrade',s) ;

TQS0(nag,s) = sum((reg,zone),QSZ0(reg,zone,nag,s));

TQF0(nag,s) = TQS0(nag,s) - TQL0(nag,s) - TQO0(nag,s) ;

QSZpc0(reg,zone,c,s)$QSZ0(reg,zone,c,s) = QSZ0(reg,zone,c,s)/sum(urbrur,PopH0(reg,zone,urbrur))

display incomenagPC0, QSZpc0, GDPPC0, TQF0;

*balance demand with supply
parameter
negQFZ0(t,reg,zone,c,s)    check food demand <0 (should not be)
chkTQSBAL(c,s)             should be zero
;

QFZ0(reg,zone,c,s) = (CONshare0(s,reg,zone,c)/100)*TQF0(c,s) ;

QFZ0(reg,zone,nag,s) = sum(urbrur,QFZH0(reg,zone,urbrur,nag,s)) ;

chkTQSBAL(ntc,s) = sum((reg,zone),QSZ0(reg,zone,ntc,s)) -
                 sum((reg,zone),QLZ0(reg,zone,ntc,s) + QOZ0(reg,zone,ntc,s) + QFZ0(reg,zone,ntc,s)) ;

chkTQSBAL(mc,s) = sum((reg,zone),QSZ0(reg,zone,mc,s)) + QM0(mc,s) -
                 sum((reg,zone),QLZ0(reg,zone,mc,s) + QOZ0(reg,zone,mc,s) + QFZ0(reg,zone,mc,s)) ;

chkTQSBAL(ec,s) = sum((reg,zone),QSZ0(reg,zone,ec,s)) - QE0(ec,s) -
                 sum((reg,zone),QLZ0(reg,zone,ec,s) + QOZ0(reg,zone,ec,s) + QFZ0(reg,zone,ec,s)) ;

display chkTQSbal, QFZ0 ;

negQFZ0('2015',reg,zone,c,s)$(QFZ0(reg,zone,c,s) lt 0) = QFZ0(reg,zone,c,s) ;

* cal s.t. QSZ(nag) = QFZ(nag) after agg over space
parameter
NEWTQS0(c,s)
;

NEWTQS0(nag,s) = sum((reg,zone),QFZ0(reg,zone,nag,s)) ;
QSZ0(reg,zone,nag,s) = NEWTQS0(nag,s)/sum((regp,zonep),QSZ0(regp,zonep,nag,s))*QSZ0(reg,zone,nag,s) ;
display QSZ0;
* ===========
TQS0(nag,s) = sum((reg,zone), QSZ0(reg,zone,nag,s)) ;
TQF0(nag,s) = sum((reg,zone),QFZ0(reg,zone,nag,s)) ;
QM0(nag,s) = sum((reg,zone),QFZ0(reg,zone,nag,s) - QSZ0(reg,zone,nag,s)) ;

chkTQSBAL(ntc,s) = sum((reg,zone),QSZ0(reg,zone,ntc,s)) -
                 sum((reg,zone),QLZ0(reg,zone,ntc,s) + QOZ0(reg,zone,ntc,s) + QFZ0(reg,zone,ntc,s)) ;

chkTQSBAL(mc,s) = sum((reg,zone),QSZ0(reg,zone,mc,s)) + QM0(mc,s) -
                 sum((reg,zone),QLZ0(reg,zone,mc,s) + QOZ0(reg,zone,mc,s) + QFZ0(reg,zone,mc,s)) ;

chkTQSBAL(ec,s) = sum((reg,zone),QSZ0(reg,zone,ec,s)) - QE0(ec,s) -
                 sum((reg,zone),QLZ0(reg,zone,ec,s) + QOZ0(reg,zone,ec,s) + QFZ0(reg,zone,ec,s)) ;

display chkTQSbal, negQFZ0, QM0, TQF0 ;
* == all balanced for TQ =======

Parameter
totnag(c,s)                  total supply for nag
comparIndGDP(s)               total nag-trade supply devided by (1.2*IndGDP0(S))
comparSerGDP(s)               total nag-ntrade supply divided by (1.2*SerGDP0(S))
comparNagGDP(s)               total nag supply supply divided by 1.2*(GDP0(S)-AgrGDP0(S))

DQMZratio(reg,zone,c,s)      ratio of domestic imported food demand compared to total food demand
DQEZratio(reg,zone,c,s)      ratio of domestic exported food demand compared to total food demand
;
* GDP calculated using supply
totnag(nag,s)  = sum((reg,zone),QSZ0(reg,zone,nag,s));
comparIndGDP(s) = sum((reg,zone),QSZ0(reg,zone,'nagtrade',s))/(1.2*IndGDP0(S));
comparSerGDP(s) = sum((reg,zone),QSZ0(reg,zone,'nagntrade',s))/(1.2*SerGDP0(S));
comparNagGDP(s) = sum((reg,zone,nag),QSZ0(reg,zone,nag,s))/(1.2*GDP0(S)-1.2*AgrGDP0(S));

display totnag, comparIndGDP, comparSerGDP, comparNagGDP ;

*using 'QF' same as last 'display' using 'QS' after agg over space
comparIndGDP(s) = sum((reg,zone),QFZ0(reg,zone,'nagtrade',s))/(1.2*IndGDP0(S));
comparSerGDP(s) = sum((reg,zone),QFZ0(reg,zone,'nagntrade',s))/(1.2*SerGDP0(S));
comparNagGDP(s) = sum((reg,zone,nag),QFZ0(reg,zone,nag,s))/(1.2*GDP0(S)-1.2*AgrGDP0(S));

display comparIndGDP, comparSerGDP, comparNagGDP ;

* 'D' stands for 'Deficit'
DQTZ0(reg,zone,c,s)$QFZ0(reg,zone,c,s)         = QFZ0(reg,zone,c,s) - (QSZ0(reg,zone,c,s) - QLZ0(reg,zone,c,s) - QOZ0(reg,zone,c,s)) ;
DQMZ0(reg,zone,c,s)$(DQTZ0(reg,zone,c,s) gt 0) = DQTZ0(reg,zone,c,s) ;
DQEZ0(reg,zone,c,s)$(DQTZ0(reg,zone,c,s) lt 0) = -DQTZ0(reg,zone,c,s) ;

DQMZratio(reg,zone,c,s)$(TQFpc0(c,s)*sum(urbrur,PopH0(reg,zone,urbrur)) and DQMZ0(reg,zone,c,s)) =
               100*DQMZ0(reg,zone,c,s)/(TQFpc0(c,s)*sum(urbrur,PopH0(reg,zone,urbrur)));
DQEZratio(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and DQEZ0(reg,zone,c,s)) =
               100*DQEZ0(reg,zone,c,s)/(QSZ0(reg,zone,c,s) - QLZ0(reg,zone,c,s) - QOZ0(reg,zone,c,s)) ;

parameter
zeroQFZ0(reg,zone,c,s)        check whether there is supply>0 but demand=0 regions  (should not be)(adjusted and checked again)
;
zeroQFZ0(reg,zone,c,s)$(QFZ0(reg,zone,c,s) eq 0 and QSZ0(reg,zone,c,s) gt 0) = QSZ0(reg,zone,c,s);

display zeroQFZ0;

* QFZ for all 'c'
QFZ0(reg,zone,c,s)$zeroQFZ0(reg,zone,c,s) = (QSZ0(reg,zone,c,s) - QLZ0(reg,zone,c,s) - QOZ0(reg,zone,c,s)) ;
*JL: what about imports/deficits?
*QFZ0(reg,zone,c,s)$zeroQFZ0(reg,zone,c,s) = (QSZ0(reg,zone,c,s) + DQMZ0(reg,zone,c,s) - DQEZ0(reg,zone,c,s) - QLZ0(reg,zone,c,s) - QOZ0(reg,zone,c,s)) ;

* RurUrb Demand calc for 'ag' commodities
* RurDemand in the unit of $
RurDemand(s,reg,zone,ag)$(zeroQFZ0(reg,zone,ag,s) and PoPH0(reg,zone,'rur')) = (QSZ0(reg,zone,ag,s) - QLZ0(reg,zone,ag,s) - QOZ0(reg,zone,ag,s)) ;
UrbDemand(s,reg,zone,ag)$(zeroQFZ0(reg,zone,ag,s) and PoPH0(reg,zone,'rur') eq 0 and PoPH0(reg,zone,'urb')) =
                                    (QSZ0(reg,zone,ag,s) - QLZ0(reg,zone,ag,s) - QOZ0(reg,zone,ag,s)) ;

* 'fish'
QFZ0(reg,zone,'Fish',s)$zeroQFZ0(reg,zone,'Fish',s) = 0.1*(QSZ0(reg,zone,'Fish',s) - QLZ0(reg,zone,'Fish',s) - QOZ0(reg,zone,'Fish',s)) ;

RurDemand(s,reg,zone,'Fish')$(zeroQFZ0(reg,zone,'Fish',s) and PoPH0(reg,zone,'rur') and PoPH0(reg,zone,'urb') eq 0) =
                           0.1*(QSZ0(reg,zone,'Fish',s) - QLZ0(reg,zone,'Fish',s) - QOZ0(reg,zone,'Fish',s)) ;
RurDemand(s,reg,zone,'Fish')$(zeroQFZ0(reg,zone,'Fish',s) and PoPH0(reg,zone,'rur') and PoPH0(reg,zone,'urb')) =
                           PoPH0(reg,zone,'rur')/sum(urbrur,PoPH0(reg,zone,urbrur))*0.1*
                           (QSZ0(reg,zone,'Fish',s) - QLZ0(reg,zone,'Fish',s) - QOZ0(reg,zone,'Fish',s)) ;
UrbDemand(s,reg,zone,'Fish')$(zeroQFZ0(reg,zone,'Fish',s) and PoPH0(reg,zone,'rur') and PoPH0(reg,zone,'urb')) =
                           PoPH0(reg,zone,'urb')/sum(urbrur,PoPH0(reg,zone,urbrur))*0.1*
                           (QSZ0(reg,zone,'Fish',s) - QLZ0(reg,zone,'Fish',s) - QOZ0(reg,zone,'Fish',s)) ;
UrbDemand(s,reg,zone,'Fish')$(zeroQFZ0(reg,zone,'Fish',s) and PoPH0(reg,zone,'rur') eq 0 and PoPH0(reg,zone,'urb')) =
                           0.1*(QSZ0(reg,zone,'Fish',s) - QLZ0(reg,zone,'Fish',s) - QOZ0(reg,zone,'Fish',s)) ;
* 'sesame'
QFZ0(reg,zone,'Sesame',s)$zeroQFZ0(reg,zone,'Sesame',s) =
        0.1*(QSZ0(reg,zone,'Sesame',s) - QLZ0(reg,zone,'Sesame',s) - QOZ0(reg,zone,'Sesame',s)) ;

RurDemand(s,reg,zone,'Sesame')$(zeroQFZ0(reg,zone,'Sesame',s) and PoPH0(reg,zone,'rur') and PoPH0(reg,zone,'urb') eq 0) =
                           0.1*(QSZ0(reg,zone,'Sesame',s) - QLZ0(reg,zone,'Sesame',s) - QOZ0(reg,zone,'Sesame',s)) ;
RurDemand(s,reg,zone,'Sesame')$(zeroQFZ0(reg,zone,'Sesame',s) and PoPH0(reg,zone,'rur') and PoPH0(reg,zone,'urb')) =
                           PoPH0(reg,zone,'rur')/sum(urbrur,PoPH0(reg,zone,urbrur))*0.1*
                           (QSZ0(reg,zone,'Sesame',s) - QLZ0(reg,zone,'Sesame',s) - QOZ0(reg,zone,'Sesame',s)) ;
UrbDemand(s,reg,zone,'Sesame')$(zeroQFZ0(reg,zone,'Sesame',s) and PoPH0(reg,zone,'rur') and PoPH0(reg,zone,'urb')) =
                           PoPH0(reg,zone,'urb')/sum(urbrur,PoPH0(reg,zone,urbrur))*0.1*
                           (QSZ0(reg,zone,'Sesame',s) - QLZ0(reg,zone,'Sesame',s) - QOZ0(reg,zone,'Sesame',s)) ;
UrbDemand(s,reg,zone,'Sesame')$(zeroQFZ0(reg,zone,'Sesame',s) and PoPH0(reg,zone,'rur') eq 0 and PoPH0(reg,zone,'urb')) =
                           0.1*(QSZ0(reg,zone,'Sesame',s) - QLZ0(reg,zone,'Sesame',s) - QOZ0(reg,zone,'Sesame',s)) ;

* 'cottonLint'
QFZ0(reg,zone,'cottonLint',s) = 0 ;
QFZH0(reg,zone,urbrur,'cottonLint',s) = 0 ;

QLZ0(reg,zone,c,s)$(QFZ0(reg,zone,c,s) eq 0 and QSZ0(reg,zone,c,s) eq 0) = 0 ;
QOZ0(reg,zone,c,s)$(QFZ0(reg,zone,c,s) eq 0 and QSZ0(reg,zone,c,s) eq 0) = 0 ;

* addis ababa for ntc, multiply by 0.5 because there are two zones in addis ababa, summed
* JL: now multiply by 0.1 because there are ten zones
* JL: Seems like we have the data for each zone (not aggregated to one zone), however, keep for now because Addis...
* ... is the import/export center for the country
QFZ0('AddisAbaba',zone,ntc,s)$(DQMZratio('AddisAbaba',zone,ntc,s) gt 0) =
                 0.1*sum((reg,zonep),QSZ0(reg,zonep,ntc,s) - QLZ0(reg,zonep,ntc,s) - QOZ0(reg,zonep,ntc,s)
                                          - QFZ0(reg,zonep,ntc,s)) + QFZ0('AddisAbaba',zone,ntc,s) ;
QFZ0('AddisAbaba',zone,mc,s)$(DQMZratio('AddisAbaba',zone,mc,s) gt 0) =
                 0.1*(sum((reg,zonep),QSZ0(reg,zonep,mc,s)) + QM0(mc,s) -
                                               sum((reg,zonep),QLZ0(reg,zonep,mc,s) + QOZ0(reg,zonep,mc,s)+ QFZ0(reg,zonep,mc,s)))
                                          + QFZ0('AddisAbaba',zone,mc,s) ;
QFZ0('AddisAbaba',zone,ec,s)$(DQMZratio('AddisAbaba',zone,ec,s) gt 0) =
                 0.1*(sum((reg,zonep),QSZ0(reg,zonep,ec,s)) - QE0(ec,s) -
                                               sum((reg,zonep),QLZ0(reg,zonep,ec,s) + QOZ0(reg,zonep,ec,s)+ QFZ0(reg,zonep,ec,s)))
                                          + QFZ0('AddisAbaba',zone,ec,s) ;
QFZH0('AddisAbaba',zone,'urb',ntc,s)$(DQMZratio('AddisAbaba',zone,ntc,s) gt 0) =
                 0.1*sum((reg,zonep),QSZ0(reg,zonep,ntc,s) - QLZ0(reg,zonep,ntc,s) - QOZ0(reg,zonep,ntc,s)
                                          - QFZ0(reg,zonep,ntc,s)) + QFZ0('AddisAbaba',zone,ntc,s) ;
QFZH0('AddisAbaba',zone,'urb',mc,s)$(DQMZratio('AddisAbaba',zone,mc,s) gt 0) =
                 0.1*(sum((reg,zonep),QSZ0(reg,zonep,mc,s)) + QM0(mc,s) -
                                               sum((reg,zonep),QLZ0(reg,zonep,mc,s) + QOZ0(reg,zonep,mc,s)+ QFZ0(reg,zonep,mc,s)))
                                          + QFZ0('AddisAbaba',zone,mc,s) ;
QFZH0('AddisAbaba',zone,'urb',ec,s)$(DQMZratio('AddisAbaba',zone,ec,s) gt 0) =
                 0.1*(sum((reg,zonep),QSZ0(reg,zonep,ec,s)) - QE0(ec,s) -
                                               sum((reg,zonep),QLZ0(reg,zonep,ec,s) + QOZ0(reg,zonep,ec,s)+ QFZ0(reg,zonep,ec,s)))
                                          + QFZ0('AddisAbaba',zone,ec,s) ;

parameter
zeroQFZH(reg,zone,c,s)      food demand >0 pop>0 rural and urban expenditure on ag commodity is zero (should not be)
;
zeroQFZH(reg,zone,ag,s)$(QFZ0(reg,zone,ag,s) and PoPH0(reg,zone,'rur')
                                         and (RurDemand(s,reg,zone,ag) + UrbDemand(s,reg,zone,ag)) eq 0) = yes ;
display zeroQFZH;

QFZH0(reg,zone,'rur',ag,s)$(QFZ0(reg,zone,ag,s) and PoPH0(reg,zone,'rur')) =
                                         QFZ0(reg,zone,ag,s)*RurDemand(s,reg,zone,ag)/(RurDemand(s,reg,zone,ag) + UrbDemand(s,reg,zone,ag)) ;
QFZH0(reg,zone,'rur',ag,s)$(PoPH0(reg,zone,'rur') eq 0) = 0 ;
QFZH0(reg,zone,'rur','rice',s) = 0 ;

QFZH0(reg,zone,'urb',ag,s)$(QFZ0(reg,zone,ag,s) and PoPH0(reg,zone,'urb'))  = QFZ0(reg,zone,ag,s) - QFZH0(reg,zone,'rur',ag,s) ;
QFZH0(reg,zone,'urb',ag,s)$(QFZH0(reg,zone,'urb',ag,s) lt 0 and PoPH0(reg,zone,'urb'))  =
                                0.1*PoPH0(reg,zone,'urb')/sum(urbrur,PoPH0(reg,zone,urbrur))*QFZH0(reg,zone,'rur',ag,s) ;
QFZH0(reg,zone,'urb',ag,s)$(PoPH0(reg,zone,'urb') eq 0)  = 0 ;

QFZH0(reg,zone,'rur',ag,s)$(QFZ0(reg,zone,ag,s) and PoPH0(reg,zone,'rur'))  = QFZ0(reg,zone,ag,s) - QFZH0(reg,zone,'urb',ag,s) ;


QFZH0('AddisAbaba',zone,'urb',ntc,s)$(DQMZratio('AddisAbaba',zone,ntc,s) gt 0) =
                 0.1*sum((reg,zonep),QSZ0(reg,zonep,ntc,s) - QLZ0(reg,zonep,ntc,s) - QOZ0(reg,zonep,ntc,s)
                         - sum(urbrur,QFZH0(reg,zonep,urbrur,ntc,s))) + QFZH0('AddisAbaba',zone,'urb',ntc,s) ;
QFZH0('AddisAbaba',zone,'urb',mc,s)$(DQMZratio('AddisAbaba',zone,mc,s) gt 0) =
                 0.1*(sum((reg,zonep),QSZ0(reg,zonep,mc,s)) + QM0(mc,s) -
                         sum((reg,zonep),QLZ0(reg,zonep,mc,s) + QOZ0(reg,zonep,mc,s)+ sum(urbrur,QFZH0(reg,zonep,urbrur,mc,s))))
                                          + QFZH0('AddisAbaba',zone,'urb',mc,s) ;
QFZH0('AddisAbaba',zone,'urb',ec,s)$(DQMZratio('AddisAbaba',zone,ec,s) gt 0) =
                 0.1*(sum((reg,zonep),QSZ0(reg,zonep,ec,s)) - QE0(ec,s) -
                             sum((reg,zonep),QLZ0(reg,zonep,ec,s) + QOZ0(reg,zonep,ec,s)+ sum(urbrur,QFZH0(reg,zonep,urbrur,ec,s))))
                                          + QFZH0('AddisAbaba',zone,'urb',ec,s) ;

QFZ0(reg,zone,c,s) =  sum(urbrur,QFZH0(reg,zone,urbrur,c,s));

QFZHsh0(reg,zone,urbrur,c,s)$QFZ0(reg,zone,c,s) = QFZH0(reg,zone,urbrur,c,s)/QFZ0(reg,zone,c,s) ;

parameter
chkdifQFZ(reg,zone,c,s)     check sum QF over urbrur should equal to QFZ (should show All-0)
;
chkdifQFZ(reg,zone,c,s)$(sum(urbrur,QFZH0(reg,zone,urbrur,c,s)) - QFZ0(reg,zone,c,s) ne 0) =
                sum(urbrur,QFZH0(reg,zone,urbrur,c,s)) - QFZ0(reg,zone,c,s) ;

display chkdifQFZ;

chkTQSBAL(ntc,s) = sum((reg,zone),QSZ0(reg,zone,ntc,s)) -
                 sum((reg,zone),QLZ0(reg,zone,ntc,s) + QOZ0(reg,zone,ntc,s) + QFZ0(reg,zone,ntc,s)) ;

chkTQSBAL(mc,s) = sum((reg,zone),QSZ0(reg,zone,mc,s)) + QM0(mc,s) -
                 sum((reg,zone),QLZ0(reg,zone,mc,s) + QOZ0(reg,zone,mc,s) + QFZ0(reg,zone,mc,s)) ;

chkTQSBAL(ec,s) = sum((reg,zone),QSZ0(reg,zone,ec,s)) - QE0(ec,s) -
                 sum((reg,zone),QLZ0(reg,zone,ec,s) + QOZ0(reg,zone,ec,s) + QFZ0(reg,zone,ec,s)) ;

display chkTQSbal;

TQF0(c,s) = sum((reg,zone),QFZ0(reg,zone,c,s)) ;

QDZ0(reg,zone,c,s) = 0 ;
QDZ0(reg,zone,c,s) = QFZ0(reg,zone,c,s)  + QLZ0(reg,zone,c,s)  + QOZ0(reg,zone,c,s) ;

 DQTZ0(reg,zone,c,s)  = 0 ;
 DQEZ0(reg,zone,c,s)  = 0 ;
 DQMZ0(reg,zone,c,s)  = 0 ;
 DQTZ0(reg,zone,c,s)  = QDZ0(reg,zone,c,s) - QSZ0(reg,zone,c,s) ;
 DQMZ0(reg,zone,c,s)$(DQTZ0(reg,zone,c,s) gt 0) =   DQTZ0(reg,zone,c,s) ;
 DQEZ0(reg,zone,c,s)$(DQTZ0(reg,zone,c,s) lt 0) =  -DQTZ0(reg,zone,c,s) ;

display TQF0, DQTZ0 ;

* ===== gap & margin
*== 1 US$ = 20.67 Birr
* EXR0 = 20.67 ;
 EXR0 = 1 ;

 PW0(c)  = 1.0*PW0(c) ;
* PW0(ag)  = 0.8*PW0(ag) ;

 PW0(nag) =  1000 ;
* PW0('nagtrade') =  500 ;
* PW0('nagntrade') =  300 ;

*JL: why are we adjusting these? Assume problem with old data
* PW0('maize') =  0.7*PW0('maize') ;
* PW0(lv) =  1.12*PW0(lv) ;

$ontext
 margW0(c,s)      = 0.30;
 margW0(mc)    = 0.20;
 margW0(ec)    = 0.20;
 margW0(ntc)    = 0.20;
 margW0('BovineMeat') = 0.15;
 margW0('Mutton_GoatMeat') = 0.15;
* margW0(cereal)$ntc(cereal)    = 0.60;
* margW0('Enset')  = 0.60;
* margW0('SweetPotatoes')  = 0.60;
* margW0('vegetablesOther')  = 0.60;
 margW0('maize')  = 0.10;
 margW0('wheat')  = 0.15;
 margW0('rice')   = 0.20;
$offtext

 margW0(c,s)   = 1.0*margW0(c,s) ;
 margW0(mc,s)  = 0.5*margW0(mc,s) ;

 margW0(nag,s)     = 0.20;

 margD0(c,s)       = 0.25 ;
 margD0(nag,s)     = 0.0 ;
* all = zero. income = supply, no marg between overall consumer price and producer price
 margD0(c,s)       = 0.0 ;

 margW(c,s)      =  margW0(c,s) ;
 margD(c,s)      =  margD0(c,s) ;

 margZ0(reg,zone,c,s)    = domain_var0(s,reg,zone,'MKT_MEAN')/100;
 margZ0(reg,zone,nag,s)$popZ0(reg,zone)  = 0.20;
 margZ0(reg,zone,c,s)$(DQMZ0(reg,zone,c,s) and margZ0(reg,zone,c,s) lt 0.6)   = 0.60;
 margZ0(reg,zone,c,s)$(DQEZ0(reg,zone,c,s) and margZ0(reg,zone,c,s) lt 0.6)   = 0.60;


* gap < margin , gap is the price variablity in each zone with overall reference price PC(c,s)
gapZ0(reg,zone,c,s)$(DQTZ0(reg,zone,c,s) ge 0) = 0.5*margZ0(reg,zone,c,s);
gapZ0(reg,zone,c,s)$(DQTZ0(reg,zone,c,s) lt 0) = -0.5*margZ0(reg,zone,c,s);

gapZ0(reg,zone,'nagntrade',s) = 0;
margZ0(reg,zone,c,s) = 0 ;

display DQMZ0, DQEZ0, gapz0 ;

 PWM0(c,s) = PW0(c)*(1 +  margW0(c,s) );
 PWE0(c,s) = PW0(c)*(1 -  margW0(c,s) );
* PWE0(ntc) = PW0(ntc)*(1 -  1.0*margW0(ntc) );

 PWE(c,s) = PWE0(c,s) ;
 PWM(c,s) = PWM0(c,s) ;
*ying5 =========
*PP0(c,s) = 1;
*PC0(c,s) = PP0(c,s);
* =============
 PP0(EC,s)         =  EXR0*PWE0(EC,s)*(1 - margW0(EC,s));
 PC0(EC,s)         =  PP0(EC,s)*(1 + margD0(EC,s)) ;
 PC0(MC,s)         =  EXR0*PWM0(MC,s)*(1 + margW0(MC,s));
 PP0(MC,s)         =  PC0(MC,s)/(1 + margD0(MC,s));

 PP0(NTC,s)         = EXR0*PWM0(NTC,s) ;
* PP0(NTC)         = EXR0*PW0(NTC) ;
 PP0(C,S)$(QM0(c,s) eq 0 and QE0(c,s) eq 0 and not NTC(c))   = EXR0*PWM0(c,s) ;
 PC0(NTC,s)         =  PP0(NTC,s)*(1 + margD0(NTC,s));
 PC0(C,S)$(QM0(c,s) eq 0 and QE0(c,s) eq 0)   =  PP0(C,S)*(1 + margD0(c,s));

 QSZ0(reg,zone,nag,s) = QSZ0(reg,zone,nag,s)/(2*PC0(nag,s)/PW0(nag)) ;
 QFZH0(reg,zone,urbrur,nag,s) = QFZH0(reg,zone,urbrur,nag,s)/(2*PC0(nag,s)/PW0(nag)) ;
* QSZ0(reg,zone,nag) = QSZ0(reg,zone,nag)/(PC0(nag)/PW0(nag)) ;
* QFZH0(reg,zone,urbrur,nag) = QFZH0(reg,zone,urbrur,nag)/(PC0(nag)/PW0(nag)) ;
 QFZ0(reg,zone,nag,s) =  sum(urbrur, QFZH0(reg,zone,urbrur,nag,s));
* QFZ0(reg,zone,c,s) =  sum(urbrur, QFZH0(reg,zone,urbrur,c,s));
* QFZ0(reg,zone,nag) = QFZ0(reg,zone,nag)/(PC0(nag)/PW0(nag)) ;
* QSZ0(reg,zone,nag) = QSZ0(reg,zone,nag)/(PC0(nag)/PW0(nag)) ;

* PCZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s)) = PC0(c,s) ;

* margin/gap is percentage
 PCZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s)) = (1 + gapZ0(reg,zone,c,s))*PC0(c,s) ;
 PPZ0(reg,zone,'nagntrade',s)$(QSZ0(reg,zone,'nagntrade',s) or QFZ0(reg,zone,'nagntrade',s)) =
               PCZ0(reg,zone,'nagntrade',s)/(1 + margZ0(reg,zone,'nagntrade',s) ) ;
* JL: some zones have no production during the Belg season, so QSZ0 or QFZ0 are zero and prices are therefore also zero...
* ...However, this leads to errors in the equations at the end of the script. Set prices in these cases to annual price:
*PCZ0(reg,zone,c,'belg')$(QSZ0(reg,zone,c,'belg') eq 0 and QFZ0(reg,zone,c,'belg') eq 0) = PCZ0(reg,zone,c,'annual') ;

* margin/PP, use nagntrade PPZ as reference price / numeraire
 margZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s)) = margZ0(reg,zone,c,s)/PPZ0(reg,zone,'nagntrade',s) ;
 margZ(reg,zone,c,s)  =  margZ0(reg,zone,c,s)  ;

* gapZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s)) = gapZ0(reg,zone,c,s)/PPZ0(reg,zone,'nagntrade',s) ;

 PPZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s))  =
          PCZ0(reg,zone,c,s)/(1 + PPZ0(reg,zone,'nagntrade',s)*margZ0(reg,zone,c,s) ) ;


*QFZ0('AddisAbaba',zone,nag)$(DQMZratio('AddisAbaba',zone,nag) gt 0) =
*                 0.5*sum((reg,zonep),QSZ0(reg,zonep,nag) - QLZ0(reg,zonep,nag) - QOZ0(reg,zonep,nag)
*                                          - QFZ0(reg,zonep,nag)) + QFZ0('AddisAbaba',zone,nag) ;

 gapZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s))  =  gapZ0(reg,zone,c,s)/PPZ0(reg,zone,'nagntrade',s)  ;
 gapZ(reg,zone,c,s) =  gapZ0(reg,zone,c,s);
 gapZ2(reg,zone,c,s) =  gapZ0(reg,zone,c,s);
 PCZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s)) = (1 + gapZ0(reg,zone,c,s)*PPZ0(reg,zone,'nagntrade',s))*PC0(c,s) ;

 display  pcz0;

* margD0(c,s)      =  margD0(c,s)/(sum((reg,zone),QSZ0(reg,zone,'nagntrade',s)*PPZ0(reg,zone,'nagntrade',s))/
*                             sum((reg,zone),QSZ0(reg,zone,'nagntrade',s)) );

 margD(c,s)      =  margD0(c,s) ;
 display margw, margD;


* ying ======================================
parameter
tempPNAG(reg,zone,s)            check PPZ'nagntrade'
chkPCZ0(reg,zone,c,s)           should be 0
chkmargZ(reg,zone,c,s)          check zonal margin between consumer and producer price
chkmargW(c,s)                   check word margin between PC(c s) and PP(c s)
negQFZH0(reg,zone,urbrur,c,s)   food demand <0 (should not be)
;

tempPNAG(reg,zone,s) = PPZ0(reg,zone,'nagntrade',s) ;
display tempPNAG;

negQFZH0(reg,zone,urbrur,c,s)$(QFZH0(reg,zone,urbrur,c,s) lt 0) = QFZH0(reg,zone,urbrur,c,s) ;
display negQFZH0  ;
*display QFZH0;

*QFZHsh0(reg,zone,urbrur,c,s)$QFZ0(reg,zone,c,s) = QFZH0(reg,zone,urbrur,c,s)/QFZ0(reg,zone,c,s) ;
*QFZH0(reg,zone,urbrur,c,s)$QFZHsh0(reg,zone,urbrur,c,s) = QFZHsh0(reg,zone,urbrur,c,s)*QFZ0(reg,zone,c,s) ;

zeroQFZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) gt 0 and QFZ0(reg,zone,c,s) eq 0) = yes ;

QFZHpc0(reg,zone,urbrur,c,s)$QFZH0(reg,zone,urbrur,c,s) = QFZH0(reg,zone,urbrur,c,s)/(1000*PopH0(reg,zone,urbrur)) ;
*QFZ0(reg,zone,c,s) = sum(urbrur,QFZHpc0(reg,zone,urbrur,c,s)*PopH0(reg,zone,urbrur)) ;
QFZpc0(reg,zone,c,s)$QFZ0(reg,zone,c,s) = sum(urbrur,QFZH0(reg,zone,urbrur,c,s))/sum(urbrur,1000*PopH0(reg,zone,urbrur)) ;

chkmargZ(reg,zone,c,s)$PPZ0(reg,zone,c,s) = PCZ0(reg,zone,c,s)/PPZ0(reg,zone,c,s) - 1;
chkmargW(c,s)$margW0(c,s) = PC0(c,s)/PP0(c,s) - 1;

chkPCZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s)) = PPZ0(reg,zone,c,s) -
                PCZ0(reg,zone,c,s)/(1 + PPZ0(reg,zone,'nagntrade',s)*margZ0(reg,zone,c,s) ) ;

display zeroQFZ0, chkmargw, chkmargz, chkPCZ0;

parameter
comparPCZ(reg,zone,c,s)            ratio of PCZ to PWM for zonal deficit commodities (>1 for import c)
comparPPZ(reg,zone,c,s)            ratio of PPZ to PWE for zonal deficit commodities (>1 for import c)
comparPCZ2(reg,zone,c,s)           ratio of PCZ to PWM for zonal surplus commodities (<1 for export c)
comparPPZ2(reg,zone,c,s)           ratio of PPZ to PWE for zonal surplus commodities (<1 for export c)
difPWME(c,s)                       difference of PWM-PWE
;
 PPAVGR0(reg,c,s)$sum(zone,QSZ0(reg,zone,c,s)) = sum(zone,PPZ0(reg,zone,c,s)*QSZ0(reg,zone,c,s))/
                                    sum(zone,QSZ0(reg,zone,c,s)) ;
 PCAVGR0(reg,c,s)$sum(zone,QFZ0(reg,zone,c,s)) = sum(zone$QFZ0(reg,zone,c,s),PCZ0(reg,zone,c,s)*QFZ0(reg,zone,c,s))/
                                    sum(zone$QFZ0(reg,zone,c,s),QFZ0(reg,zone,c,s)) ;
 PPAVG0(c,s)$sum((reg,zone),QSZ0(reg,zone,c,s)) = sum((reg,zone)$QSZ0(reg,zone,c,s),PPZ0(reg,zone,c,s)*QSZ0(reg,zone,c,s))/
                                    sum((reg,zone)$QSZ0(reg,zone,c,s),QSZ0(reg,zone,c,s)) ;
 PCAVG0(c,s)$sum((reg,zone),QFZ0(reg,zone,c,s)) = sum((reg,zone)$QFZ0(reg,zone,c,s),PCZ0(reg,zone,c,s)*QFZ0(reg,zone,c,s))/
                                    sum((reg,zone)$QFZ0(reg,zone,c,s),QFZ0(reg,zone,c,s)) ;

comparPCZ(reg,zone,c,s)$DQMZ0(reg,zone,c,s)  = PCZ0(reg,zone,c,s)/PWM0(c,s) ;
comparPCZ2(reg,zone,c,s)$DQEZ0(reg,zone,c,s) = PCZ0(reg,zone,c,s)/PWM0(c,s) ;

comparPPZ(reg,zone,c,s)$DQMZ0(reg,zone,c,s)  = PPZ0(reg,zone,c,s)/PWE0(c,s) ;
comparPPZ2(reg,zone,c,s)$DQEZ0(reg,zone,c,s) = PPZ0(reg,zone,c,s)/PWE0(c,s) ;

totmargZ0(reg,zone,s)$sum(c,QFZ0(reg,zone,c,s)) =
      (sum(c$QFZ0(reg,zone,c,s),(PCZ0(reg,zone,c,s) -
*           PPZ0(reg,zone,c,s))*QFZ0(reg,zone,c,s))  )/PPZ0(reg,zone,'nagntrade',s) ;
           PPZ0(reg,zone,c,s))*QFZ0(reg,zone,c,s))  ) ;
difPWME(c,s) = PWM0(c,s) - PWE(c,s);
display comparPCZ, comparPPZ, comparPCZ2, comparPPZ2, difPWME;

parameter
chkQSR0(reg,c,s)        check regional QS
chkQS0(c,s)             check total QS
;

chkQSR0(reg,c,s) = sum(zone,QSZ0(reg,zone,c,s));
chkQS0(c,s)      = sum((reg,zone),QSZ0(reg,zone,c,s));

display PP0, PC0, totmargz0, chkQSR0, chkQS0, PPAVGR0, PPAVG0, QSZ0, PPZ0, PCZ0;

*QFZ0(reg,zone,'nagntrade')$(QFZ0(reg,zone,'nagntrade') - totmargZ0(reg,zone,s) gt 0) = QFZ0(reg,zone,'nagntrade') - totmargZ0(reg,zone,s) ;
*QFZ0(reg,zone,'nagntrade')$(QFZ0(reg,zone,'nagntrade') - totmargZ0(reg,zone,s) lt 0) = QFZ0(reg,zone,'nagntrade')  ;

QDZ0(reg,zone,c,s) = QFZ0(reg,zone,c,s)  + QLZ0(reg,zone,c,s)  + QOZ0(reg,zone,c,s) ;

 DQTZ0(reg,zone,c,s)                          =  QDZ0(reg,zone,c,s) - QSZ0(reg,zone,c,s) ;
 DQMZ0(reg,zone,c,s)$(DQTZ0(reg,zone,c,s) gt 0) =  DQTZ0(reg,zone,c,s) ;
 DQEZ0(reg,zone,c,s)$(DQTZ0(reg,zone,c,s) lt 0) =  -DQTZ0(reg,zone,c,s) ;

TQS0(c,s) = sum((reg,zone),QSZ0(reg,zone,c,s)) ;
TQF0(c,s) = sum((reg,zone),QFZ0(reg,zone,c,s)) ;
TQL0(c,s) = sum((reg,zone),QLZ0(reg,zone,c,s)) ;
TQO0(c,s) = sum((reg,zone),QOZ0(reg,zone,c,s)) ;
TQD0(c,s) = sum((reg,zone),QDZ0(reg,zone,c,s)) ;
QT0(c,s)  = TQD0(c,s) - TQS0(c,s) ;
QM0(c,s)$(QT0(c,s) gt 0) = QT0(c,s) ;
QE0(c,s)$(QT0(c,s) lt 0) = -QT0(c,s) ;

display QT0;

QLZ0(reg,zone,c,s)$sum(lv,QSZ0(reg,zone,lv,s))      = TQL0(c,s)*sum(lv,QSZ0(reg,zone,lv,s))/sum((lv,regp,zonep),QSZ0(regp,zonep,lv,s)) ;
QLZshare0(reg,zone,c,s)$sum(lv,QSZ0(reg,zone,lv,s)) = PCZ0(reg,zone,c,s)*QLZ0(reg,zone,c,s)/sum(lv,QSZ0(reg,zone,lv,s)) ;

QOZ0(reg,zone,c,s)$QSZ0(reg,zone,c,s)      = TQO0(c,s)*QSZ0(reg,zone,c,s)/sum((regp,zonep),QSZ0(regp,zonep,c,s)) ;
QOZshare0(reg,zone,c,s)$QSZ0(reg,zone,c,s) = PCZ0(reg,zone,c,s)*QOZ0(reg,zone,c,s)/QSZ0(reg,zone,c,s) ;

QLZshare(reg,zone,c,s) = QLZshare0(reg,zone,c,s) ;
QOZshare(reg,zone,c,s) = QOZshare0(reg,zone,c,s) ;

parameter
VTQS0(c,s)       total volum2 of supply in $
VTQF0(c,s)       total volume of food demand in $
chkIncomeBAL(reg,zone,s)
;
VTQS0(c,s) =  sum((reg,zone),PPZ0(reg,zone,c,s)*QSZ0(reg,zone,c,s));
VTQF0(c,s) =  sum((reg,zone),PCZ0(reg,zone,c,s)*QFZ0(reg,zone,c,s));

display VTQF0, VTQS0 ;

negQFZ0(t,reg,zone,c,s)$(QFZ0(reg,zone,c,s) lt 0) = QFZ0(reg,zone,c,s) ;
display negQFZ0;

PopH(reg,zone,urbrur) = PopH0(reg,zone,urbrur) ;
PopHShare0(reg,zone,urbrur)$PopH(reg,zone,urbrur) = PopH(reg,zone,urbrur)/sum(urbrurp,PopH(reg,zone,urbrurp)) ;
PopHShare(reg,zone,urbrur)= PopHShare0(reg,zone,urbrur) ;
display chkTQSBAL, QFZ0, QFZpc0, DQTZ0, poph0 ;

ownareashare(reg,zone,c,s)$ACZ0(reg,zone,c,s) = 100*ACZ0(reg,zone,c,s)/sum(cp,ACZ0(reg,zone,cp,s)) ;
* JL: change to old QSZ to preserve output values
ownoutputshare(reg,zone,c,s)$QSZ0(reg,zone,c,s) = 100*QSZ0(reg,zone,c,s)/sum(cp,QSZ0(reg,zone,cp,s)) ;
*ownoutputshare(reg,zone,c,s)$QSZ0_old(reg,zone,c,s) = 100*QSZ0_old(reg,zone,c,s)/sum(cp,QSZ0_old(reg,zone,cp,s)) ;


 ExpendZ0(reg,zone,s) = sum(c,PCZ0(reg,zone,c,s)*QFZ0(reg,zone,c,s));
 ExpendZH0(reg,zone,urbrur,s) = sum(c,PCZ0(reg,zone,c,s)*QFZH0(reg,zone,urbrur,c,s));

 GDPZ0(reg,zone,s) = sum(c,PPZ0(reg,zone,c,s)*QSZ0(reg,zone,c,s));

 GDPZH0(reg,zone,urbrur,s)$GDPZ0(reg,zone,s)  = incomeagsh(reg,zone,urbrur,s)*sum(ag,PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s)) +
                             incomenagsh(reg,zone,urbrur,s)*sum(nag,PPZ0(reg,zone,nag,s)*QSZ0(reg,zone,nag,s));

*JL: DireDawa has no belg production--leads to errors. Workaround here:
 GDPZH0('DireDawa','DireDawa','rur','belg') =  GDPZH0('DireDawa','DireDawa','rur','annual') - GDPZH0('DireDawa','DireDawa','rur','meher') ;

 GDPZHsh0(reg,zone,urbrur,s)$GDPZH0(reg,zone,urbrur,s) =  GDPZH0(reg,zone,urbrur,s)/SUM(urbrurp,GDPZH0(reg,zone,urbrurp,s)) ;

 GDPZ0(reg,zone,s) = sum(urbrur,GDPZH0(reg,zone,urbrur,s)) ;

 ExpendR0(reg,s) = sum(zone,ExpendZ0(reg,zone,s));
 GDPR0(reg,s) = sum(zone,GDPZ0(reg,zone,s));

 ExpendZpc0(reg,zone,s)$ExpendZ0(reg,zone,s) = ExpendZ0(reg,zone,s)/(1000*sum(urbrur,PopH0(reg,zone,urbrur)))  ;
 ExpendZHpc0(reg,zone,urbrur,s)$ExpendZH0(reg,zone,urbrur,s) = ExpendZH0(reg,zone,urbrur,s)/(1000*PopH0(reg,zone,urbrur))  ;

 GDPZpc0(reg,zone,s)$GDPZ0(reg,zone,s) = GDPZ0(reg,zone,s)/(1000*sum(urbrur,PopH0(reg,zone,urbrur)))  ;
 GDPZHpc0(reg,zone,urbrur,s)$GDPZH0(reg,zone,urbrur,s) = GDPZH0(reg,zone,urbrur,s)/(1000*PopH0(reg,zone,urbrur))  ;

 AgExpendZpc0(reg,zone,s)$ExpendZ0(reg,zone,s) = sum(ag,PCZ0(reg,zone,ag,s)*QFZ0(reg,zone,ag,s))/(1000*sum(urbrur,PopH0(reg,zone,urbrur)))  ;
 AgGDPZpc0(reg,zone,s)$GDPZ0(reg,zone,s) = sum(ag,PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s))/(1000*sum(urbrur,PopH0(reg,zone,urbrur)))  ;

 ExpendRpc0(reg,s)$ExpendR0(reg,s) = ExpendR0(reg,s)/(1000*sum((zone,urbrur),PopH0(reg,zone,urbrur)))  ;
 GDPRpc0(reg,s)$GDPR0(reg,s) = GDPR0(reg,s)/(1000*sum((zone,urbrur),PopH0(reg,zone,urbrur)))  ;

 AgExpendRpc0(reg,s) = sum((zone,ag),PCZ0(reg,zone,ag,s)*QFZ0(reg,zone,ag,s))/(1000*sum((zone,urbrur),PopH0(reg,zone,urbrur)))  ;
 AgGDPRpc0(reg,s) = sum((zone,ag),PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s))/(1000*sum((zone,urbrur),PopH0(reg,zone,urbrur)))  ;

 TEXPEND0(S)    = sum(reg,ExpendR0(reg,s))  ;
 GDP0(S)        = sum((reg,zone,c),PPZ0(reg,zone,c,s)*QSZ0(reg,zone,c,s))  ;
 AgGDP0(S)      = sum((reg,zone,ag),PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s)) ;
 NAgGDP0(S)     = sum((reg,zone,nag),PPZ0(reg,zone,nag,s)*QSZ0(reg,zone,nag,s)) ;
 Texpendpc0(s)  = sum(reg,ExpendR0(reg,s))/(1000*sum((reg,zone,urbrur),PopH0(reg,zone,urbrur)))  ;
 GDPpc0(s)      = GDP0(S)/(1000*sum((reg,zone,urbrur),PopH0(reg,zone,urbrur)))  ;

 Agexpendpc0(s) = sum((reg,zone,ag),PCZ0(reg,zone,ag,s)*QFZ0(reg,zone,ag,s))/(1000*sum((reg,zone,urbrur),PopH0(reg,zone,urbrur)))  ;
 AgGDPpc0(s)    = sum((reg,zone,ag),PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s))/(1000*sum((reg,zone,urbrur),PopH0(reg,zone,urbrur)))  ;

 AgGDPZ0(reg,zone,s)  = sum(ag,PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s)) ;
 NAgGDPZ0(reg,zone,s) = sum(nag,PPZ0(reg,zone,nag,s)*QSZ0(reg,zone,nag,s)) ;

 chkIncomeBAL(reg,zone,s)$ExpendZpc0(reg,zone,s) = ExpendZpc0(reg,zone,s)/
             (GDPZpc0(reg,zone,s) + PPZ0(reg,zone,'nagntrade',s)*totmargZ0(reg,zone,s)/(1000*sum(urbrur,PopH0(reg,zone,urbrur)))) ;

display GDP0, AgGDP0, GDPpc0, NagGDPZ0;

*===covert poverty line to be consistent with data
*HHIZ0(reg,zone,'urb',HHS) = HHIZshare0(reg,zone,'urb',HHS)*NAgGDP0(S) ;
*HHIZ0(reg,zone,'rur',HHS) = HHIZshare0(reg,zone,'rur',HHS)*AgGDP0(S) ;

HHIZ0(reg,zone,'urb',HHS,s) = HHIshareZ0(reg,zone,'urb',HHS,s)*sum(nag,PPZ0(reg,zone,nag,s)*QSZ0(reg,zone,nag,s)) ;
HHIZ0(reg,zone,'rur',HHS,s) = HHIshareZ0(reg,zone,'rur',HHS,s)*sum(ag,PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s)) ;
HHIZ0(reg,zone,'rur',HHS,s)$(sum(HHSP,HHIshareZ0(reg,zone,'urb',HHSP,s)) eq 0) =
          HHIshareZ0(reg,zone,'rur',HHS,s)*sum(c,PPZ0(reg,zone,c,s)*QSZ0(reg,zone,c,s)) ;

HHIR0(reg,urbrur,HHS,s) = sum(zone,HHIZ0(reg,zone,urbrur,HHS,s)) ;
HHI0(urbrur,HHS,s)      = sum((reg,zone),HHIZ0(reg,zone,urbrur,HHS,s)) ;

HHIZpc0(reg,zone,urbrur,HHS,s)$HHIZ0(reg,zone,urbrur,HHS,s)  = HHIZ0(reg,zone,urbrur,HHS,s)/(0.1*1000*PopH0(reg,zone,urbrur));
HHIRpc0(reg,urbrur,HHS,s)$sum(zone,PoPH0(reg,zone,urbrur)) =
             sum(zone,HHIZ0(reg,zone,urbrur,HHS,s))/(0.1*sum(zone,1000*PoPH0(reg,zone,urbrur))) ;
HHIpc0(urbrur,HHS,s)    = sum((reg,zone),HHIZ0(reg,zone,urbrur,HHS,s))/(0.1*sum((reg,zone),1000*PoPH0(reg,zone,urbrur))) ;

parameter
chkAgIncome(reg,zone,s)      rural income over agGDP  (~1)    Afar 5 is too large (?)
chkNAgIncome(reg,zone,s)     urban income over nagGDP (~1)
;

chkAgIncome(reg,zone,s)$INCOMEag0(reg,zone,'rur',s) = sum(HHS,HHIZ0(reg,zone,'rur',HHS,s))/AgGDPZ0(reg,zone,s) ;
chkNAgIncome(reg,zone,s)$(INCOMEnag0(reg,zone,'urb',s) and NagGDPZ0(reg,zone,s)) = sum(HHS,HHIZ0(reg,zone,'urb',HHS,s))/NagGDPZ0(reg,zone,s) ;


display chkAgincome, chkNagincome, GDP0, AgGDP0, NAgGDP0, GDPpc0, AgGDPpc0, HHIRpc0, HHIpc0;


parameter
chkHHIZ0(reg,zone,urbrur,s)   should be zero after adjusting HHI wrt GDP
chkHHI(urbrur,HHS,s)          adjustment ratio
chkHHIpc(urbrur,HHS,s)        adjustment ratio
AvgHHIZpc0(reg,zone,urbrur,s) average income per capita
;
chkHHIZ0(reg,zone,'urb',s) = sum(HHS,HHIZ0(reg,zone,'urb',HHS,s)) - sum(nag,PPZ0(reg,zone,nag,s)*QSZ0(reg,zone,nag,s)) ;
chkHHIZ0(reg,zone,'rur',s) = sum(HHS,HHIZ0(reg,zone,'rur',HHS,s)) - sum(ag,PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s)) ;
chkHHIZ0(reg,zone,'urb',s)$(sum(HHSP,HHIshareZ0(reg,zone,'urb',HHSP,s)) eq 0) = sum(HHS,HHIZ0(reg,zone,'urb',HHS,s)) ;
chkHHIZ0(reg,zone,'rur',s)$(sum(HHSP,HHIshareZ0(reg,zone,'urb',HHSP,s)) eq 0) =
       sum(HHS,HHIZ0(reg,zone,'rur',HHS,s)) - sum(c,PPZ0(reg,zone,c,s)*QSZ0(reg,zone,c,s)) ;
chkHHIZ0(reg,zone,'rur',s)$(sum(HHSP,HHIshareZ0(reg,zone,'rur',HHSP,s)) eq 0) = sum(HHS,HHIZ0(reg,zone,'rur',HHS,s)) ;

chkHHI(urbrur,HHS,s)   = HHI0(urbrur,HHS,s)/HHI00(urbrur,HHS,s);
chkHHIpc(urbrur,HHS,s) = HHIpc0(urbrur,HHS,s)/HHIpc00(urbrur,HHS,s);

AvgHHIZpc0(reg,zone,urbrur,s)$PoPH0(reg,zone,urbrur)  = sum(HHS,HHIZ0(reg,zone,urbrur,HHS,s))/(1000*PoPH0(reg,zone,urbrur)) ;

display chkHHIZ0, chkHHI, chkHHIpc, HHIZpc0, HHIZ0, avgHHIZpc0;


HHIZshare(reg,zone,'rur',HHS,s)$AgGDPZ0(reg,zone,s)  = HHIZ0(reg,zone,'rur',HHS,s)/AgGDPZ0(reg,zone,s);
HHIZshare(reg,zone,'urb',HHS,s)$NagGDPZ0(reg,zone,s) = HHIZ0(reg,zone,'urb',HHS,s)/NAgGDPZ0(reg,zone,s);
HHIZshare(reg,zone,'rur',HHS,s)$(NagGDPZ0(reg,zone,s) and HHIZshare(reg,zone,'urb',HHS,s) eq 0) =
                        HHIZ0(reg,zone,'rur',HHS,s)/(AgGDPZ0(reg,zone,s) + NAgGDPZ0(reg,zone,s));
HHIZshare(reg,zone,'urb',HHS,s)$(NagGDPZ0(reg,zone,s) and HHIZshare(reg,zone,'rur',HHS,s) eq 0) =
                        HHIZ0(reg,zone,'urb',HHS,s)/(AgGDPZ0(reg,zone,s) + NAgGDPZ0(reg,zone,s)) ;

parameter
chkHHIZhshare(reg,zone,urbrur,hhs,s)
;

chkHHIZhshare(reg,zone,urbrur,hhs,s)$HHIZshare(reg,zone,urbrur,HHS,s)  =
          HHIshareZ0(reg,zone,urbrur,HHS,s)/ HHIZshare(reg,zone,urbrur,HHS,s) ;
display chkHHIZhshare;

*======== Income Elasticity ==================================================

parameter
edfipart1(t,reg,zone,s)          income elas part 1
edfipart2(t,reg,zone,s)          income elas part 2
largedfipart1(t,reg,zone,s)      large income elas par1 (>1)
largedfipart2(t,reg,zone,s)      large income elas par2 (>1)

chkedfi(t,reg,zone,s)            edfi0*EXPENDZshare0 sum over all c
chktotIncomeBal(s)                expend divided by GDP+ppz*totmargin
chkIncomeBalR(reg,s)             expend divided by GDP+ppz*totmargin
negedfi0(t,reg,zone,c,s)         income elas <0
SSouthOmoshare(c,s)              EXPENDZshare0 for Southern SouthOmo

edfiHpart1(reg,zone,urbrur,s)         income elas part 1
edfiHpart2(reg,zone,urbrur,s)         income elas part 2
chkedfiH(reg,zone,urbrur,s)           edfi0*EXPENDZshare0 sum over all c
negedfiH0(reg,zone,urbrur,c,s)        income elas <0
negQFZH0(reg,zone,urbrur,c,s)         QFZH0 <0
;

chkIncomeBalR(reg,s) = sum(zone,ExpendZ0(reg,zone,s))/
             sum(zone,GDPZ0(reg,zone,s) + PPZ0(reg,zone,'nagntrade',s)*totmargZ0(reg,zone,s)) ;
chktotIncomeBal(s) = sum((reg,zone),ExpendZ0(reg,zone,s))/
             sum((reg,zone),GDPZ0(reg,zone,s) + PPZ0(reg,zone,'nagntrade',s)*totmargZ0(reg,zone,s)) ;

display chktotIncomeBal, chkIncomeBalR, chkIncomeBal;

chktotIncomeBal(s) = sum((reg,zone),ExpendZ0(reg,zone,s))/
             sum((reg,zone),GDPZ0(reg,zone,s) + totmargZ0(reg,zone,s)) ;

* growth rate/change of elas over t
edfi0(t,reg,zone,c,s)$QFZpc0(reg,zone,c,s)   = edfiL(t,c) ;
edfi0(t,city,zone,C,s)$QFZpc0(city,zone,c,s) = edfiH(t,c) ;

*JL: comment out because outdated
*edfi0(t,'Gambella',zone,lv) = 0.7*edfi0(t,'Gambella',zone,lv) ;
*edfi0(t,'Benshangul','Kemeshi',lv) = 0.9*edfi0(t,'Benshangul','Kemeshi',lv) ;

* ying2 - 2003 as base year for calibration? for year 1983-2011, need values over these yrs (subscript t)-see excel?
* JL: change to 2015
edfiZH0(reg,zone,'rur',C,s)$QFZHpc0(reg,zone,'rur',c,s) = edfiL('2015',c) ;
edfiZH0(reg,zone,'urb',C,s)$QFZHpc0(reg,zone,'urb',c,s) = edfiH('2015',c) ;

*edfiZH0('Gambella',zone,'rur',lv) = 0.7*edfiZH0('Gambella',zone,'rur',lv) ;
*edfiZH0('Gambella',zone,'urb',lv) = 0.7*edfiZH0('Gambella',zone,'urb',lv) ;
*edfiZH0('Benshangul','Kemeshi','rur',lv) = 0.9*edfiZH0('Benshangul','Kemeshi','rur',lv) ;

 ExpendZshare0(reg,zone,c,s)$QFZ0(reg,zone,c,s) = PCZ0(reg,zone,c,s)*QFZ0(reg,zone,c,s)/
                      sum(cp,PCZ0(reg,zone,cp,s)*QFZ0(reg,zone,cp,s));
 ExpendZHshare0(reg,zone,urbrur,c,s)$QFZH0(reg,zone,urbrur,c,s) = PCZ0(reg,zone,c,s)*QFZH0(reg,zone,urbrur,c,s)/
                      sum(cp,PCZ0(reg,zone,cp,s)*QFZH0(reg,zone,urbrur,cp,s));
 ExpendRshare0(reg,c,s)$sum(zone,QFZ0(reg,zone,c,s)) = sum(zone,PCZ0(reg,zone,c,s)*QFZ0(reg,zone,c,s))/ExpendR0(reg,s);

 SSouthOmoshare(c,s)  = EXPENDZshare0('Southern','SouthOmo',c,s) ;

edfipart1(t,reg,zone,s) = sum(ag$QFZ0(reg,zone,ag,s),edfi0(t,reg,zone,ag,s)*EXPENDZshare0(reg,zone,ag,s));
edfipart2(t,reg,zone,s) = edfipart1(t,reg,zone,s) + edfi0(t,reg,zone,'nagtrade',s)*EXPENDZshare0(reg,zone,'nagtrade',s);
largedfipart1(t,reg,zone,s)$(edfipart1(t,reg,zone,s) ge 1) = edfipart1(t,reg,zone,s) ;
largedfipart2(t,reg,zone,s)$(edfipart2(t,reg,zone,s) ge 1) = edfipart2(t,reg,zone,s) ;

edfi0(t,reg,zone,'Nagntrade',s)$QFZpc0(reg,zone,'Nagntrade',s)   =
       (1 - edfipart2(t,reg,zone,s))/
*       (1 - sum(AG, edfi0(t,reg,zone,ag)*EXPENDZshare0(reg,zone,ag)) -
*         edfi0(t,reg,zone,'Nagtrade')*EXPENDZshare0(reg,zone,'nagtrade'))/
                        EXPENDZshare0(reg,zone,'nagntrade',s);

edfi0(t,reg,zone,lv,s)$(edfi0(t,reg,zone,'Nagntrade',s) lt 0.5) = 0.97*edfi0(t,reg,zone,lv,s) ;
edfi0(t,reg,zone,oilseed,s)$(edfi0(t,reg,zone,'Nagntrade',s) lt 0.5) = 0.97*edfi0(t,reg,zone,oilseed,s) ;
edfi0(t,reg,zone,'Nagtrade',s)$(edfi0(t,reg,zone,'Nagntrade',s) lt 0.5) = 0.97*edfi0(t,reg,zone,'Nagtrade',s) ;
edfi0(t,reg,zone,ag,s)$(edfi0(t,reg,zone,'Nagntrade',s) gt 1.8) = 1.1*edfi0(t,reg,zone,ag,s) ;
edfi0(t,reg,zone,'Nagtrade',s)$(edfi0(t,reg,zone,'Nagntrade',s) gt 1.8) = 1.1*edfi0(t,reg,zone,'Nagtrade',s) ;

edfipart1(t,reg,zone,s) =sum(ag$QFZ0(reg,zone,ag,s),edfi0(t,reg,zone,ag,s)*EXPENDZshare0(reg,zone,ag,s));
edfipart2(t,reg,zone,s) = edfipart1(t,reg,zone,s) + edfi0(t,reg,zone,'nagtrade',s)*EXPENDZshare0(reg,zone,'nagtrade',s);

edfi0(t,reg,zone,'Nagntrade',s)$QFZpc0(reg,zone,'Nagntrade',s)   =
       (1 - edfipart2(t,reg,zone,s))/
                        EXPENDZshare0(reg,zone,'nagntrade',s);

chkedfi(t,reg,zone,s) =sum(c,edfi0(t,reg,zone,c,s)*ExpendZshare0(reg,zone,c,s));
negedfi0(t,reg,zone,c,s)$(QFZpc0(reg,zone,c,s) and edfi0(t,reg,zone,c,s) lt 0) = yes;
negQFZ0('2015',reg,zone,c,s)$(ExpendZshare0(reg,zone,c,s) lt 0) = QFZ0(reg,zone,c,s) ;

edfiHpart1(reg,zone,urbrur,s) =sum(ag$QFZH0(reg,zone,urbrur,ag,s),edfiZH0(reg,zone,urbrur,ag,s)*EXPENDZHshare0(reg,zone,urbrur,ag,s));
edfiHpart2(reg,zone,urbrur,s) = edfiHpart1(reg,zone,urbrur,s) + edfiZH0(reg,zone,urbrur,'nagtrade',s)*EXPENDZHshare0(reg,zone,urbrur,'nagtrade',s);

edfiZH0(reg,zone,urbrur,'Nagntrade',s)$QFZHpc0(reg,zone,urbrur,'Nagntrade',s)   =
       (1 - edfiHpart2(reg,zone,urbrur,s))/
                        EXPENDZHshare0(reg,zone,urbrur,'nagntrade',s);

edfiZH0(reg,zone,urbrur,lv,s)$(edfiZH0(reg,zone,urbrur,'Nagntrade',s) lt 0.5) = 0.97*edfiZH0(reg,zone,urbrur,lv,s) ;
edfiZH0(reg,zone,urbrur,oilseed,s)$(edfiZH0(reg,zone,urbrur,'Nagntrade',s) lt 0.5) = 0.97*edfiZH0(reg,zone,urbrur,oilseed,s) ;
edfiZH0(reg,zone,urbrur,'Nagtrade',s)$(edfiZH0(reg,zone,urbrur,'Nagntrade',s) lt 0.5) = 0.97*edfiZH0(reg,zone,urbrur,'Nagtrade',s) ;
edfiZH0(reg,zone,urbrur,ag,s)$(edfiZH0(reg,zone,urbrur,'Nagntrade',s) gt 1.8) = 1.1*edfiZH0(reg,zone,urbrur,ag,s) ;
edfiZH0(reg,zone,urbrur,'Nagtrade',s)$(edfiZH0(reg,zone,urbrur,'Nagntrade',s) gt 1.8) = 1.1*edfiZH0(reg,zone,urbrur,'Nagtrade',s) ;

edfiHpart1(reg,zone,urbrur,s) =sum(ag$QFZH0(reg,zone,urbrur,ag,s),edfiZH0(reg,zone,urbrur,ag,s)*EXPENDZHshare0(reg,zone,urbrur,ag,s));
edfiHpart2(reg,zone,urbrur,s) = edfiHpart1(reg,zone,urbrur,s) + edfiZH0(reg,zone,urbrur,'nagtrade',s)*EXPENDZHshare0(reg,zone,urbrur,'nagtrade',s);

edfiZH0(reg,zone,urbrur,'Nagntrade',s)$QFZHpc0(reg,zone,urbrur,'Nagntrade',s)   =
       (1 - edfiHpart2(reg,zone,urbrur,s))/
                        EXPENDZHshare0(reg,zone,urbrur,'nagntrade',s);

chkedfiH(reg,zone,urbrur,s) =sum(c,edfiZH0(reg,zone,urbrur,c,s)*ExpendZHshare0(reg,zone,urbrur,c,s));
negedfiH0(reg,zone,urbrur,c,s)$(QFZHpc0(reg,zone,urbrur,c,s) and edfiZH0(reg,zone,urbrur,c,s) lt 0) = yes;
negQFZH0(reg,zone,urbrur,c,s)$(QFZH0(reg,zone,urbrur,c,s) lt 0) = QFZH0(reg,zone,urbrur,c,s) ;

QFZpc0(reg,zone,c,s)$QFZ0(reg,zone,c,s) = QFZ0(reg,zone,c,s)/sum(urbrur,PopH0(reg,zone,urbrur)) ;
QFZHpc0(reg,zone,urbrur,c,s)$QFZH0(reg,zone,urbrur,c,s) = QFZH0(reg,zone,urbrur,c,s)/PopH0(reg,zone,urbrur) ;

display negQFZ0, negQFZH0, SSouthOmoshare, expendzshare0, negedfi0, negedfiH0, chkedfi, chkedfiH, edfipart1, largedfipart1, largedfipart2;
display edfi0, edfiZH0;

*==== Demand side elasticity
parameter
chkownedfpH(reg,zone,urbrur,c,s)      own price elas
chkownedfp(t,reg,zone,c,s)            own price elas
;
edfp0(t,reg,zone,c,cp,s)$(QFZpc0(reg,zone,c,s)) = 0.01 ;
edfp0(t,reg,zone,c,cp,s)$(QFZpc0(reg,zone,c,s) and edfi0(t,reg,zone,c,s) le 0.1) = 0.0001 ;
edfp0(t,reg,zone,c,cp,s)$(QFZpc0(reg,zone,c,s) and edfi0(t,reg,zone,c,s) le 0.2) = 0.001 ;
edfp0(t,reg,zone,c,cp,s)$(QFZpc0(reg,zone,c,s) and edfi0(t,reg,zone,c,s) gt 1)   = 0.02 ;
edfp0(t,reg,zone,c,cp,s)$(QFZpc0(reg,zone,c,s) and edfi0(t,reg,zone,c,s) gt 1.5) = 0.04 ;
edfp0(t,reg,zone,cereal,cerealP,s)$(QFZpc0(reg,zone,cereal,s)) = 0.03 ;

edfp0(t,reg,zone,cereal,cerealP,s)$(QFZpc0(reg,zone,cereal,s) and edfi0(t,reg,zone,cereal,s) gt 1) = 0.01 ;

*edfp0(t,reg,zone,'maize','wheat')$(QFZpc0(reg,zone,'maize')) = 0.1 ;
*edfp0(t,reg,zone,'teff','wheat')$(QFZpc0(reg,zone,'teff')) = 0.1 ;
edfp0(t,reg,zone,'wheat','maize',s)$(QFZpc0(reg,zone,'wheat',s))   = 0.01 ;
edfp0(t,reg,zone,'wheat','teff',s)$(QFZpc0(reg,zone,'wheat',s))    = 0.01 ;
edfp0(t,reg,zone,'wheat','sorghum',s)$(QFZpc0(reg,zone,'wheat',s)) = 0.01 ;
edfp0(t,reg,zone,'wheat','enset',s)$(QFZpc0(reg,zone,'enset',s))   = 0.01 ;

edfp0(t,city,zone,cereal,cerealP,s)$QFZpc0(city,zone,cereal,s) = 0.01 ;

edfp0(t,reg,zone,cereal,cerealP,s)$(QFZpc0(reg,zone,cereal,s) and edfi0(t,reg,zone,cereal,s) le 0.1) = 0.00001 ;
edfp0(t,reg,zone,cereal,cerealP,s)$(QFZpc0(reg,zone,cereal,s) and edfi0(t,reg,zone,cereal,s) le 0.2) = 0.001 ;

edfp0(t,reg,zone,lv,lvp,s)$(QFZpc0(reg,zone,lv,s)) = 0.01 ;
edfp0(t,reg,zone,lv,lvp,s)$(QFZpc0(reg,zone,lv,s) and edfi0(t,reg,zone,lv,s) gt 1)   = 0.01 ;
edfp0(t,reg,zone,lv,lvp,s)$(QFZpc0(reg,zone,lv,s) and edfi0(t,reg,zone,lv,s) gt 1.5) = 0.01 ;
edfp0(t,reg,zone,cereal,lv,s) = 0 ;
edfp0(t,reg,zone,lv,cereal,s) = 0 ;
edfp0(t,reg,zone,C,C,s) = 0 ;
edfp0(t,reg,zone,C,C,s)$(QFZpc0(reg,zone,c,s)) =
             -(edfi0(t,reg,zone,c,s) + sum(cp,edfp0(t,reg,zone,c,cp,s)));

edfpH0(reg,zone,urbrur,c,cp,s)$(QFZHpc0(reg,zone,urbrur,c,s)) = 0.0 ;
edfpH0(reg,zone,urbrur,c,cp,s)$(QFZHpc0(reg,zone,urbrur,c,s) and edfiZH0(reg,zone,urbrur,c,s) le 0.2) = 0.0 ;
edfpH0(reg,zone,urbrur,c,cp,s)$(QFZHpc0(reg,zone,urbrur,c,s) and edfiZH0(reg,zone,urbrur,c,s) gt 1)   = 0.001 ;
edfpH0(reg,zone,urbrur,c,cp,s)$(QFZHpc0(reg,zone,urbrur,c,s) and edfiZH0(reg,zone,urbrur,c,s) gt 1.5) = 0.0015 ;

edfpH0(reg,zone,urbrur,'wheat','maize',s)$(QFZHpc0(reg,zone,urbrur,'wheat',s))   = 0.001 ;
edfpH0(reg,zone,urbrur,'wheat','teff',s)$(QFZHpc0(reg,zone,urbrur,'wheat',s))    = 0.001 ;
edfpH0(reg,zone,urbrur,'wheat','sorghum',s)$(QFZHpc0(reg,zone,urbrur,'wheat',s)) = 0.001 ;
edfpH0(reg,zone,urbrur,'wheat','enset',s)$(QFZHpc0(reg,zone,urbrur,'enset',s))   = 0.001 ;


edfpH0(reg,zone,'urb',C,CP,s)$(QFZHpc0(reg,zone,'urb',c,s) and edfiZH0(reg,zone,'urb',C,s) gt 1)   = 0.001 ;
edfpH0(reg,zone,'urb',C,CP,s)$(QFZHpc0(reg,zone,'urb',c,s) and edfiZH0(reg,zone,'urb',C,s) gt 1.5) = 0.0015 ;
edfpH0(reg,zone,'urb',cereal,cerealP,s)$(QFZHpc0(reg,zone,'urb',cereal,s)) = 0.001 ;

edfpH0(reg,zone,urbrur,cereal,cerealP,s)$(QFZHpc0(reg,zone,urbrur,cereal,s) and edfiZH0(reg,zone,urbrur,cereal,s) le 0.5) = 0.00001 ;

edfpH0(reg,zone,urbrur,lv,lvp,s)$(QFZHpc0(reg,zone,urbrur,lv,s)) = 0.0001 ;
edfpH0(reg,zone,urbrur,lv,lvp,s)$(QFZHpc0(reg,zone,urbrur,lv,s) and edfiZH0(reg,zone,urbrur,lv,s) gt 1)   = 0.001 ;
edfpH0(reg,zone,urbrur,lv,lvp,s)$(QFZHpc0(reg,zone,urbrur,lv,s) and edfiZH0(reg,zone,urbrur,lv,s) gt 1.5) = 0.001 ;
*edfpH0(reg,zone,urbrur,cereal,lv) = 0 ;
*edfpH0(reg,zone,urbrur,lv,cereal) = 0 ;
edfpH0(reg,zone,urbrur,'enset',roots,s)$(edfiZH0(reg,zone,urbrur,'enset',s)) = -edfiZH0(reg,zone,urbrur,'enset',s)/2 ;
*edfpH0(reg,zone,urbrur,smallcereal,CP) = 0.1*edfpH0(reg,zone,urbrur,smallcereal,CP) ;
edfpH0(reg,zone,urbrur,c,cp,s) = -edfpH0(reg,zone,urbrur,c,cp,s) ;

edfpH0(reg,zone,urbrur,C,C,s) = 0 ;
edfpH0(reg,zone,urbrur,C,C,s)$(QFZHpc0(reg,zone,urbrur,c,s)) =
             -(edfiZH0(reg,zone,urbrur,c,s) + sum(cp,edfpH0(reg,zone,urbrur,c,cp,s)));

chkownedfp(t,reg,zone,c,s) = edfp0(t,reg,zone,c,c,s) ;
chkownedfpH(reg,zone,urbrur,c,s) = edfpH0(reg,zone,urbrur,c,c,s) ;

parameter
posownedfp(reg,zone,c,s)            positive own price elas (should not be)
posownedfpH(reg,zone,urbrur,c,s)    positive own price elas (should not be)
;
posownedfp(reg,zone,c,s)$(chkownedfp('2015',reg,zone,c,s) ge 0) = chkownedfp('2015',reg,zone,c,s) ;
*posownedfpH(reg,zone,urbrur,c,s)$(chkownedfpH(reg,zone,urbrur,c,s) ge 0) = chkownedfpH(reg,zone,urbrur,c,s) ;

*display posownedfpH;

*chkownedfpH(reg,zone,urbrur,c,s) = sum(cp,edfpH0(reg,zone,urbrur,c,cp,s)) + edfiZH0(reg,zone,urbrur,c,s);
*display chkownedfph;

*====
*Calculate price elasticity according to S-G function
Parameter
alphaH(reg,zone,urbrur,c,s)
Gamma(reg,zone,urbrur,c,s)
chkaf0(reg,zone,c,s)             should be zero
chkafH0(reg,zone,urbrur,c,s)     should be zero
;

Gamma(reg,zone,urbrur,c,s)      = 0.001*QFZHpc0(reg,zone,urbrur,c,s) ;
Gamma(reg,zone,urbrur,ofood,s)  = 0.005*QFZHpc0(reg,zone,urbrur,ofood,s) ;
Gamma(reg,zone,'rur',cereal,s)  = 0.8*QFZHpc0(reg,zone,'rur',cereal,s) ;
Gamma(reg,zone,'urb',cereal,s)  = 0.2*QFZHpc0(reg,zone,'urb',cereal,s) ;
Gamma(reg,zone,'rur',ostaple,s) = 0.4*QFZHpc0(reg,zone,'rur',ostaple,s) ;
Gamma(reg,zone,'urb',ostaple,s) = 0.3*QFZHpc0(reg,zone,'urb',ostaple,s) ;
Gamma(reg,zone,'rur',lv,s)      = 0.2*QFZHpc0(reg,zone,'rur',lv,s) ;
Gamma(reg,zone,'urb',lv,s)      = 0.7*QFZHpc0(reg,zone,'urb',lv,s) ;

alphaH(reg,zone,urbrur,c,s) = edfiZH0(reg,zone,urbrur,c,s)*ExpendZHshare0(reg,zone,urbrur,c,s);
edfpH0(reg,zone,urbrur,c,cp,s)$(QFZHpc0(reg,zone,urbrur,c,s) and QFZHpc0(reg,zone,urbrur,cp,s)) =
           - alphaH(reg,zone,urbrur,c,s)*(PCZ0(reg,zone,cp,s)*
             Gamma(reg,zone,urbrur,cp,s))/(PCZ0(reg,zone,c,s)*QFZHpc0(reg,zone,urbrur,c,s)) ;

edfpH0(reg,zone,urbrur,c,c,s) = 0 ;
*edfpH0(reg,zone,urbrur,c,cp,s) = 0 ;
edfpH0(reg,zone,urbrur,c,c,s)$QFZHpc0(reg,zone,urbrur,c,s) =
           - (edfiZH0(reg,zone,urbrur,c,s) + sum(cp, edfpH0(reg,zone,urbrur,c,cp,s))) ;


chkownedfpH(reg,zone,urbrur,c,s) = edfpH0(reg,zone,urbrur,c,c,s) ;
posownedfpH(reg,zone,urbrur,c,s)$(chkownedfpH(reg,zone,urbrur,c,s) ge 0) = chkownedfpH(reg,zone,urbrur,c,s) ;

display posownedfpH, chkownedfph;

chkownedfpH(reg,zone,urbrur,c,s) = sum(cp,edfpH0(reg,zone,urbrur,c,cp,s)) + edfiZH0(reg,zone,urbrur,c,s);
display chkownedfph, edfph0;


*Interception of food demand funciton
af0(t,reg,zone,c,s)$QFZ0(reg,zone,c,s)
         = QFZpc0(reg,zone,c,s)/(PROD(CP$QFZ0(reg,zone,cp,s),PCZ0(reg,zone,cp,s)**edfp0(t,reg,zone,c,cp,s)) *
           GDPZpc0(reg,zone,s)**edfi0(t,reg,zone,c,s));

* assign value to variable
af(reg,zone,c,s)$af0('2015',reg,zone,c,s)            = af0('2015',reg,zone,c,s) ;
edfi(reg,zone,c,s)$edfi0('2015',reg,zone,C,s)        = edfi0('2015',reg,zone,c,s) ;
edfp(reg,zone,c,cp,s)$edfp0('2015',reg,zone,c,cp,s)  = edfp0('2015',reg,zone,c,cp,s) ;
chkaf0(reg,zone,c,s)$QFZ0(reg,zone,c,s)
         = QFZpc0(reg,zone,c,s) - af(reg,zone,c,s)*(PROD(CP$QFZ0(reg,zone,cp,s),PCZ0(reg,zone,cp,s)**edfp(reg,zone,c,cp,s)) *
           GDPZpc0(reg,zone,s)**edfi(reg,zone,c,s)) ;
afH0(reg,zone,urbrur,c,s)$QFZH0(reg,zone,urbrur,c,s)
         = QFZHpc0(reg,zone,urbrur,c,s)/(PROD(CP$QFZH0(reg,zone,urbrur,cp,s),PCZ0(reg,zone,cp,s)**edfpH0(reg,zone,urbrur,c,cp,s)) *
           GDPZHpc0(reg,zone,urbrur,s)**edfiZH0(reg,zone,urbrur,c,s));
afH(reg,zone,urbrur,c,s)$afH0(reg,zone,urbrur,c,s)           = afH0(reg,zone,urbrur,c,s) ;
edfiZH(reg,zone,urbrur,c,s)$edfiZH0(reg,zone,urbrur,c,s)     = edfiZH0(reg,zone,urbrur,c,s) ;
edfpH(reg,zone,urbrur,c,cp,s)$edfpH0(reg,zone,urbrur,c,cp,s) = edfpH0(reg,zone,urbrur,c,cp,s) ;
chkafH0(reg,zone,urbrur,c,s)$QFZH0(reg,zone,urbrur,c,s)
         = QFZHpc0(reg,zone,urbrur,c,s) - afH(reg,zone,urbrur,c,s)*(PROD(CP$QFZH0(reg,zone,urbrur,cp,s),PCZ0(reg,zone,cp,s)**edfpH(reg,zone,urbrur,c,cp,s)) *
           GDPZHpc0(reg,zone,urbrur,s)**edfiZH(reg,zone,urbrur,c,s)) ;

display chkownedfp, chkownedfpH, chkaf0, chkafH0, af0, afH0 ;


* ============== ying 6 ====================
* ==== Input: CYF
parameter
maxKc_Mean(reg,zone,s)      This is the maximum KcMean (CYF) of all the cereals (by zone)
;

maxKc_Mean(reg,zone,s)
         = max(Kc_Mean(s,reg,zone,'maize'),Kc_Mean(s,reg,zone,'wheat'),Kc_Mean(s,reg,zone,'millet'),Kc_Mean(s,reg,zone,'teff'),Kc_Mean(s,reg,zone,'sorghum'));

* ying6 add $QSZ
KcMean0(reg,zone,c,s)$QSZ0(reg,zone,c,s) = 1 ;
KcMean0(reg,zone,raincrop,s)           = Kc_Mean(s,reg,zone,raincrop) ;
KcMean0(reg,zone,'Barley',s)           = Kc_Mean(s,reg,zone,'Sorghum') ;
* use 100-yr avg kcmean input file (original)
*KcMean0(reg,zone,cash)               = maxKc_Mean(reg,zone,s) ;
* use 2015 kcmean input file
KcMean0(reg,zone,cash,s)               = Kc_Mean(s,reg,zone,'Enset');
* ========= ying5 ==========
*JL: reinstate this from Ying because of problems dividing by zero in some years?
*KcMean0(reg,zone,c,s)$(KcMean0(reg,zone,c,s) eq 0) = 0.001 ;
* ===========
*$exit;
display
maxKc_Mean, Kc_Mean, KcMean0;
* ===========================================

*==== Technology Input (irri, improved seed, persticide, fertilizer)
*Bring in disaggregate data of output and area according to input use
* JL: old model lacked SWP data. Adding it here and below.
parameter
ZeroQSZ_input0(reg,zone,c,type,s)       supply>0 but area =0 (should not happen)
ZeroACZ_input0(reg,zone,c,type,s)       area >0 but supply =0 (usually should not happen except yield =0)
;

AAGG(s,reg,zone,CropInput)$QSZ0(reg,zone,CropInput,s) =
                   ANON(s,reg,zone,CropInput) + AALL(s,reg,zone,CropInput) + AFSW(s,reg,zone,CropInput) + AFSP(s,reg,zone,CropInput) + AFWP(s,reg,zone,CropInput) + ASWP(s,reg,zone,CropInput)
                 + AF_S(s,reg,zone,CropInput) + AF_W(s,reg,zone,CropInput) + AF_P(s,reg,zone,CropInput) + AS_W(s,reg,zone,CropInput) + AS_P(s,reg,zone,CropInput)
                 + AP_W(s,reg,zone,CropInput) + A_F(s,reg,zone,CropInput) + A_S(s,reg,zone,CropInput) + A_W(s,reg,zone,CropInput) + A_P(s,reg,zone,CropInput) ;

PAGG(s,reg,zone,CropInput)$QSZ0(reg,zone,CropInput,s) =
                   PNON(s,reg,zone,CropInput) + PALL(s,reg,zone,CropInput) + PFSW(s,reg,zone,CropInput) + PFSP(s,reg,zone,CropInput) + PFWP(s,reg,zone,CropInput) + PSWP(s,reg,zone,CropInput)
                 + PF_S(s,reg,zone,CropInput) + PF_W(s,reg,zone,CropInput) + PF_P(s,reg,zone,CropInput) + PS_W(s,reg,zone,CropInput) + PS_P(s,reg,zone,CropInput)
                 + PP_W(s,reg,zone,CropInput) + P_F(s,reg,zone,CropInput) + P_S(s,reg,zone,CropInput) + P_W(s,reg,zone,CropInput) + P_P(s,reg,zone,CropInput) ;

display QSZ0;
*$exit;

 ACZ_inputsh0(reg,zone,CropInput,'none',s)$AAGG(s,reg,zone,CropInput) = ANON(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'sfip',s)$AAGG(s,reg,zone,CropInput) = AALL(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'seed',s)$AAGG(s,reg,zone,CropInput) = A_S(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'fert',s)$AAGG(s,reg,zone,CropInput) = A_F(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'irri',s)$AAGG(s,reg,zone,CropInput) = A_W(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'pest',s)$AAGG(s,reg,zone,CropInput) = A_P(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'s_f',s)$AAGG(s,reg,zone,CropInput)  = AF_S(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'s_i',s)$AAGG(s,reg,zone,CropInput)  = AS_W(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'s_p',s)$AAGG(s,reg,zone,CropInput)  = AS_P(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'f_i',s)$AAGG(s,reg,zone,CropInput)  = AF_W(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'f_p',s)$AAGG(s,reg,zone,CropInput)  = AF_P(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'i_p',s)$AAGG(s,reg,zone,CropInput)  = AP_W(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'s_fp',s)$AAGG(s,reg,zone,CropInput) = AFSP(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'s_fi',s)$AAGG(s,reg,zone,CropInput) = AFSW(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'f_ip',s)$AAGG(s,reg,zone,CropInput) = AFWP(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;
 ACZ_inputsh0(reg,zone,CropInput,'s_ip',s)$AAGG(s,reg,zone,CropInput) = ASWP(s,reg,zone,CropInput)/AAGG(s,reg,zone,CropInput) ;

 QSZ_inputsh0(reg,zone,CropInput,'none',s)$PAGG(s,reg,zone,CropInput) = PNON(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'sfip',s)$PAGG(s,reg,zone,CropInput) = PALL(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'seed',s)$PAGG(s,reg,zone,CropInput) = P_S(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'fert',s)$PAGG(s,reg,zone,CropInput) = P_F(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'irri',s)$PAGG(s,reg,zone,CropInput) = P_W(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'pest',s)$PAGG(s,reg,zone,CropInput) = P_P(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'s_f',s)$PAGG(s,reg,zone,CropInput)  = PF_S(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'s_i',s)$PAGG(s,reg,zone,CropInput)  = PS_W(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'s_p',s)$PAGG(s,reg,zone,CropInput)  = PS_P(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'f_i',s)$PAGG(s,reg,zone,CropInput)  = PF_W(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'f_p',s)$PAGG(s,reg,zone,CropInput)  = PF_P(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'i_p',s)$PAGG(s,reg,zone,CropInput)  = PP_W(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'s_fp',s)$PAGG(s,reg,zone,CropInput) = PFSP(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'s_fi',s)$PAGG(s,reg,zone,CropInput) = PFSW(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'f_ip',s)$PAGG(s,reg,zone,CropInput) = PFWP(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;
 QSZ_inputsh0(reg,zone,CropInput,'s_ip',s)$PAGG(s,reg,zone,CropInput) = PSWP(s,reg,zone,CropInput)/PAGG(s,reg,zone,CropInput) ;

 ACZ_input0(reg,zone,CropInput,'none',s)$AAGG(s,reg,zone,CropInput)   = ACZ_inputsh0(reg,zone,CropInput,'none',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'sfip',s)$AAGG(s,reg,zone,CropInput)   = ACZ_inputsh0(reg,zone,CropInput,'sfip',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'seed',s)$AAGG(s,reg,zone,CropInput)   = ACZ_inputsh0(reg,zone,CropInput,'seed',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'fert',s)$AAGG(s,reg,zone,CropInput)   = ACZ_inputsh0(reg,zone,CropInput,'fert',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'irri',s)$AAGG(s,reg,zone,CropInput)   = ACZ_inputsh0(reg,zone,CropInput,'irri',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'pest',s)$AAGG(s,reg,zone,CropInput)   = ACZ_inputsh0(reg,zone,CropInput,'pest',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'s_f',s)$AAGG(s,reg,zone,CropInput)    = ACZ_inputsh0(reg,zone,CropInput,'s_f',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'s_i',s)$AAGG(s,reg,zone,CropInput)    = ACZ_inputsh0(reg,zone,CropInput,'s_i',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'s_p',s)$AAGG(s,reg,zone,CropInput)    = ACZ_inputsh0(reg,zone,CropInput,'s_p',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'f_i',s)$AAGG(s,reg,zone,CropInput)    = ACZ_inputsh0(reg,zone,CropInput,'f_i',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'f_p',s)$AAGG(s,reg,zone,CropInput)    = ACZ_inputsh0(reg,zone,CropInput,'f_p',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'i_p',s)$AAGG(s,reg,zone,CropInput)    = ACZ_inputsh0(reg,zone,CropInput,'i_p',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'s_fp',s)$AAGG(s,reg,zone,CropInput)   = ACZ_inputsh0(reg,zone,CropInput,'s_fp',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'s_fi',s)$AAGG(s,reg,zone,CropInput)   = ACZ_inputsh0(reg,zone,CropInput,'s_fi',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'f_ip',s)$AAGG(s,reg,zone,CropInput)   = ACZ_inputsh0(reg,zone,CropInput,'f_ip',s)*ACZ0(reg,zone,CropInput,s) ;
 ACZ_input0(reg,zone,CropInput,'s_ip',s)$AAGG(s,reg,zone,CropInput)   = ACZ_inputsh0(reg,zone,CropInput,'s_ip',s)*ACZ0(reg,zone,CropInput,s) ;

 QSZ_input0(reg,zone,CropInput,'none',s)$PAGG(s,reg,zone,CropInput)   = QSZ_inputsh0(reg,zone,CropInput,'none',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'sfip',s)$PAGG(s,reg,zone,CropInput)   = QSZ_inputsh0(reg,zone,CropInput,'sfip',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'seed',s)$PAGG(s,reg,zone,CropInput)   = QSZ_inputsh0(reg,zone,CropInput,'seed',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'fert',s)$PAGG(s,reg,zone,CropInput)   = QSZ_inputsh0(reg,zone,CropInput,'fert',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'irri',s)$PAGG(s,reg,zone,CropInput)   = QSZ_inputsh0(reg,zone,CropInput,'irri',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'pest',s)$PAGG(s,reg,zone,CropInput)   = QSZ_inputsh0(reg,zone,CropInput,'pest',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'s_f',s)$PAGG(s,reg,zone,CropInput)    = QSZ_inputsh0(reg,zone,CropInput,'s_f',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'s_i',s)$PAGG(s,reg,zone,CropInput)    = QSZ_inputsh0(reg,zone,CropInput,'s_i',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'s_p',s)$PAGG(s,reg,zone,CropInput)    = QSZ_inputsh0(reg,zone,CropInput,'s_p',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'f_i',s)$PAGG(s,reg,zone,CropInput)    = QSZ_inputsh0(reg,zone,CropInput,'f_i',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'f_p',s)$PAGG(s,reg,zone,CropInput)    = QSZ_inputsh0(reg,zone,CropInput,'f_p',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'i_p',s)$PAGG(s,reg,zone,CropInput)    = QSZ_inputsh0(reg,zone,CropInput,'i_p',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'s_fp',s)$PAGG(s,reg,zone,CropInput)   = QSZ_inputsh0(reg,zone,CropInput,'s_fp',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'s_fi',s)$PAGG(s,reg,zone,CropInput)   = QSZ_inputsh0(reg,zone,CropInput,'s_fi',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'f_ip',s)$PAGG(s,reg,zone,CropInput)   = QSZ_inputsh0(reg,zone,CropInput,'f_ip',s)*QSZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'s_ip',s)$PAGG(s,reg,zone,CropInput)   = QSZ_inputsh0(reg,zone,CropInput,'s_ip',s)*QSZ0(reg,zone,CropInput,s) ;

 ACZ_input0(reg,zone,CropInput,'none',s)$(ACZ0(reg,zone,CropInput,s) and QSZ0(reg,zone,CropInput,s) and AAGG(s,reg,zone,CropInput) eq 0) = ACZ0(reg,zone,CropInput,s) ;
 QSZ_input0(reg,zone,CropInput,'none',s)$(ACZ0(reg,zone,CropInput,s) and QSZ0(reg,zone,CropInput,s) and PAGG(s,reg,zone,CropInput) eq 0) = QSZ0(reg,zone,CropInput,s) ;
 display QSZ_input0;



$ontext
************** JL: major change to model--seasonal shift of supply due to storage or continuous harvest **************
************** JL: no need to do this now since we use QSZ0 and ACZ0 in calculations above *****************
QSZ_input0_old(reg,zone,c,type,s) = QSZ_input0(reg,zone,c,type,s) ;
PAGG_old(s,reg,zone,CropInput) = PAGG(s,reg,zone,CropInput) ;

QSZ_input0(reg,zone,'Teff',type,'Meher') = 0.77*QSZ_input0(reg,zone,'Teff',type,'Meher') + (1-0.77)*QSZ_input0(reg,zone,'Teff',type,'Belg') ;
QSZ_input0(reg,zone,'Barley',type,'Meher') = 0.79*QSZ_input0(reg,zone,'Barley',type,'Meher') + (1-0.79)*QSZ_input0(reg,zone,'Barley',type,'Belg') ;
QSZ_input0(reg,zone,'Wheat',type,'Meher') = 0.76*QSZ_input0(reg,zone,'Wheat',type,'Meher') + (1-0.76)*QSZ_input0(reg,zone,'Wheat',type,'Belg') ;
QSZ_input0(reg,zone,'Maize',type,'Meher') = 0.68*QSZ_input0(reg,zone,'Maize',type,'Meher') + (1-0.68)*QSZ_input0(reg,zone,'Maize',type,'Belg') ;
QSZ_input0(reg,zone,'Sorghum',type,'Meher') = 0.83*QSZ_input0(reg,zone,'Sorghum',type,'Meher') + (1-0.83)*QSZ_input0(reg,zone,'Sorghum',type,'Belg') ;
QSZ_input0(reg,zone,'Millet',type,'Meher') = 0.75*QSZ_input0(reg,zone,'Millet',type,'Meher') + (1-0.75)*QSZ_input0(reg,zone,'Millet',type,'Belg') ;
QSZ_input0(reg,zone,'Oats',type,'Meher') = 0.75*QSZ_input0(reg,zone,'Oats',type,'Meher') + (1-0.75)*QSZ_input0(reg,zone,'Oats',type,'Belg') ;
QSZ_input0(reg,zone,'Rice',type,'Meher') = 0.75*QSZ_input0(reg,zone,'Rice',type,'Meher') + (1-0.75)*QSZ_input0(reg,zone,'Rice',type,'Belg') ;
QSZ_input0(reg,zone,pulse,type,'Meher') = 0.69*QSZ_input0(reg,zone,pulse,type,'Meher') + (1-0.69)*QSZ_input0(reg,zone,pulse,type,'Belg') ;
QSZ_input0(reg,zone,oilseed,type,'Meher') = 0.79*QSZ_input0(reg,zone,oilseed,type,'Meher') + (1-0.79)*QSZ_input0(reg,zone,oilseed,type,'Belg') ;
QSZ_input0(reg,zone,'Rapeseed',type,'Meher') = (0.55/0.79)*QSZ_input0(reg,zone,'Rapeseed',type,'Meher') ;
QSZ_input0(reg,zone,LV,type,'Meher') = 0.553*QSZ_input0(reg,zone,LV,type,'Meher') + (1-0.553)*QSZ_input0(reg,zone,LV,type,'Belg') ;
QSZ_input0(reg,zone,'Stimulants',type,'Meher') = 0.572*QSZ_input0(reg,zone,'Stimulants',type,'Meher') + (1-0.572)*QSZ_input0(reg,zone,'Stimulants',type,'Belg') ;
QSZ_input0(reg,zone,'Coffee',type,'Meher') = 0.572*QSZ_input0(reg,zone,'Coffee',type,'Meher') + (1-0.572)*QSZ_input0(reg,zone,'Coffee',type,'Belg') ;
QSZ_input0(reg,zone,'Enset',type,'Meher') = 0.583*QSZ_input0(reg,zone,'Enset',type,'Meher') + (1-0.583)*QSZ_input0(reg,zone,'Enset',type,'Belg') ;
*QSZ_input0(reg,zone,'SugarRawEquivalent',type,'Meher') = 0.583*QSZ_input0(reg,zone,'SugarRawEquivalent',type,'Meher') + (1-0.583)*QSZ_input0(reg,zone,'SugarRawEquivalent',type,'Belg') ;
QSZ_input0(reg,zone,'Bananas',type,'Meher') = 0.583*QSZ_input0(reg,zone,'Bananas',type,'Meher') + (1-0.583)*QSZ_input0(reg,zone,'Bananas',type,'Belg') ;

QSZ_input0(reg,zone,c,type,'Belg') = QSZ_input0(reg,zone,c,type,'Annual') - QSZ_input0(reg,zone,c,type,'Meher') ;

QSZ_input0(reg,zone,c,type,s)$(QSZ_input0(reg,zone,c,type,s) lt 0) = 0 ;

PAGG(s,reg,zone,CropInput) = sum(type,QSZ_input0(reg,zone,CropInput,type,s)) ;
************************************************************************************************************
$offtext


* ===== ying 6 - when kcmean =0, QSZ for non-water-type technology should be zero too =====
 parameter
 chkconsQSZ(reg,zone,CropInput,s)     check whether sum of QSZ_input still equals to QSZ (should be zero)
 chkconsQSZ2(reg,zone,c,s)            check whether sum of QSZ_input still equals to QSZ (should be zero)
;
* QSZ_input0_old(reg,zone,CropInput,nwtype,s)$(PAGG_old(s,reg,zone,CropInput) and QSZ0_old(reg,zone,CropInput,s) and kcmean0(reg,zone,CropInput,s) eq 0) = 0;
* QSZ_input0_old(reg,zone,CropInput,wtype,s)$(PAGG(s,reg,zone,CropInput) and QSZ0_old(reg,zone,CropInput,s) and kcmean0(reg,zone,CropInput,s) eq 0)
*         = QSZ_input0(reg,zone,CropInput,wtype,s)* QSZ0_old(reg,zone,CropInput,s) / sum( type,QSZ_input0(reg,zone,CropInput,type,s) );

* chkconsQSZ(reg,zone,CropInput,s) = QSZ0_old(reg,zone,CropInput,s) - sum( type,QSZ_input0_old(reg,zone,CropInput,type,s) ) ;
 QSZ_input0(reg,zone,CropInput,nwtype,s)$(PAGG(s,reg,zone,CropInput) and QSZ0(reg,zone,CropInput,s) and kcmean0(reg,zone,CropInput,s) eq 0) = 0;
 QSZ_input0(reg,zone,CropInput,wtype,s)$(PAGG(s,reg,zone,CropInput) and QSZ0(reg,zone,CropInput,s) and kcmean0(reg,zone,CropInput,s) eq 0)
         = QSZ_input0(reg,zone,CropInput,wtype,s)* QSZ0(reg,zone,CropInput,s) / sum( type,QSZ_input0(reg,zone,CropInput,type,s) );

 chkconsQSZ(reg,zone,CropInput,s) = QSZ0(reg,zone,CropInput,s) - sum( type,QSZ_input0(reg,zone,CropInput,type,s) ) ;
 display chkconsQSZ, QSZ_input0,QSZ_input0;
*$exit;

* =============
 ACZ_input0(reg,zone,CropNone,type,s) = 0 ;
 QSZ_input0(reg,zone,CropNone,type,s) = 0 ;

 ACZ_input0(reg,zone,CropNone,'none',s)$(ACZ0(reg,zone,CropNone,s) and QSZ0(reg,zone,CropNone,s)) = ACZ0(reg,zone,CropNone,s) ;
* QSZ_input0_old(reg,zone,CropNone,'none',s)$(ACZ0(reg,zone,CropNone,s) and QSZ0_old(reg,zone,CropNone,s)) = QSZ0_old(reg,zone,CropNone,s) ;
 QSZ_input0(reg,zone,CropNone,'none',s)$(ACZ0(reg,zone,CropNone,s) and QSZ0(reg,zone,CropNone,s)) = QSZ0(reg,zone,CropNone,s) ;

* chkconsQSZ2(reg,zone,c,s)$(QSZ0_old(reg,zone,c,s) and ACZ0(reg,zone,c,s)) = QSZ0_old(reg,zone,c,s) - sum( type,QSZ_input0_old(reg,zone,c,type,s) ) ;
 chkconsQSZ2(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s)) = QSZ0(reg,zone,c,s) - sum( type,QSZ_input0(reg,zone,c,type,s) ) ;
 display chkconsQSZ2;

 ZeroACZ_input0(reg,zone,Crop,type,s)$(ACZ_input0(reg,zone,crop,type,s) and QSZ_input0(reg,zone,crop,type,s) eq 0) =
                     ACZ_input0(reg,zone,crop,type,s) ;
 ZeroQSZ_input0(reg,zone,Crop,type,s)$(ACZ_input0(reg,zone,crop,type,s) eq 0 and QSZ_input0(reg,zone,crop,type,s)) =
                     QSZ_input0(reg,zone,crop,type,s) ;

 YCZ_input0(reg,zone,crop,type,s)$ACZ_input0(reg,zone,crop,type,s) = 1000*QSZ_input0(reg,zone,crop,type,s)/ACZ_input0(reg,zone,crop,type,s);
* YCZ_input0(reg,zone,crop,type,s)$ACZ_input0(reg,zone,crop,type,s) = 1000*QSZ_input0_old(reg,zone,crop,type,s)/ACZ_input0(reg,zone,crop,type,s);

 RACZ_input0(reg,crop,type,s) = sum(zone,ACZ_input0(reg,zone,crop,type,s)) ;
 RQSZ_input0(reg,crop,type,s) = sum(zone,QSZ_input0(reg,zone,crop,type,s)) ;
* RQSZ_input0_old(reg,crop,type,s) = sum(zone,QSZ_input0_old(reg,zone,crop,type,s)) ;
 RYCZ_input0(reg,c,type,s)$RACZ_input0(reg,c,type,s) = 1000*RQSZ_input0(reg,c,type,s)/RACZ_input0(reg,c,type,s);
* RYCZ_input0(reg,c,type,s)$RACZ_input0(reg,c,type,s) = 1000*RQSZ_input0_old(reg,c,type,s)/RACZ_input0(reg,c,type,s);

 TACZ_input0(crop,type,s) = sum((reg,zone),ACZ_input0(reg,zone,crop,type,s)) ;
 TQSZ_input0(crop,type,s) = sum((reg,zone),QSZ_input0(reg,zone,crop,type,s)) ;
* TQSZ_input0_old(crop,type,s) = sum((reg,zone),QSZ_input0_old(reg,zone,crop,type,s)) ;
 TYCZ_input0(c,type,s)$TACZ_input0(c,type,s) = 1000*TQSZ_input0(c,type,s)/TACZ_input0(c,type,s) ;
* TYCZ_input0(c,type,s)$TACZ_input0(c,type,s) = 1000*TQSZ_input0_old(c,type,s)/TACZ_input0(c,type,s) ;

 display zeroACZ_input0, zeroQSZ_input0 ;

 parameter
 chkACZ_input(reg,zone,c,s)        agg ACZ_input minus ACZ (should be zero)
 chkQSZ_input(reg,zone,c,s)        agg QSZ_input minus QSZ (should be zero)
 chkYCZ_input(reg,zone,c,type,s)   ratio of YCZ with input over YCZ without any input
 chkTYCZ_input(c,type,s)           ratio of TYCZ with input over TYCZ without any input
 chkRYCZ_input(reg,c,type,s)       ratio of RYCZ with input over RYCZ without any input
 AdjYCZ_input0(reg,zone,c,type,s)  adjust YCZ
 AdjACZ_input0(reg,zone,c,type,s)  adjust ACZ
 AdjQSZ_input0(reg,zone,c,type,s)  adjust QSZ
 AdjQSZ_input0_old(reg,zone,c,type,s)  Placeholder for AdjQSZ_input0 once supply is shifted
 negQSZ_none(reg,zone,c,s)         AdjQSZ_input0 < 0 when there is no inputs (should not occur)
 chkYCZ_input0(reg,zone,c,type,s)  AdjYCZ_input0 > 0 and AdjYCZ_input0 with input < AdjYCZ_input0 without input (should not)
 ;

 chkACZ_input(reg,zone,crop,s) = sum(type,ACZ_input0(reg,zone,crop,type,s)) - ACZ0(reg,zone,crop,s) ;
* chkQSZ_input(reg,zone,crop,s) = sum(type,QSZ_input0(reg,zone,crop,type,s)) - QSZ0_old(reg,zone,crop,s) ;
 chkQSZ_input(reg,zone,crop,s) = sum(type,QSZ_input0(reg,zone,crop,type,s)) - QSZ0(reg,zone,crop,s) ;

 chkYCZ_input(reg,zone,crop,inptype,s)$YCZ_input0(reg,zone,crop,'none',s) = YCZ_input0(reg,zone,crop,inptype,s)/YCZ_input0(reg,zone,crop,'none',s) ;
 chkRYCZ_input(reg,crop,inptype,s)$RYCZ_input0(reg,crop,'none',s)         = RYCZ_input0(reg,crop,inptype,s)/RYCZ_input0(reg,crop,'none',s) ;
 chkTYCZ_input(crop,inptype,s)$TYCZ_input0(crop,'none',s)                 = TYCZ_input0(crop,inptype,s)/TYCZ_input0(crop,'none',s) ;

 display zeroACZ_input0, zeroQSZ_input0, chkACZ_input,  chkQSZ_input, chkTYCZ_input, chkRYCZ_input, TYCZ_input0, RYCZ_input0, YCZ_input0 ;

*=========
 AdjYCZ_input0(reg,zone,Crop,type,s) = YCZ_input0(reg,zone,Crop,type,s) ;

 AdjYCZ_input0(reg,zone,CropInput,inptype,s)$(ACZ_input0(reg,zone,CropInput,inptype,s) and ACZ_input0(reg,zone,CropInput,'none',s) and
            YCZ_input0(reg,zone,CropInput,inptype,s) lt 1.02*YCZ_input0(reg,zone,CropInput,'none',s)) =
                                  1.02*YCZ_input0(reg,zone,CropInput,'none',s) ;

$ontext
 AdjYCZ_input0('southern','Gurage','wheat',inptype,s)$(ACZ_input0('southern','Gurage','wheat',inptype,s) and
            YCZ_input0('southern','Gurage','wheat',inptype,s) lt 1.01*YCZ_input0('southern','Gurage','wheat','none',s)) =
                                  1.01*YCZ_input0('southern','Gurage','wheat','none',s) ;
 AdjYCZ_input0('southern',zone,'sorghum',inptype,s)$(ACZ_input0('southern',zone,'sorghum',inptype,s) and
            YCZ_input0('southern',zone,'sorghum',inptype,s) lt 1.03*YCZ_input0('southern',zone,'sorghum','none',s)) =
                                  1.03*YCZ_input0('southern',zone,'sorghum','none',s) ;
 AdjYCZ_input0('southern',zone,'barley',inptype,s)$(ACZ_input0('southern',zone,'barley',inptype,s) and
            YCZ_input0('southern',zone,'barley',inptype,s) lt 1.03*YCZ_input0('southern',zone,'barley','none',s)) =
                                  1.03*YCZ_input0('southern',zone,'barley','none',s) ;
 AdjYCZ_input0('Oromia',zone,'Millet',inptype,s)$(ACZ_input0('Oromia',zone,'Millet',inptype,s) and
            YCZ_input0('Oromia',zone,'Millet',inptype,s) lt 1.03*YCZ_input0('Oromia',zone,'Millet','none',s)) =
                                  1.03*YCZ_input0('Oromia',zone,'Millet','none',s) ;

 AdjYCZ_input0(reg,zone,CropInput,inptype,s)$(ACZ_input0(reg,zone,CropInput,inptype,s) and
            YCZ_input0(reg,zone,CropInput,inptype,s) ge 1.02*YCZ_input0(reg,zone,CropInput,'none',s)) =
                                  YCZ_input0(reg,zone,CropInput,inptype,s) ;

 AdjYCZ_input0('southern','Gurage','wheat',inptype,s)$(ACZ_input0('southern','Gurage','wheat',inptype,s) and
            YCZ_input0('southern','Gurage','wheat',inptype,s) ge 1.01*YCZ_input0('southern','Gurage','wheat','none',s)) =
                                  YCZ_input0('southern','Gurage','wheat',inptype,s) ;
 AdjYCZ_input0('southern',zone,'sorghum',inptype,s)$(ACZ_input0('southern',zone,'sorghum',inptype,s) and
            YCZ_input0('southern',zone,'sorghum',inptype,s) ge 1.03*YCZ_input0('southern',zone,'sorghum','none',s)) =
                                  YCZ_input0('southern',zone,'sorghum',inptype,s) ;
 AdjYCZ_input0('southern',zone,'barley',inptype,s)$(ACZ_input0('southern',zone,'barley',inptype,s) and
            YCZ_input0('southern',zone,'barley',inptype,s) ge 1.03*YCZ_input0('southern',zone,'barley','none',s)) =
                                  YCZ_input0('southern',zone,'barley',inptype,s) ;
 AdjYCZ_input0('Oromia',zone,'Millet',inptype,s)$(ACZ_input0('Oromia',zone,'Millet',inptype,s) and
            YCZ_input0('Oromia',zone,'Millet',inptype,s) ge 1.03*YCZ_input0('Oromia',zone,'Millet','none',s)) =
                                  YCZ_input0('Oromia',zone,'Millet',inptype,s) ;
$offtext
*==== Input: irrigation area (old and new for calc irrigation growth rate)
parameter
ACZirr00(reg,zone,c,s)     intermediate param to adjust irr area
TACZirr00(reg,zone,s)      intermediate param to adjust irr area
;

ACZirr00(reg,zone,c,s)$(ACZ0(reg,zone,c,s) eq 0 and ACZirr0(s,reg,zone,c)) = ACZirr0(s,reg,zone,c) ;
TACZirr00(reg,zone,s) = sum(c,ACZirr00(reg,zone,c,s)) ;

ACZirr0(s,reg,zone,c)$(ACZ0(reg,zone,c,s) and ACZirr0(s,reg,zone,c))
                    = ACZirr0(s,reg,zone,c) + ACZirr0(s,reg,zone,c)/sum(cp,ACZirr0(s,reg,zone,cp))*TACZirr00(reg,zone,s) ;

ACZirr0(s,reg,zone,c)$(ACZ0(reg,zone,c,s) eq 0) = 0 ;

display TACZirr00, ACZirr00;

* adjusting irrigation area data
irrinACZ0(reg,zone,c,s)$ACZ0(reg,zone,c,s)                                            = 100*ACZirr0(s,reg,zone,c)/ACZ0(reg,zone,c,s) ;
irrinACZ0(reg,zone,c,s)$(irrinACZ0(reg,zone,c,s) ge 90)                               = 0.5*irrinACZ0(reg,zone,c,s) ;
irrinACZ0(reg,zone,c,s)$(irrinACZ0(reg,zone,c,s) ge 50)                               = 50 ;
irrinACZ0(reg,zone,c,s)$(irrinACZ0(reg,zone,c,s) gt 0 and irrinACZ0(reg,zone,c,s) le 1) = 5*irrinACZ0(reg,zone,c,s) ;
irrinACZ0(reg,zone,c,s)$(irrinACZ0(reg,zone,c,s) gt 0 and irrinACZ0(reg,zone,c,s) le 1) = 5*irrinACZ0(reg,zone,c,s) ;
irrinACZ0(reg,zone,c,s)$(irrinACZ0(reg,zone,c,s) gt 0 and irrinACZ0(reg,zone,c,s) le 1) = 5*irrinACZ0(reg,zone,c,s) ;

ACZirr0(s,reg,zone,c)$ACZ0(reg,zone,c,s)                             = irrinACZ0(reg,zone,c,s)*ACZ0(reg,zone,c,s)/100 ;
ACZirrSh0(reg,zone,c,s)$(ACZ0(reg,zone,c,s) and ACZirr0(s,reg,zone,c)) = 100*ACZirr0(s,reg,zone,c)/sum(cp,ACZirr0(s,reg,zone,cp)) ;

TACZirr0(reg,zone,s)                               = sum(c$ACZ0(reg,zone,c,s),ACZirr0(s,reg,zone,c));
TACZirrSh0(reg,zone,s)$TACZirr0(reg,zone,s)          = 100*TACZirr0(reg,zone,s)/sum((regp,zonep), TACZirr0(regp,zonep,s));
irrinTACZ0(reg,zone,s)$TACZirr0(reg,zone,s)          = 100*TACZirr0(reg,zone,s)/TACZ0(reg,zone,s) ;
irrinTACZ20(c,s)$sum((reg,zone),ACZ0(reg,zone,c,s))  = 100*sum((reg,zone),ACZirr0(s,reg,zone,c))/sum((reg,zone),ACZ0(reg,zone,c,s)) ;


* JL: comment out adjustments of irrigation for now (come back to this)?
*===Adj irrigation such that total irrigated areas reach 200,000ha  JL: does this value refer to Block et al. (2008)?
*$ontext
AdjACZ_input0(reg,zone,Crop,'irri',s) = ACZ_input0(reg,zone,Crop,'irri',s) ;
AdjACZ_input0(reg,zone,Crop,'none',s) = ACZ_input0(reg,zone,Crop,'none',s) ;
*$offtext

YCZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s)) = 1000*QSZ0(reg,zone,c,s)/ACZ0(reg,zone,c,s) ;

*$ontext
AdjACZ_input0(reg,zone,CropInput,'irri',s) = ACZ_input0(reg,zone,CropInput,'irri',s) ;
AdjACZ_input0(reg,zone,CropInput,'none',s) = ACZ_input0(reg,zone,CropInput,'none',s) ;

AdjACZ_input0(reg,zone,CropInput,'irri',s)$(QSZ0(reg,zone,CropInput,s) and ACZ_input0(reg,zone,CropInput,'none',s) and ACZirr0(s,reg,zone,CropInput)gt
             sum(Wtype,ACZ_input0(reg,zone,CropInput,wtype,s))) =
             ACZ_input0(reg,zone,CropInput,'irri',s) + ACZirr0(s,reg,zone,CropInput) - sum(Wtype,ACZ_input0(reg,zone,CropInput,wtype,s)) ;
AdjACZ_input0(reg,zone,CropInput,'irri',s)$(QSZ0(reg,zone,CropInput,s) and ACZirr0(s,reg,zone,CropInput) le
             sum(Wtype,ACZ_input0(reg,zone,CropInput,wtype,s))) =
             ACZ_input0(reg,zone,CropInput,'irri',s)  ;

AdjACZ_input0(reg,zone,CropInput,'none',s)$(QSZ0(reg,zone,CropInput,s) and ACZ_input0(reg,zone,CropInput,'none',s)  and ACZirr0(s,reg,zone,CropInput) gt
             sum(Wtype,ACZ_input0(reg,zone,CropInput,wtype,s))) =
             ACZ_input0(reg,zone,CropInput,'none',s) - (ACZirr0(s,reg,zone,CropInput) - sum(Wtype,ACZ_input0(reg,zone,CropInput,wtype,s))) ;
AdjACZ_input0(reg,zone,CropInput,'none',s)$(QSZ0(reg,zone,CropInput,s) and ACZirr0(s,reg,zone,CropInput) le
             sum(Wtype,ACZ_input0(reg,zone,CropInput,wtype,s))) =
             ACZ_input0(reg,zone,CropInput,'none',s)  ;

AdjACZ_input0(reg,zone,CropNone,'irri',s)$(ACZirr0(s,reg,zone,CropNone) and QSZ0(reg,zone,CropNone,s))         = ACZirr0(s,reg,zone,CropNone) ;
AdjACZ_input0(reg,zone,CropNone,'irri',s)$(ACZirr0(s,reg,zone,CropNone) eq 0 and QSZ0(reg,zone,CropNone,s))    = 0 ;
AdjACZ_input0(reg,zone,CropNone,'none',s)$(ACZirr0(s,reg,zone,CropNone) and QSZ0(reg,zone,CropNone,s))         = ACZ0(reg,zone,CropNone,s) - ACZirr0(s,reg,zone,CropNone) ;
AdjACZ_input0(reg,zone,CropNone,'none',s)$(ACZirr0(s,reg,zone,CropNone) eq 0 and QSZ0(reg,zone,CropNone,s))    = ACZ0(reg,zone,CropNone,s) ;

ACZ_input0(reg,zone,Crop,'irri',s) = AdjACZ_input0(reg,zone,Crop,'irri',s) ;
ACZ_input0(reg,zone,Crop,'none',s) = AdjACZ_input0(reg,zone,Crop,'none',s) ;
*$offtext

* JL: correct for negative ACZ_input0 values
ACZ_input0(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,s) lt 0) = 0 ;

* JL: some ACZ_input0 values are 0 for annual but nonzero for Belg or Meher. Correct this
ACZ_input0(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,'annual') eq 0) = ACZ_input0(reg,zone,c,type,'belg') + ACZ_input0(reg,zone,c,type,'meher') ;

* JL: still issues with 0 values for ACZ_input0? Last-resort correction:
alias(type,typeinp) ;
ACZ_input0(reg,zone,c,type,s)$(sum(typeinp,ACZ_input0(reg,zone,c,typeinp,s)) eq 0 and ACZ0(reg,zone,c,s) gt 0) = ACZ0(reg,zone,c,s)/16 ;
ACZ_input0(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,s) eq 0 and ACZ0(reg,zone,c,s) gt 0) = ACZ0(reg,zone,c,s)/16 ;
ACZ_input0(reg,zone,c,type,s)$(ACZ0(reg,zone,c,s) eq 0) = 0 ;
ACZ_input0(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,s) lt 0.000001) = 0 ;



AdjYCZ_input0(reg,zone,CropInput,'irri',s)$(ACZ_input0(reg,zone,CropInput,'irri',s) and QSZ0(reg,zone,CropInput,s) and
          ACZ_input0(reg,zone,CropInput,'none',s) and AdjYCZ_input0(reg,zone,CropInput,'irri',s))      = 1.3*AdjYCZ_input0(reg,zone,CropInput,'irri',s) ;
AdjYCZ_input0(reg,zone,CropInput,'irri',s)$(ACZ_input0(reg,zone,CropInput,'irri',s) and QSZ0(reg,zone,CropInput,s) and
          ACZ_input0(reg,zone,CropInput,'none',s) and AdjYCZ_input0(reg,zone,CropInput,'irri',s) eq 0) = 1.3*AdjYCZ_input0(reg,zone,CropInput,'none',s) ;

AdjYCZ_input0(reg,zone,CropNone,'irri',s)$(ACZirr0(s,reg,zone,CropNone) and QSZ0(reg,zone,CropNone,s))   = 1.4*YCZ0(reg,zone,CropNone,s) ;

* JL: comment out because outdated
*AdjYCZ_input0('Afar','Afar1','maize','irri')                     = YCZ_input0('Afar','Afar1','maize','irri') ;
*AdjYCZ_input0('Somali','Shinele','maize','irri')                 = 1.2*YCZ_input0('Somali','Shinele','maize','irri') ;
*AdjYCZ_input0('southern','Gurage','oats','fert')                 = 1.7*YCZ_input0('southern','Gurage','oats','fert') ;
*AdjYCZ_input0('southern','Gurage','OilcropsOther','fert')        = 1.05*YCZ_input0('southern','Gurage','OilcropsOther','fert') ;
*AdjYCZ_input0('Oromia','Arsi','Wheat','s_f')                     = 1.35*YCZ_input0('Oromia','Arsi','Wheat','s_f') ;
*AdjYCZ_input0('Oromia','Arsi','Wheat','fert')                    = 1.101*YCZ_input0('Oromia','Arsi','Wheat','fert') ;
*AdjYCZ_input0('Oromia','Arsi','Wheat','irri')                    = 1.3*YCZ_input0('Oromia','Arsi','Wheat','irri') ;
*AdjYCZ_input0('AddisAbaba','Addis2','Wheat',inptype)             = 1.001*YCZ_input0('AddisAbaba','Addis2','Wheat',inptype) ;
*AdjYCZ_input0('AddisAbaba','Addis2','Teff',inptype)              = 1.001*YCZ_input0('AddisAbaba','Addis2','Teff',inptype) ;
*AdjYCZ_input0('DireDawa','DireDawa','OilcropsOther',inptype)     = 0.99*YCZ_input0('DireDawa','DireDawa','OilcropsOther',inptype) ;
*AdjYCZ_input0('DireDawa','DireDawa','PulsesOther',inptype)       = 1.15*YCZ_input0('DireDawa','DireDawa','PulsesOther',inptype) ;

*==================
 AdjQSZ_input0(reg,zone,crop,type,s) = QSZ_input0(reg,zone,crop,type,s) ;
* AdjQSZ_input0_old(reg,zone,crop,type,s) = QSZ_input0_old(reg,zone,crop,type,s) ;
*ying 6 - add kcmean0>0 in the condition
 AdjQSZ_input0(reg,zone,crop,inptype,s)$(AdjYCZ_input0(reg,zone,crop,inptype,s) and kcmean0(reg,zone,crop,s)) =
            AdjYCZ_input0(reg,zone,crop,inptype,s)*ACZ_input0(reg,zone,crop,inptype,s)/1000;

$ontext
************** JL: major change to model--seasonal shift of supply due to storage or continuous harvest **************
************** JL: no need to do this now since we use QSZ0 and ACZ0 in calculations above *****************
AdjQSZ_input0(reg,zone,'Teff',type,'Meher') = 0.77*AdjQSZ_input0_old(reg,zone,'Teff',type,'Meher') + (1-0.77)*AdjQSZ_input0_old(reg,zone,'Teff',type,'Belg') ;
AdjQSZ_input0(reg,zone,'Barley',type,'Meher') = 0.79*AdjQSZ_input0_old(reg,zone,'Barley',type,'Meher') + (1-0.79)*AdjQSZ_input0_old(reg,zone,'Barley',type,'Belg') ;
AdjQSZ_input0(reg,zone,'Wheat',type,'Meher') = 0.76*AdjQSZ_input0_old(reg,zone,'Wheat',type,'Meher') + (1-0.76)*AdjQSZ_input0_old(reg,zone,'Wheat',type,'Belg') ;
AdjQSZ_input0(reg,zone,'Maize',type,'Meher') = 0.68*AdjQSZ_input0_old(reg,zone,'Maize',type,'Meher') + (1-0.68)*AdjQSZ_input0_old(reg,zone,'Maize',type,'Belg') ;
AdjQSZ_input0(reg,zone,'Sorghum',type,'Meher') = 0.83*AdjQSZ_input0_old(reg,zone,'Sorghum',type,'Meher') + (1-0.83)*AdjQSZ_input0_old(reg,zone,'Sorghum',type,'Belg') ;
AdjQSZ_input0(reg,zone,'Millet',type,'Meher') = 0.75*AdjQSZ_input0_old(reg,zone,'Millet',type,'Meher') + (1-0.75)*AdjQSZ_input0_old(reg,zone,'Millet',type,'Belg') ;
AdjQSZ_input0(reg,zone,'Oats',type,'Meher') = 0.75*AdjQSZ_input0_old(reg,zone,'Oats',type,'Meher') + (1-0.75)*AdjQSZ_input0_old(reg,zone,'Oats',type,'Belg') ;
AdjQSZ_input0(reg,zone,'Rice',type,'Meher') = 0.75*AdjQSZ_input0_old(reg,zone,'Rice',type,'Meher') + (1-0.75)*AdjQSZ_input0_old(reg,zone,'Rice',type,'Belg') ;
AdjQSZ_input0(reg,zone,pulse,type,'Meher') = 0.69*AdjQSZ_input0_old(reg,zone,pulse,type,'Meher') + (1-0.69)*AdjQSZ_input0_old(reg,zone,pulse,type,'Belg') ;
AdjQSZ_input0(reg,zone,oilseed,type,'Meher') = 0.79*AdjQSZ_input0_old(reg,zone,oilseed,type,'Meher') + (1-0.79)*AdjQSZ_input0_old(reg,zone,oilseed,type,'Belg') ;
AdjQSZ_input0(reg,zone,'Rapeseed',type,'Meher') = (0.55/0.79)*AdjQSZ_input0_old(reg,zone,'Rapeseed',type,'Meher') ;
AdjQSZ_input0(reg,zone,LV,type,'Meher') = 0.553*AdjQSZ_input0_old(reg,zone,LV,type,'Meher') + (1-0.553)*AdjQSZ_input0_old(reg,zone,LV,type,'Belg') ;
AdjQSZ_input0(reg,zone,'Stimulants',type,'Meher') = 0.572*AdjQSZ_input0_old(reg,zone,'Stimulants',type,'Meher') + (1-0.572)*AdjQSZ_input0_old(reg,zone,'Stimulants',type,'Belg') ;
AdjQSZ_input0(reg,zone,'Coffee',type,'Meher') = 0.572*AdjQSZ_input0_old(reg,zone,'Coffee',type,'Meher') + (1-0.572)*AdjQSZ_input0_old(reg,zone,'Coffee',type,'Belg') ;
AdjQSZ_input0(reg,zone,'Enset',type,'Meher') = 0.583*AdjQSZ_input0_old(reg,zone,'Enset',type,'Meher') + (1-0.583)*AdjQSZ_input0_old(reg,zone,'Enset',type,'Belg') ;
*AdjQSZ_input0(reg,zone,'SugarRawEquivalent',type,'Meher') = 0.583*AdjQSZ_input0_old(reg,zone,'SugarRawEquivalent',type,'Meher') + (1-0.583)*AdjQSZ_input0_old(reg,zone,'SugarRawEquivalent',type,'Belg') ;
AdjQSZ_input0(reg,zone,'Bananas',type,'Meher') = 0.583*AdjQSZ_input0_old(reg,zone,'Bananas',type,'Meher') + (1-0.583)*AdjQSZ_input0_old(reg,zone,'Bananas',type,'Belg') ;

AdjQSZ_input0(reg,zone,c,type,'Belg') = AdjQSZ_input0(reg,zone,c,type,'Annual') - AdjQSZ_input0(reg,zone,c,type,'Meher') ;

AdjQSZ_input0(reg,zone,c,type,s)$(AdjQSZ_input0(reg,zone,c,type,s) lt 0) = 0 ;
************************************************************************************************************
$offtext

 AdjQSZ_input0(reg,zone,crop,'none',s)$(QSZ_input0(reg,zone,crop,'none',s) and sum(inptype,AdjQSZ_input0(reg,zone,crop,inptype,s))) =
            QSZ_input0(reg,zone,crop,'none',s) - sum(inptype,AdjQSZ_input0(reg,zone,crop,inptype,s) - QSZ_input0(reg,zone,crop,inptype,s)) ;
* AdjQSZ_input0_old(reg,zone,crop,'none',s)$(QSZ_input0_old(reg,zone,crop,'none',s) and sum(inptype,AdjQSZ_input0_old(reg,zone,crop,inptype,s))) =
*            QSZ_input0_old(reg,zone,crop,'none',s) - sum(inptype,AdjQSZ_input0_old(reg,zone,crop,inptype,s) - QSZ_input0_old(reg,zone,crop,inptype,s)) ;

* AdjQSZ_input0(reg,zone,crop,'none')$(QSZ_input0(reg,zone,crop,'none') and sum(inptype,AdjQSZ_input0(reg,zone,crop,inptype)) eq 0) =
*            QSZ_input0(reg,zone,crop,'none') ;

 negQSZ_none(reg,zone,crop,s)$(AdjQSZ_input0(reg,zone,crop,'none',s) lt 0) = AdjQSZ_input0(reg,zone,crop,'none',s);

 display negQSZ_none ;

* assign adjusted values
 QSZ_input0(reg,zone,crop,type,s) = AdjQSZ_input0(reg,zone,crop,type,s) ;
* QSZ_input0_old(reg,zone,crop,type,s) = AdjQSZ_input0_old(reg,zone,crop,type,s) ;

*JL: as with above, last-resort correction to fix data inconsistencies:
 QSZ_input0(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,s) eq 0) = 0 ;
 QSZ_input0(reg,zone,c,type,s)$(QSZ_input0(reg,zone,c,type,s) lt 0.000001) = 0 ;
* QSZ_input0_old(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,s) eq 0) = 0 ;
* QSZ_input0_old(reg,zone,c,type,s)$(QSZ_input0_old(reg,zone,c,type,s) lt 0.000001) = 0 ;

* === ying 6 recalc YCZ for all type not just 'none'
* AdjYCZ_input0(reg,zone,crop,'none',s)$ACZ_input0(reg,zone,crop,'none') =
*              1000*QSZ_input0(reg,zone,crop,'none')/ACZ_input0(reg,zone,crop,'none');

 AdjYCZ_input0(reg,zone,crop,type,s)$ACZ_input0(reg,zone,crop,type,s) =
              1000*QSZ_input0(reg,zone,crop,type,s)/ACZ_input0(reg,zone,crop,type,s);
* ======

 chkYCZ_input0(reg,zone,c,type,s)$(AdjYCZ_input0(reg,zone,c,type,s) and AdjYCZ_input0(reg,zone,c,type,s) lt AdjYCZ_input0(reg,zone,c,'none',s))
         = AdjYCZ_input0(reg,zone,c,type,s) ;

 display chkYCZ_input0;

 chkYCZ_input(reg,zone,crop,inptype,s)$AdjYCZ_input0(reg,zone,crop,'none',s) =
           AdjYCZ_input0(reg,zone,crop,inptype,s)/AdjYCZ_input0(reg,zone,crop,'none',s);
 chkYCZ_input(reg,zone,crop,inptype,s)$(YCZ_input0(reg,zone,crop,inptype,s) and YCZ_input0(reg,zone,crop,'none',s)
               and AdjYCZ_input0(reg,zone,crop,'none',s) eq 0) =
           AdjYCZ_input0(reg,zone,crop,inptype,s)/YCZ_input0(reg,zone,crop,'none',s);

 YCZ_input0(reg,zone,crop,type,s)$AdjYCZ_input0(reg,zone,crop,type,s) = AdjYCZ_input0(reg,zone,crop,type,s);

 RACZ_input0(reg,crop,type,s) = sum(zone,ACZ_input0(reg,zone,crop,type,s)) ;
 RQSZ_input0(reg,crop,type,s) = sum(zone,QSZ_input0(reg,zone,crop,type,s)) ;
* RQSZ_input0_old(reg,crop,type,s) = sum(zone,QSZ_input0_old(reg,zone,crop,type,s)) ;
 RYCZ_input0(reg,c,type,s)$RACZ_input0(reg,c,type,s) = 1000*RQSZ_input0(reg,c,type,s)/RACZ_input0(reg,c,type,s);
* RYCZ_input0(reg,c,type,s)$RACZ_input0(reg,c,type,s) = 1000*RQSZ_input0_old(reg,c,type,s)/RACZ_input0(reg,c,type,s);

 TACZ_input0(crop,type,s) = sum((reg,zone),ACZ_input0(reg,zone,crop,type,s)) ;
 TQSZ_input0(crop,type,s) = sum((reg,zone),QSZ_input0(reg,zone,crop,type,s)) ;
* TQSZ_input0_old(crop,type,s) = sum((reg,zone),QSZ_input0_old(reg,zone,crop,type,s)) ;
 TYCZ_input0(c,type,s)$TACZ_input0(c,type,s) = 1000*TQSZ_input0(c,type,s)/TACZ_input0(c,type,s) ;
* TYCZ_input0(c,type,s)$TACZ_input0(c,type,s) = 1000*TQSZ_input0_old(c,type,s)/TACZ_input0(c,type,s) ;

 chkACZ_input(reg,zone,crop,s) = sum(type,ACZ_input0(reg,zone,crop,type,s)) - ACZ0(reg,zone,crop,s) ;
 chkQSZ_input(reg,zone,crop,s) = sum(type,QSZ_input0(reg,zone,crop,type,s)) - QSZ0(reg,zone,crop,s) ;

 chkRYCZ_input(reg,crop,inptype,s)$RYCZ_input0(reg,crop,'none',s) = RYCZ_input0(reg,crop,inptype,s)/RYCZ_input0(reg,crop,'none',s) ;
 chkTYCZ_input(crop,inptype,s)$TYCZ_input0(crop,'none',s) = TYCZ_input0(crop,inptype,s)/TYCZ_input0(crop,'none',s) ;

* ZeroACZ_input0(reg,zone,crop,type,s)$(ACZ_input0(reg,zone,crop,type,s) and QSZ_input0_old(reg,zone,crop,type,s) eq 0) =
*                     ACZ_input0(reg,zone,crop,type,s) ;
 ZeroQSZ_input0(reg,zone,crop,type,s)$(ACZ_input0(reg,zone,crop,type,s) eq 0 and QSZ_input0(reg,zone,crop,type,s)) =
                     QSZ_input0(reg,zone,crop,type,s) ;

display ZeroACZ_input0, ZeroQSZ_input0, chkACZ_input,  chkQSZ_input, chkTYCZ_input, chkRYCZ_input,
chkYCZ_input, TYCZ_input0, RYCZ_input0, YCZ_input0 ;


*====
*Calculating share after adjustment (JL: sh0 variables not used, so no distinction between prod and supply needed)

 ACZ_inputsh0(reg,zone,c,type,s)$ACZ_input0(reg,zone,c,type,s) =
              100*ACZ_input0(reg,zone,c,type,s)/sum(typep,ACZ_input0(reg,zone,c,typep,s));
 QSZ_inputsh0(reg,zone,c,type,s)$QSZ_input0(reg,zone,c,type,s) =
              100*QSZ_input0(reg,zone,c,type,s)/sum(typep,QSZ_input0(reg,zone,c,typep,s));

 RACZ_inputsh0(reg,c,type,s)$RACZ_input0(reg,c,type,s) =
              100*RACZ_input0(reg,c,type,s)/sum((zone,typep),ACZ_input0(reg,zone,c,typep,s));
 RQSZ_inputsh0(reg,c,type,s)$RQSZ_input0(reg,c,type,s) =
              100*RQSZ_input0(reg,c,type,s)/sum((zone,typep),QSZ_input0(reg,zone,c,typep,s));

 TACZ_inputsh0(c,type,s)$TACZ_input0(c,type,s) =
              100*TACZ_input0(c,type,s)/sum((reg,zone,typep),ACZ_input0(reg,zone,c,typep,s));
 TQSZ_inputsh0(c,type,s)$TQSZ_input0(c,type,s) =
              100*TQSZ_input0(c,type,s)/sum((reg,zone,typep),QSZ_input0(reg,zone,c,typep,s));

 ACZ_inputType0(reg,zone,crop,'fert',s) = sum(Ftype, ACZ_input0(reg,zone,crop,Ftype,s));
 ACZ_inputType0(reg,zone,crop,'irri',s) = sum(Wtype, ACZ_input0(reg,zone,crop,Wtype,s));
 ACZ_inputType0(reg,zone,crop,'seed',s) = sum(Stype, ACZ_input0(reg,zone,crop,Stype,s));
 ACZ_inputType0(reg,zone,crop,'pest',s) = sum(Ptype, ACZ_input0(reg,zone,crop,Ptype,s));

 QSZ_inputType0(reg,zone,crop,'fert',s) = sum(Ftype, QSZ_input0(reg,zone,crop,Ftype,s));
 QSZ_inputType0(reg,zone,crop,'irri',s) = sum(Wtype, QSZ_input0(reg,zone,crop,Wtype,s));
 QSZ_inputType0(reg,zone,crop,'seed',s) = sum(Stype, QSZ_input0(reg,zone,crop,Stype,s));
 QSZ_inputType0(reg,zone,crop,'pest',s) = sum(Ptype, QSZ_input0(reg,zone,crop,Ptype,s));
* QSZ_inputType0_old(reg,zone,crop,'fert',s) = sum(Ftype, QSZ_input0_old(reg,zone,crop,Ftype,s));
* QSZ_inputType0_old(reg,zone,crop,'irri',s) = sum(Wtype, QSZ_input0_old(reg,zone,crop,Wtype,s));
* QSZ_inputType0_old(reg,zone,crop,'seed',s) = sum(Stype, QSZ_input0_old(reg,zone,crop,Stype,s));
* QSZ_inputType0_old(reg,zone,crop,'pest',s) = sum(Ptype, QSZ_input0_old(reg,zone,crop,Ptype,s));

 YCZ_inputType0(reg,zone,c,type,s)$ACZ_inputType0(reg,zone,c,type,s) =
              1000*QSZ_inputType0(reg,zone,c,type,s)/ACZ_inputType0(reg,zone,c,type,s);
* YCZ_inputType0(reg,zone,c,type,s)$ACZ_inputType0(reg,zone,c,type,s) =
*              1000*QSZ_inputType0_old(reg,zone,c,type,s)/ACZ_inputType0(reg,zone,c,type,s);

 ACZ_inputTypesh0(reg,zone,c,type,s)$ACZ_inputType0(reg,zone,c,type,s) =
              100*ACZ_inputType0(reg,zone,c,type,s)/sum(typep,ACZ_input0(reg,zone,c,typep,s));
 QSZ_inputTypesh0(reg,zone,c,type,s)$QSZ_inputType0(reg,zone,c,type,s) =
              100*QSZ_inputType0(reg,zone,c,type,s)/sum(typep,QSZ_input0(reg,zone,c,typep,s));

 RACZ_inputType0(reg,crop,'fert',s) = sum((zone,Ftype), ACZ_input0(reg,zone,crop,Ftype,s));
 RACZ_inputType0(reg,crop,'irri',s) = sum((zone,Wtype), ACZ_input0(reg,zone,crop,Wtype,s));
 RACZ_inputType0(reg,crop,'seed',s) = sum((zone,Stype), ACZ_input0(reg,zone,crop,Stype,s));
 RACZ_inputType0(reg,crop,'pest',s) = sum((zone,Ptype), ACZ_input0(reg,zone,crop,Ptype,s));

 RQSZ_inputType0(reg,crop,'fert',s) = sum((zone,Ftype), QSZ_input0(reg,zone,crop,Ftype,s));
 RQSZ_inputType0(reg,crop,'irri',s) = sum((zone,Wtype), QSZ_input0(reg,zone,crop,Wtype,s));
 RQSZ_inputType0(reg,crop,'seed',s) = sum((zone,Stype), QSZ_input0(reg,zone,crop,Stype,s));
 RQSZ_inputType0(reg,crop,'pest',s) = sum((zone,Ptype), QSZ_input0(reg,zone,crop,Ptype,s));
* RQSZ_inputType0_old(reg,crop,'fert',s) = sum((zone,Ftype), QSZ_input0_old(reg,zone,crop,Ftype,s));
* RQSZ_inputType0_old(reg,crop,'irri',s) = sum((zone,Wtype), QSZ_input0_old(reg,zone,crop,Wtype,s));
* RQSZ_inputType0_old(reg,crop,'seed',s) = sum((zone,Stype), QSZ_input0_old(reg,zone,crop,Stype,s));
* RQSZ_inputType0_old(reg,crop,'pest',s) = sum((zone,Ptype), QSZ_input0_old(reg,zone,crop,Ptype,s));

 RYCZ_inputType0(reg,c,type,s)$RACZ_inputType0(reg,c,type,s) =
              1000*RQSZ_inputType0(reg,c,type,s)/RACZ_inputType0(reg,c,type,s);
* RYCZ_inputType0(reg,c,type,s)$RACZ_inputType0(reg,c,type,s) =
*              1000*RQSZ_inputType0_old(reg,c,type,s)/RACZ_inputType0(reg,c,type,s);

 RACZ_inputTypesh0(reg,c,type,s)$RACZ_inputType0(reg,c,type,s) =
              100*RACZ_inputType0(reg,c,type,s)/sum((zone,typep),ACZ_input0(reg,zone,c,typep,s));
 RQSZ_inputTypesh0(reg,c,type,s)$RQSZ_inputType0(reg,c,type,s) =
              100*RQSZ_inputType0(reg,c,type,s)/sum((zone,typep),QSZ_input0(reg,zone,c,typep,s));

 TACZ_inputType0(crop,'fert',s) = sum((reg,zone,Ftype), ACZ_input0(reg,zone,crop,Ftype,s));
 TACZ_inputType0(crop,'irri',s) = sum((reg,zone,Wtype), ACZ_input0(reg,zone,crop,Wtype,s));
 TACZ_inputType0(crop,'seed',s) = sum((reg,zone,Stype), ACZ_input0(reg,zone,crop,Stype,s));
 TACZ_inputType0(crop,'pest',s) = sum((reg,zone,Ptype), ACZ_input0(reg,zone,crop,Ptype,s));
 TQSZ_inputType0(crop,'fert',s) = sum((reg,zone,Ftype), QSZ_input0(reg,zone,crop,Ftype,s));
 TQSZ_inputType0(crop,'irri',s) = sum((reg,zone,Wtype), QSZ_input0(reg,zone,crop,Wtype,s));
 TQSZ_inputType0(crop,'seed',s) = sum((reg,zone,Stype), QSZ_input0(reg,zone,crop,Stype,s));
 TQSZ_inputType0(crop,'pest',s) = sum((reg,zone,Ptype), QSZ_input0(reg,zone,crop,Ptype,s));
* TQSZ_inputType0_old(crop,'fert',s) = sum((reg,zone,Ftype), QSZ_input0_old(reg,zone,crop,Ftype,s));
* TQSZ_inputType0_old(crop,'irri',s) = sum((reg,zone,Wtype), QSZ_input0_old(reg,zone,crop,Wtype,s));
* TQSZ_inputType0_old(crop,'seed',s) = sum((reg,zone,Stype), QSZ_input0_old(reg,zone,crop,Stype,s));
* TQSZ_inputType0_old(crop,'pest',s) = sum((reg,zone,Ptype), QSZ_input0_old(reg,zone,crop,Ptype,s));

 TYCZ_inputType0(c,type,s)$TACZ_inputType0(c,type,s) =
              1000*TQSZ_inputType0(c,type,s)/TACZ_inputType0(c,type,s);
* TYCZ_inputType0(c,type,s)$TACZ_inputType0(c,type,s) =
*              1000*TQSZ_inputType0_old(c,type,s)/TACZ_inputType0(c,type,s);

 TACZ_inputTypesh0(c,type,s)$TACZ_inputType0(c,type,s) =
              100*TACZ_inputType0(c,type,s)/sum((reg,zone,typep),ACZ_input0(reg,zone,c,typep,s));

 TQSZ_inputTypesh0(c,type,s)$TQSZ_inputType0(c,type,s) =
              100*TQSZ_inputType0(c,type,s)/sum((reg,zone,typep),QSZ_input0(reg,zone,c,typep,s));

*==== Elas - yield, area, supply(output) ==============================
parameter
chkeap(reg,zone,c,s)            sum(cp eap0(reg zone c cp)) + eyp0(reg zone c)
chkesp(reg,zone,c,s)            sum(cp esp0(reg zone c cp))
chkland(reg,zone,c,s)           sum(agp landshare(reg zone agp)*eap0(reg zone agp ag))
voutputshare(reg,zone,c,s)      volume ($) of output share of c for each zone
landshare(reg,zone,c,s)         ag area share of ag c for each zone
owneap0(reg,zone,c,s)           own area elas
ownesp0(reg,zone,c,s)           own supply eals
chkay0(reg,zone,c,s)            check yield intercept (should be zero)
chkaa0(reg,zone,c,s)            check area intercept  (should be zero)
chkas0(reg,zone,c,s)            check supply intercept(should be zero)
;

voutputshare(reg,zone,ag,s)$QSZ0(reg,zone,ag,s) = PPZ0(reg,zone,ag,s)*QSZ0(reg,zone,ag,s)/sum(agp,PPZ0(reg,zone,agp,s)*QSZ0(reg,zone,agp,s));
landshare(reg,zone,ag,s)$ACZ0(reg,zone,ag,s)    = ACZ0(reg,zone,ag,s)/sum(agp,ACZ0(reg,zone,agp,s));

eyp0(s,reg,zone,c)$ACZ0(reg,zone,c,s)   = eyp0(s,reg,zone,c) ;
eap0(reg,zone,c,c,s)$ACZ0(reg,zone,c,s) = eyp0(s,reg,zone,c) ;
esp0(reg,zone,c,cp,s) = 0 ;
esp0(reg,zone,lv,lv,s)$QSZ0(reg,zone,lv,s)    = eyp0(s,reg,zone,lv) ;
esp0(reg,zone,nag,nag,s)$QSZ0(reg,zone,nag,s) = eyp0(s,reg,zone,nag) ;


eap0(reg,zone,c,cp,s)$(ACZ0(reg,zone,c,s) and ACZ0(reg,zone,cp,s)) = -voutputshare(reg,zone,cp,s)*eyp0(s,reg,zone,c)/1.0 ;
eap0(reg,zone,cp,c,s)$(ACZ0(reg,zone,c,s) and ACZ0(reg,zone,cp,s)) = -voutputshare(reg,zone,c,s)*eyp0(s,reg,zone,cp)/1.0 ;
eap0(reg,zone,cereal,cerealp,s)$(ACZ0(reg,zone,cereal,s) and ACZ0(reg,zone,cerealp,s)) =
            -voutputshare(reg,zone,cerealp,s)*eyp0(s,reg,zone,cereal)/1.0 ;
eap0(reg,zone,cerealp,cereal,s)$(ACZ0(reg,zone,cereal,s) and ACZ0(reg,zone,cerealp,s)) =
            -voutputshare(reg,zone,cereal,s)*eyp0(s,reg,zone,cerealp)/1.0 ;
eap0(reg,zone,c,cp,s)$(ACZ0(reg,zone,c,s) eq 0 or ACZ0(reg,zone,cp,s) eq 0) = 0 ;
eap0(reg,zone,cereal,lv,s)$ACZ0(reg,zone,cereal,s) = voutputshare(reg,zone,cereal,s)*eyp0(s,reg,zone,cereal)/56 ;
eap0(reg,zone,c,nag,s) = 0 ;
eap0(reg,zone,lv,c,s)  = 0 ;
eap0(reg,zone,nag,c,s) = 0 ;

eap0(reg,zone,c,c,s)$ACZ0(reg,zone,c,s) = eyp0(s,reg,zone,c) ;

esp0(reg,zone,lv,cereal,s)  =
      -0.1*sum((regp,zonep),QSZ0(regp,zonep,cereal,s))/sum((regp,zonep,cerealp),QSZ0(regp,zonep,cerealp,s))*eyp0(s,reg,zone,lv) ;

esp0(reg,zone,nag,cereal,s) =
      -0.1*sum((regp,zonep),QSZ0(regp,zonep,cereal,s))/sum((regp,zonep,cerealp),QSZ0(regp,zonep,cerealp,s))*eyp0(s,reg,zone,nag) ;
esp0(reg,zone,nag,lv,s)     =
      -0.1*sum((regp,zonep),QSZ0(regp,zonep,lv,s))/sum((regp,zonep,lvp),QSZ0(regp,zonep,lvp,s))*eyp0(s,reg,zone,nag) ;

esp0(reg,zone,nag,ntradition,s) =
      -0.025*sum((regp,zonep),QSZ0(regp,zonep,ntradition,s))/sum((regp,zonep,ntraditionp),QSZ0(regp,zonep,ntraditionp,s))*eyp0(s,reg,zone,nag) ;
esp0(reg,zone,nag,oilseed,s)    =
      -0.035*sum((regp,zonep),QSZ0(regp,zonep,oilseed,s))/sum((regp,zonep,oilseedp),QSZ0(regp,zonep,oilseedp,s))*eyp0(s,reg,zone,nag) ;

chkeap(reg,zone,c,s)$ACZ0(reg,zone,c,s)      = sum(cp,eap0(reg,zone,c,cp,s)) + eyp0(s,reg,zone,c);
*chkeap(reg,zone,c,s)$ACZ0(reg,zone,c,s)     = sum(cp,eap0(reg,zone,c,cp,s)) ;
chkland(reg,zone,ag,s)$ACZ0(reg,zone,ag,s)   = sum(agp,landshare(reg,zone,agp,s)*eap0(reg,zone,agp,ag,s));

display voutputshare, landshare, chkeap, chkland, eyp0;

eap0(reg,zone,c,c,s)$ACZ0(reg,zone,c,s)      = eap0(reg,zone,c,c,s) - chkland(reg,zone,c,s) ;
eyp0(s,reg,zone,c)$ACZ0(reg,zone,c,s)        = eyp0(s,reg,zone,c) - 0.5*chkeap(reg,zone,c,s) ;
eap0(reg,zone,c,c,s)$ACZ0(reg,zone,c,s)      = eap0(reg,zone,c,c,s) - 0.5*chkeap(reg,zone,c,s) ;
eap0(reg,zone,c,'nagntrade',s) = 0 ;

chkeap(reg,zone,c,s)$ACZ0(reg,zone,c,s)      = sum(cp,eap0(reg,zone,c,cp,s)) + eyp0(s,reg,zone,c);
*chkeap(reg,zone,c,s)$ACZ0(reg,zone,c,s)     = sum(cp,eap0(reg,zone,c,cp,s)) ;
chkland(reg,zone,ag,s)$ACZ0(reg,zone,ag,s)   = sum(agp,landshare(reg,zone,agp,s)*eap0(reg,zone,agp,ag,s));

eap0(reg,zone,c,c,s)$ACZ0(reg,zone,c,s)      = eap0(reg,zone,c,c,s) - chkland(reg,zone,c,s) ;
chkland(reg,zone,ag,s)$ACZ0(reg,zone,ag,s)   = sum(agp,landshare(reg,zone,agp,s)*eap0(reg,zone,agp,ag,s));

eap0(reg,zone,c,c,s)$ACZ0(reg,zone,c,s)      = eap0(reg,zone,c,c,s) - chkland(reg,zone,c,s) ;
chkland(reg,zone,ag,s)$ACZ0(reg,zone,ag,s)   = sum(agp,landshare(reg,zone,agp,s)*eap0(reg,zone,agp,ag,s));

eap0(reg,zone,c,c,s)$ACZ0(reg,zone,c,s)      = eap0(reg,zone,c,c,s) - chkland(reg,zone,c,s) ;
chkland(reg,zone,ag,s)$ACZ0(reg,zone,ag,s)   = sum(agp,landshare(reg,zone,agp,s)*eap0(reg,zone,agp,ag,s));

eyp0(s,reg,zone,ag)$ACZ0(reg,zone,ag,s)      =  eyp0(s,reg,zone,ag) - chkland(reg,zone,ag,s) ;

chkeap(reg,zone,c,s)$ACZ0(reg,zone,c,s)      = sum(cp,eap0(reg,zone,c,cp,s)) + eyp0(s,reg,zone,c);

eyp0(s,reg,zone,c)$ACZ0(reg,zone,c,s)        =  eyp0(s,reg,zone,c) - 0.5*chkeap(reg,zone,c,s) ;
eap0(reg,zone,c,c,s)$ACZ0(reg,zone,c,s)      = eap0(reg,zone,c,c,s) - 0.5*chkeap(reg,zone,c,s) ;

chkland(reg,zone,ag,s)$ACZ0(reg,zone,ag,s)   = sum(agp,landshare(reg,zone,agp,s)*eap0(reg,zone,agp,ag,s));

eap0(reg,zone,c,c,s)$ACZ0(reg,zone,c,s)      = eap0(reg,zone,c,c,s) - chkland(reg,zone,c,s) ;
eap0(reg,zone,c,c,s)$(ACZ0(reg,zone,c,s) and eap0(reg,zone,c,c,s) lt 0) = 0.01 ;

chkland(reg,zone,ag,s)$ACZ0(reg,zone,ag,s)   = sum(agp,landshare(reg,zone,agp,s)*eap0(reg,zone,agp,ag,s));

eyp0(s,reg,zone,ag)$ACZ0(reg,zone,ag,s)      =  eyp0(s,reg,zone,ag) - chkland(reg,zone,ag,s) ;
eyp0(s,reg,zone,ag)$(ACZ0(reg,zone,ag,s) and eyp0(s,reg,zone,ag) lt 0) = 0.01 ;

chkeap(reg,zone,c,s)$ACZ0(reg,zone,c,s)      = sum(cp,eap0(reg,zone,c,cp,s)) + eyp0(s,reg,zone,c);
chkland(reg,zone,ag,s)$ACZ0(reg,zone,ag,s)   = sum(agp,landshare(reg,zone,agp,s)*eap0(reg,zone,agp,ag,s));

owneap0(reg,zone,c,s)  = eap0(reg,zone,c,c,s) ;

esp0(reg,zone,lv,lvp,s)$(QSZ0(reg,zone,lv,s) and QSZ0(reg,zone,lvp,s)) = -voutputshare(reg,zone,lv,s)*eyp0(s,reg,zone,lv)/0.5 ;
esp0(reg,zone,lv,lv,s)$QSZ0(reg,zone,lv,s)    = eyp0(s,reg,zone,lv) ;
chkesp(reg,zone,c,s)$QSZ0(reg,zone,c,s)       = sum(cp,esp0(reg,zone,c,cp,s)) ;

esp0(reg,zone,lv,lv,s)$QSZ0(reg,zone,lv,s)    = eyp0(s,reg,zone,lv) - chkesp(reg,zone,lv,s);
esp0(reg,zone,nag,nag,s)$QSZ0(reg,zone,nag,s) = eyp0(s,reg,zone,nag) - chkesp(reg,zone,nag,s);
chkesp(reg,zone,c,s)$QSZ0(reg,zone,c,s)       = sum(cp,esp0(reg,zone,c,cp,s)) ;

ownesp0(reg,zone,c,s) = esp0(reg,zone,c,c,s) ;

display chkeap, chkland, chkesp, eyp0, owneap0, ownesp0, esp0;

*=== Interception of supply funciton
*=== Bring in rainfall effect on yield
* assign values to variables
eap(reg,zone,c,cp,s) = eap0(reg,zone,c,cp,s);
eyp(reg,zone,c,s)    = eyp0(s,reg,zone,c);
esp(reg,zone,c,cp,s) = esp0(reg,zone,c,cp,s);

esp20(reg,zone,c,cp,s) = 0 ;
esp2(reg,zone,c,cp,s)  = esp20(reg,zone,c,cp,s) ;

eypInput0(reg,zone,c,type,s)$ACZ_input0(reg,zone,c,type,s)    = eyp(reg,zone,c,s) ;
eapInput0(reg,zone,c,cp,type,s)$ACZ_input0(reg,zone,c,type,s) = eap0(reg,zone,c,cp,s) ;

*eypInput0(reg,zone,cropInput,'none')$ACZ_input0(reg,zone,cropInput,'none') = 0.1*eyp(reg,zone,cropInput) ;
*eypInput0(reg,zone,cropInput,type)$ACZ_input0(reg,zone,cropInput,type) = 0.1*eyp(reg,zone,cropInput) ;

eypInput(reg,zone,c,type,s)    = eypInput0(reg,zone,c,type,s) ;
eapInput(reg,zone,c,cp,type,s) = eapInput0(reg,zone,c,cp,type,s) ;

YCZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s)) = 1000*QSZ0(reg,zone,c,s)/ACZ0(reg,zone,c,s) ;
*YCZ0(reg,zone,c,s)$(QSZ0_old(reg,zone,c,s) and ACZ0(reg,zone,c,s)) = 1000*QSZ0_old(reg,zone,c,s)/ACZ0(reg,zone,c,s) ;

QSZirr0(reg,zone,c,s)$ACZirr0(s,reg,zone,c) = 1.50*YCZ0(reg,zone,c,s)*ACZirr0(s,reg,zone,c)/1000 ;
YCZirr0(reg,zone,c,s)$(QSZirr0(reg,zone,c,s) and ACZirr0(s,reg,zone,c)) = 1000*QSZirr0(reg,zone,c,s)/ACZirr0(s,reg,zone,c) ;

*================================

 aa0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s)) = ACZ0(reg,zone,c,s)/
                (PROD(CP$QSZ0(reg,zone,cp,s),(PPZ0(reg,zone,cp,s)/PPZ0(reg,zone,'nagntrade',s))**eap(reg,zone,c,cp,s)));
* ay0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s))  = YCZ0(reg,zone,c,s)/((PPZ0(reg,zone,c,s)/PPZ0(reg,zone,'nagntrade',s))**eyp(reg,zone,c,s));

 as0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s) eq 0) = QSZ0(reg,zone,c,s)/
                (PROD(CP$QSZ0(reg,zone,cp,s),(PPZ0(reg,zone,cp,s)/PPZ0(reg,zone,'nagntrade',s))**esp(reg,zone,c,cp,s)));
 as0(reg,zone,'nagntrade',s)$QSZ0(reg,zone,'nagntrade',s) = QSZ0(reg,zone,'nagntrade',s)/
                (PROD(CP$QSZ0(reg,zone,cp,s),(PPZ0(reg,zone,cp,s))**esp(reg,zone,'nagntrade',cp,s)));

* as0(reg,zone,nag)$QSZ0(reg,zone,nag) = QSZ0(reg,zone,nag)/
*                (PROD(CP$QSZ0(reg,zone,cp,s),(PPZ0(reg,zone,cp,s))**esp(reg,zone,nag,cp)));

 aaIrr0(reg,zone,c,s)$(QSZirr0(reg,zone,c,s) and ACZirr0(s,reg,zone,c)) = ACZirr0(s,reg,zone,c)/
                (PROD(CP$QSZ0(reg,zone,cp,s),(PPZ0(reg,zone,cp,s)/PPZ0(reg,zone,'nagntrade',s))**eap(reg,zone,c,cp,s)));
 ayIrr0(reg,zone,c,s)$(QSZirr0(reg,zone,c,s) and ACZirr0(s,reg,zone,c))  = YCZirr0(reg,zone,c,s)/((PPZ0(reg,zone,c,s)/PPZ0(reg,zone,'nagntrade',s))**eyp(reg,zone,c,s));

* ay0(reg,zone,c,s)$(KcMean0(reg,zone,c,s) and QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s)) =
*               ay0(reg,zone,c,s)/KcMean0(reg,zone,c,s) ;

* JL: change to require nonzero PPZ0 too since PPZ0 comes from shifted supply while QSZ_input`0 does not
 aaInput0(reg,zone,c,type,s)$(QSZ_input0(reg,zone,c,type,s) and ACZ_input0(reg,zone,c,type,s) and PPZ0(reg,zone,c,s)) = ACZ_input0(reg,zone,c,type,s)/
                (PROD(CP$QSZ_input0(reg,zone,cp,type,s),(PPZ0(reg,zone,cp,s)/PPZ0(reg,zone,'nagntrade',s))**eapInput(reg,zone,c,cp,type,s)));
 ayInput0(reg,zone,c,type,s)$(QSZ_input0(reg,zone,c,type,s) and ACZ_input0(reg,zone,c,type,s) and PPZ0(reg,zone,c,s))  =
            YCZ_input0(reg,zone,c,type,s)/((PPZ0(reg,zone,c,s)/PPZ0(reg,zone,'nagntrade',s))**eypInput(reg,zone,c,type,s));
*===== ying5b  changed it for nwtype only
 ayInput0(reg,zone,c,nwtype,s)$(KcMean0(reg,zone,c,s) and QSZ_input0(reg,zone,c,nwtype,s) and ACZ_input0(reg,zone,c,nwtype,s)) =
               ayInput0(reg,zone,c,nwtype,s)/KcMean0(reg,zone,c,s) ;
* ying 6 deal with zero kcmean situation
 ayInput0(reg,zone,c,nwtype,s)$(KcMean0(reg,zone,c,s) eq 0 and QSZ_input0(reg,zone,c,nwtype,s) and ACZ_input0(reg,zone,c,nwtype,s)) = 0;
*============


parameter
chkaaIrr0(reg,zone,c,s)                  should be zero
chkayIrr0(reg,zone,c,s)                  should be zero
chkaaInput0(reg,zone,c,type,s)           check aaInput =0 but ACZinput >0 (should not be)
chkayInput0(reg,zone,c,type,s)           should be zero
chkKcMean(reg,zone,c,s)                  check when kcmean =0 but ycz>0 (should not be)
;
chkKcMean(reg,zone,c,s)$(KcMean0(reg,zone,c,s) eq 0  and YCZ0(reg,zone,c,s)) = YCZ0(reg,zone,c,s) ;
display chkKcmean;

*assign value to parameter enter the MCP model
KcMean(reg,zone,c,s) = KcMean0(reg,zone,c,s) ;

chkaaInput0(reg,zone,c,type,s)$(aaInput0(reg,zone,c,type,s) eq 0 and ACZ_input0(reg,zone,c,type,s)) = ACZ_input0(reg,zone,c,type,s) ;
display chkaaInput0;

chkaaInput0(reg,zone,c,type,s)$(aaInput0(reg,zone,c,type,s) eq 0 and ACZ_input0(reg,zone,c,type,s)) = QSZ_input0(reg,zone,c,type,s) ;
display chkaaInput0;

aa(reg,zone,c,s)$aa0(reg,zone,c,s) = aa0(reg,zone,c,s);
*ay(reg,zone,c,s)$ay0(reg,zone,c,s) = ay0(reg,zone,c,s);
as(reg,zone,c,s)$as0(reg,zone,c,s) = as0(reg,zone,c,s);

aaIrr(reg,zone,c,s)$aaIrr0(reg,zone,c,s) = aaIrr0(reg,zone,c,s);
ayIrr(reg,zone,c,s)$ayIrr0(reg,zone,c,s) = ayIrr0(reg,zone,c,s);

aaInput(reg,zone,c,type,s) = aaInput0(reg,zone,c,type,s) ;
ayInput(reg,zone,c,type,s) = ayInput0(reg,zone,c,type,s) ;

chkaa0(reg,zone,c,s)$ACZ0(reg,zone,c,s)
 = ACZ0(reg,zone,c,s) - aa(reg,zone,c,s)*PROD(CP$QSZ0(reg,zone,cp,s),(PPZ0(reg,zone,cp,s)/PPZ0(reg,zone,'nagntrade',s))**eap(reg,zone,c,cp,s)) ;
*chkay0(reg,zone,c,s)$ACZ0(reg,zone,c,s)
* = YCZ0(reg,zone,c,s) - ay(reg,zone,c,s)*KcMean(reg,zone,c,s)*(PPZ0(reg,zone,c,s)/PPZ0(reg,zone,'nagntrade',s))**eyp(reg,zone,c,s) ;
chkas0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s) eq 0)
 = QSZ0(reg,zone,c,s) - as(reg,zone,c,s)*PROD(CP$QSZ0(reg,zone,cp,s),(PPZ0(reg,zone,cp,s)/PPZ0(reg,zone,'nagntrade',s))**esp(reg,zone,c,cp,s)) ;


chkaaIrr0(reg,zone,c,s)$ACZirr0(s,reg,zone,c)
  = ACZirr0(s,reg,zone,c) - aaIrr(reg,zone,c,s)*PROD(CP$QSZ0(reg,zone,cp,s),(PPZ0(reg,zone,cp,s)/PPZ0(reg,zone,'nagntrade',s))**eap(reg,zone,c,cp,s)) ;

chkayIrr0(reg,zone,c,s)$ACZirr0(s,reg,zone,c)
  = YCZirr0(reg,zone,c,s) - ayIrr(reg,zone,c,s)*(PPZ0(reg,zone,c,s)/PPZ0(reg,zone,'nagntrade',s))**eyp(reg,zone,c,s) ;

chkaaInput0(reg,zone,c,type,s)$ACZ_input0(reg,zone,c,type,s)
  = ACZ_input0(reg,zone,c,type,s) - aaInput(reg,zone,c,type,s)*
                (PROD(CP$QSZ_input0(reg,zone,cp,type,s),(PPZ0(reg,zone,cp,s)/PPZ0(reg,zone,'nagntrade',s))**eapInput(reg,zone,c,cp,type,s)));
chkayInput0(reg,zone,c,type,s)$ACZ_input0(reg,zone,c,type,s)
  = YCZ_input0(reg,zone,c,type,s) - ayInput(reg,zone,c,type,s)*KcMean(reg,zone,c,s)*((PPZ0(reg,zone,c,s)/PPZ0(reg,zone,'nagntrade',s))**eypInput(reg,zone,c,type,s));

display aa0, aaIrr0,  ayIrr0, as0, YCZ0, qsz0, acz0, chkaa0, chkaaIrr0, chkayIrr0, chkas0, chkaaInput0, chkayInput0, Kcmean;

parameter
chkWal(reg,zone,s)      zonal volume($) of demand minus supply
chkTwalR(reg,s)         regional volume($) of demand minus supply
chkTwal(s)               total volume($) of demand minus supply
chkAgwal(s)              total Ag volume($) of demand minus supply
chkAgWal2(s)             total Ag volume of demand minus supply
chkGrainwal(s)           total cereal volume($) of demand minus supply
chkGrainWal2(s)          total cereal volume of demand minus supply
chkLvwal(s)              total livestock volume($) of demand minus supply
chkLvWal2(s)             total livestock volume of demand minus supply
chkwalComm(c,s)         total volume($) of demand minus supply for each comm
chkWalComm2(c,s)        total volume of demand minus supply for each comm
;

*chkWal(reg,zone,s) = sum(c,PC0(c,s)*(QFZ0(reg,zone,c,s) + QLZ0(reg,zone,c,s) + QOZ0(reg,zone,c,s) - QSZ0(reg,zone,c,s)));
*chkWal(reg,zone,s) = sum(c,PCZ0(reg,zone,c,s)*(QFZ0(reg,zone,c,s) + QLZ0(reg,zone,c,s) + QOZ0(reg,zone,c,s)) - PPZ0(reg,zone,c,s)*QSZ0(reg,zone,c,s));
chkWal(reg,zone,s) = sum(c,PCZ0(reg,zone,c,s)*(QFZ0(reg,zone,c,s) -QSZ0(reg,zone,c,s)));
chkTwalR(reg,s)    = sum(zone,chkWal(reg,zone,s));
chkTWal(s)          = sum(reg,chkTwalR(reg,s));
chkAgWal(s)         = sum((reg,zone,ag),PCZ0(reg,zone,ag,s)*(QFZ0(reg,zone,ag,s) + QLZ0(reg,zone,ag,s) + QOZ0(reg,zone,ag,s)- QSZ0(reg,zone,ag,s)));
chkGrainWal(s)      = sum((reg,zone,cereal),PCZ0(reg,zone,cereal,s)*(QFZ0(reg,zone,cereal,s) + QLZ0(reg,zone,cereal,s) + QOZ0(reg,zone,cereal,s)- QSZ0(reg,zone,cereal,s)));
chkLvWal(s)         = sum((reg,zone,lv),PCZ0(reg,zone,lv,s)*(QFZ0(reg,zone,lv,s) + QLZ0(reg,zone,lv,s) + QOZ0(reg,zone,lv,s)- QSZ0(reg,zone,lv,s)));
chkwalComm(c,s)    = sum((reg,zone),PCZ0(reg,zone,c,s)*(QFZ0(reg,zone,c,s) + QLZ0(reg,zone,c,s) + QOZ0(reg,zone,c,s)- QSZ0(reg,zone,c,s)));

display chkAgwal, chkGrainwal, chkLvwal, chkTwal, chkTwalR, chkWal, chkWalComm;

chkAgWal2(s)         = sum((reg,zone,ag),(QFZ0(reg,zone,ag,s) + QLZ0(reg,zone,ag,s) + QOZ0(reg,zone,ag,s)- QSZ0(reg,zone,ag,s)));
chkGrainWal2(s)      = sum((reg,zone,cereal),(QFZ0(reg,zone,cereal,s) + QLZ0(reg,zone,cereal,s) + QOZ0(reg,zone,cereal,s)- QSZ0(reg,zone,cereal,s)));
chkLvWal2(s)         = sum((reg,zone,lv),(QFZ0(reg,zone,lv,s) + QLZ0(reg,zone,lv,s) + QOZ0(reg,zone,lv,s)- QSZ0(reg,zone,lv,s)));
chkWalComm2(c,s)    = sum((reg,zone),(QFZ0(reg,zone,c,s) + QLZ0(reg,zone,c,s) + QOZ0(reg,zone,c,s)- QSZ0(reg,zone,c,s)));
display chkAgwal2, chkGrainwal2, chkLvwal2, chkWalComm2;

*========== Calories ====================
pmaln0           = 47.0 ;
melas            = -1.5*25.24;
ninfant          = ninfant0;
nmaln0           = pmaln0*ninfant0/100 ;

*CALPC0(c,s)        = 10*KcalRatio(c)*TQFpc0(c,s)/365 ;   *JL: seasonal disaggregation
CALPC0(c,'belg')        = 10*KcalRatio(c)*TQFpc0(c,'belg')/151 ;
CALPC0(c,'meher')        = 10*KcalRatio(c)*TQFpc0(c,'meher')/214 ;
CALPC0(c,'annual')        = 10*KcalRatio(c)*TQFpc0(c,'annual')/365 ;
TCALPC0(s)          = sum(c,CALPC0(c,s) ) ;
intermal(s)         = pmaln0 - melas*log(TCALPC0(s)) ;

*====================

display
Texpendpc0, GDPPC0, expendrpc0, GDPrPC0, expendzpc0, GDPZPC0,
Agexpendpc0, AgGDPPC0, Agexpendrpc0, AgGDPrPC0, Agexpendzpc0, AgGDPZPC0,
QFZpc0,totnag,dqmzratio, dqezratio, dqmz0, dqez0
comparPCZ, comparPCZ2
comparPPZ, comparPPZ2
;

display
PW0
HHIshare
chkincomeag, chkincomenag, incomeagPC0, incomenagPC0, GDPZHPC0, GDPRPC0, GDPPC0
Tpop0, PopUrb0, chkUrbshare, PopRurshare
zeroTQS, zeroQF, chkyield
totdata
TQFpc0, TQSpc0
TQS0, TAC0, TYC0, QT0, TQF0, TQL0, TQO0,QM0, QE0
Tpop0, PopUrb0
GDP0, AgrGDP0, IndGDP0, SerGDP0
zoneareashare, zoneoutputshare, chkzonearea, chkzoneoutput
PopZ0, PopRurshare
ACZ_input0
;

* add by ying
*parameter
*GAPZint(reg,zone,c,s)
*;
*GAPZint(reg,zone,c,s) =  gapZ0(reg,zone,c,s);
*===

*===============================
* Variables and equations

VARIABLES
 PP(c,s)              Domestic producer prices
 PC(c,s)              Domestic consumer prices
 PPZ(reg,zone,c,s)    Domestic producer prices
 PCZ(reg,zone,c,s)    Domestic consumer prices
 PPAVGR(reg,c,s)      Average domestic producer prices by region
 PPAVG(c,s)           Average domestic producer prices at national level

 QFZ(reg,zone,c,s)            Total Food demand
 QFZH(reg,zone,urbrur,c,s)    Total Food demand
 QFZpc(reg,zone,c,s)          per capita Food demand
 QFZHpc(reg,zone,urbrur,c,s)  per capita Food demand

 QLZ(reg,zone,c,s)    Total feed demand
 QOZ(reg,zone,c,s)    Total other demand
 QDZ(reg,zone,c,s)    Total demand
 ACZ(reg,zone,c,s)    Area response - non-byproduct crops - by zone
 YCZ(reg,zone,c,s)    Yield response - non-byproduct crops
 QSZ(reg,zone,c,s)    Total supply - by zone
* QSZ_old(reg,zone,c,s)    Total production - by zone

 ACZ_input(reg,zone,c,type,s)    Area response - non-byproduct crops - by zone
 YCZ_input(reg,zone,c,type,s)    Yield response - non-byproduct crops
 QSZ_input(reg,zone,c,type,s)    Total supply - by zone
* QSZ_input_old(reg,zone,c,type,s)    Total production - by zone

 TQS(c,s)             total supply
 TAC(c,s)             total area by crop
 TACZ(reg,zone,s)     total area by zone
 QT(c,s)              Volume of net trade positive is imports

 GDPZpc(reg,zone,s)           per capita income zonal level
 GDPZ(reg,zone,s)             income zonal level
 GDPZHpc(reg,zone,urbrur,s)   per capita income zonal level
 GDPZH(reg,zone,urbrur,s)     income zonal level

 EXR                 exchange rate
 CPI(s)                 consumer price index
 DUMMY(reg,zone,c,s)   a dummy variable
 ToTmargz(reg,zone,s)  Total domestic trade margins
 DQTZ(reg,zone,c,s)    zonal level deficit by crop
*add by ying
* GapZ(reg,zone,c,s)    price gap compared to central market in Addis (deficit zone should be positive gap)
*===

POSITIVE VARIABLES
 QM(c,s)              Volume of net imports
 QE(c,s)              Volume of net exports
 DQMZ(reg,zone,c,s)   zonal level deficit by crop
 DQEZ(reg,zone,c,s)   zonal level surplus by crop


;


 PP.L(c,s)                = PP0(c,s);
 PC.L(c,s)                = PC0(c,s);
 PPZ.L(reg,zone,c,s)      = PPZ0(reg,zone,c,s);
 PCZ.L(reg,zone,c,s)      = PCZ0(reg,zone,c,s);
 PPAVGR.L(reg,c,s)        = PPAVGR0(reg,c,s);
 PPAVG.L(c,s)             = PPAVG0(c,s);

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
*JL: tried to add this to equations but solver failed
* QSZ_old.L(reg,zone,c,s)      = QSZ0_old(reg,zone,c,s);

 ACZ_input.L(reg,zone,c,type,s)    = ACZ_input0(reg,zone,c,type,s);
 YCZ_input.L(reg,zone,c,type,s)    = YCZ_input0(reg,zone,c,type,s);
 QSZ_input.L(reg,zone,c,type,s)    = QSZ_input0(reg,zone,c,type,s);
*JL: tried to add this to equations but solver failed
* QSZ_input_old.L(reg,zone,c,type,s)    = QSZ_input0_old(reg,zone,c,type,s);

 TQS.L(C,s)               = sum((reg,zone),QSZ0(reg,zone,c,s));
 TAC.L(C,s)               = sum((reg,zone),ACZ0(reg,zone,c,s));
 TACZ.L(reg,zone,s)       = sum(c,ACZ0(reg,zone,c,s));
 QM.L(C,s)                = QM0(C,S);
 QE.L(C,s)                = QE0(C,S);
 QT.L(C,s)                = QT0(C,S);

*$libinclude xldump ACZirr0 OrigAreas.xls Irri;

 totmargz.L(reg,zone,s)$sum(c,QFZ0(reg,zone,c,s)) = totmargZ0(reg,zone,s) ;

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
*add by ying
* GAPZ.L(reg,zone,c) =  gapZ0(reg,zone,c,s);
*====


EQUATIONS
 CPIEQ    CPI equation for annual
 QFZpcEQ  per capita Food demand equation by zone
 QFZHpcEQ  per capita Food demand equation by zone
 QFZEQ    Total Food demand equation by zone
 QLZEQ    Total Feed demand equation by zone
 QOZEQ    Total Other demand equation by zone
 QDZEQ    Total demand equation  by zone
* QDZEQ2    Total demand equation  by zone  *JL: old model evaluates the two Addis zones separately, but...
* QDZEQ3    Total demand equation  by zone  * ...there are now 10 zones, so I've lumped them with normal zones.
 ACZEQ    Area equation by crop and zone
 YCZEQ    Yield equation  by crop and zone
 QSZCREQ  supply equation for crop


 ACZ_inputEQ    Area equation by crop and zone
 YCZ_inputEQ1    Yield equation  by crop and zone For KcMean = 1 (water type)
 YCZ_inputEQ2    Yield equation  by crop and zone For KcMean < 1 (nonwater type)
 QSZ_inputEQ    supply equation for crop

 QSZNCREQ supply equation for noncrop
 QSZNAGEQ supply equation for nagntrade
 TACEQ    Total area by crop
 TACZEQ   total area by zone
 TQSEQ    total supply

 PCEQ      PC equation
 PCZEQ     PCZ equation
 PPZEQ     PPZ equation

 MARGEQ    total marging equation by zone
 GDPZRurPcEQ  per capita GDP equation by zone
 GDPZUrbPcEQ  per capita GDP equation by zone
 GDPZUrbPcEQ2  per capita GDP equation by zone
 GDPZHEQ  per capita GDP equation by zone
 GDPZpcEQ  per capita GDP equation by zone

 EXPTEQ    export define
 IMPTEQ    import define

 TRADEEQ   trade equation
 BALZEQ     commodity balance equation

*JL: added to capture difference between supply and production
* QSZCREQ_old new equation to account for pre-shifted supply
* QSZ_inputEQ_old  see below

*add by ying
*GAPZEQ     gap equation
*GAPZEQ2
*===
 ;


*===Equation defined
CPIEQ(s)..
CPI(s) =E= sum((reg,zone,c),PC.L(c,s)*QFZ0(reg,zone,c,s))/
         sum((reg,zone,c),PC0(c,s)*QFZ0(reg,zone,c,s)) ;


*QFZHpcEQ(reg,zone,urbrur,c)$QFZH0(reg,zone,urbrur,c,s)..
*   QFZHpc(reg,zone,urbrur,c,s) =E= afH(reg,zone,urbrur,c,s)*(PROD(CP$QFZH0(reg,zone,urbrur,cp),PCZ(reg,zone,cp)**edfpH(reg,zone,urbrur,c,cp)) *
*           (GDPZHpc(reg,zone,urbrur,s)/CPI)**edfiZH(reg,zone,urbrur,c,s)) ;

* == ying
QFZHpcEQ(reg,zone,urbrur,c,s)$(QFZH0(reg,zone,urbrur,c,s) and PCZ0(reg,zone,c,s) and GDPZHpc0(reg,zone,urbrur,s))..
   QFZHpc(reg,zone,urbrur,c,s) =E= afH(reg,zone,urbrur,c,s)*(PROD(CP$QFZH0(reg,zone,urbrur,cp,s),PCZ(reg,zone,cp,s)**edfpH(reg,zone,urbrur,c,cp,s)) *
           (GDPZHpc(reg,zone,urbrur,s)/CPI(s))**edfiZH(reg,zone,urbrur,c,s)) ;
*===

QFZEQ(reg,zone,c,s)$QFZ0(reg,zone,c,s)..
   QFZ(reg,zone,c,s) =E= sum(urbrur$QFZHpc0(reg,zone,urbrur,c,s),
     (QFZHpc(reg,zone,urbrur,c,s))*PopH(reg,zone,urbrur)) ;

 QFZpcEQ(reg,zone,c,s)$QFZ0(reg,zone,c,s)..
   QFZpc(reg,zone,c,s) =E= QFZ(reg,zone,c,s)/sum(urbrur,PopH(reg,zone,urbrur)) ;

QLZEQ(reg,zone,c,s)$QLZ0(reg,zone,c,s)..
   QLZ(reg,zone,c,s) =E= QLZshare(reg,zone,c,s)*sum(lv$QSZ0(reg,zone,lv,s),QSZ(reg,zone,lv,s))/PCZ(reg,zone,c,s) ;

QOZEQ(reg,zone,c,s)$QOZ0(reg,zone,c,s)..
   QOZ(reg,zone,c,s) =E= QOZshare(reg,zone,c,s)*QSZ(reg,zone,c,s)/PCZ(reg,zone,c,s) ;


* JL: not sure why Addis is separated here. New script below addresses all zones
*QDZEQ(Naddis,Naddiszone,c,s)$QDZ0(Naddis,Naddiszone,c,s)..
*   QDZ(Naddis,Naddiszone,c,s) =E= QFZ(Naddis,Naddiszone,c,s) + QLZ(Naddis,Naddiszone,c,s) + QOZ(Naddis,Naddiszone,c,s) ;
*
*QDZEQ2(c,s)$QDZ0('addisAbaba',zone,c,s)..
*   QDZ('addisAbaba',zone,c,s) =E= QFZ('addisAbaba',zone,c,s) + QLZ('addisAbaba',zone,c,s) + QOZ('addisAbaba',zone,c,s) ;
*
*QDZEQ2(c)$QDZ0('addisAbaba','addis1',c)..
*   QDZ('addisAbaba','addis1',c) =E= QFZ('addisAbaba','addis1',c) + QLZ('addisAbaba','addis1',c) + QOZ('addisAbaba','addis1',c) ;
*
*QDZEQ3(c)$(QDZ0('addisAbaba','addis2',c))..
*   QDZ('addisAbaba','addis2',c) =E= QFZ('addisAbaba','addis2',c) + QLZ('addisAbaba','addis2',c) + QOZ('addisAbaba','addis2',c) ;
*
QDZEQ(reg,zone,c,s)$QDZ0(reg,zone,c,s)..
   QDZ(reg,zone,c,s) =E= QFZ(reg,zone,c,s) + QLZ(reg,zone,c,s) + QOZ(reg,zone,c,s) ;


ACZ_inputEQ(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,s))..
  ACZ_input(reg,zone,c,type,s) =E= aaInput(reg,zone,c,type,s)*
   PROD(CP$QSZ_input0(reg,zone,cp,type,s),(PPZ(reg,zone,cp,s)/PPZ(reg,zone,'nagntrade',s))**eapInput(reg,zone,c,cp,type,s)) ;
*ACZ_inputEQ(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,s))..
*  ACZ_input(reg,zone,c,type,s) =E= aaInput(reg,zone,c,type,s)*
*   PROD(CP$QSZ_input0(reg,zone,cp,type,s),(PPZ(reg,zone,cp,s)/PPZ(reg,zone,'nagntrade',s))**eapInput(reg,zone,c,cp,type,s)) ;
*===== ying5  JL: irrigated so Ying assumes CYF = 1
YCZ_inputEQ1(reg,zone,c,wtype,s)$(ACZ_input0(reg,zone,c,wtype,s))..
  YCZ_input(reg,zone,c,wtype,s) =E= ayInput(reg,zone,c,wtype,s)*1*
             (PPZ(reg,zone,c,s)/PPZ(reg,zone,'nagntrade',s))**eypInput(reg,zone,c,wtype,s) ;

*  YCZ_input(reg,zone,c,wtype) =E= ayInput(reg,zone,c,wtype)*KcMean(reg,zone,c,s)*
*             (PPZ(reg,zone,c,s)/PPZ(reg,zone,'nagntrade'))**eypInput(reg,zone,c,wtype) ;
*=============
YCZ_inputEQ2(reg,zone,c,nwtype,s)$(ACZ_input0(reg,zone,c,nwtype,s))..
  YCZ_input(reg,zone,c,nwtype,s) =E= ayInput(reg,zone,c,nwtype,s)*KcMean(reg,zone,c,s)*
             (PPZ(reg,zone,c,s)/PPZ(reg,zone,'nagntrade',s))**eypInput(reg,zone,c,nwtype,s) ;

*JL: top is original equation, just added "old". Bottom is new equation to let model converge
QSZ_inputEQ(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,s))..
  QSZ_input(reg,zone,c,type,s) =E= YCZ_input(reg,zone,c,type,s)*ACZ_input(reg,zone,c,type,s)/1000;

*QSZ_inputEQ(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,s))..
*  QSZ_input(reg,zone,c,type,s) =E= ???????? ;

ACZEQ(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s))..
*ACZEQ(reg,zone,c,s)$(QSZ0_old(reg,zone,c,s) and ACZ0(reg,zone,c,s))..
*  ACZ(reg,zone,c,s) =E= aa(reg,zone,c,s)*PROD(CP$QSZ0(reg,zone,cp,s),(PPZ(reg,zone,cp)/PPZ(reg,zone,'nagntrade'))**eap(reg,zone,c,cp,s)) ;
*  ACZ(reg,zone,c,s) =E= ACZdry(reg,zone,c) + ACZirr(reg,zone,c);
  ACZ(reg,zone,c,s) =E= sum(type$ACZ_input0(reg,zone,c,type,s),ACZ_input(reg,zone,c,type,s)) ;

* ying3 - check this * YCZ
*YCZEQ(reg,zone,c,s)$ACZ0(reg,zone,c,s)..
YCZEQ(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s))..
*  YCZ(reg,zone,c,s) =E= ay(reg,zone,c,s)*KcMean(reg,zone,c,s)*(PPZ(reg,zone,c,s)/PPZ(reg,zone,'nagntrade',s))**eyp(reg,zone,c,s) ;
  YCZ(reg,zone,c,s) =E= 1000*sum(type$QSZ_input0(reg,zone,c,type,s),QSZ_input(reg,zone,c,type,s))/
                 sum(type$ACZ_input0(reg,zone,c,type,s),ACZ_input(reg,zone,c,type,s)) ;

QSZCREQ(reg,zone,c,s)$(QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s))..
  QSZ(reg,zone,c,s) =E= sum(type$QSZ_input0(reg,zone,c,type,s),QSZ_input(reg,zone,c,type,s));

*JL: added to incorporate production different from supply
*QSZCREQ_old(reg,zone,c,s)$(QSZ0_old(reg,zone,c,s) and ACZ0(reg,zone,c,s))..
*  QSZ_old(reg,zone,c,s) =E= sum(type$QSZ_input0_old(reg,zone,c,type,s),QSZ_input_old(reg,zone,c,type,s));

QSZNCREQ(reg,zone,c,s)$(NTR_NAG(c) and QSZ0(reg,zone,c,s) and ACZ0(reg,zone,c,s) eq 0)..
  QSZ(reg,zone,c,s) =E= as(reg,zone,c,s)*PROD(CP$QSZ0(reg,zone,cp,s),
              (PPZ(reg,zone,cp,s)/PPZ(reg,zone,'nagntrade',s))**esp(reg,zone,c,cp,s)) ;
*  QSZ(reg,zone,c,s) =E= as(reg,zone,c,s)*PROD(CP$QSZ0(reg,zone,cp,s),(PPZ(reg,zone,cp))**esp(reg,zone,c,cp,s)) ;

QSZNAGEQ(reg,zone,s)$QSZ0(reg,zone,'nagntrade',s)..
  QSZ(reg,zone,'nagntrade',s) =E= as(reg,zone,'nagntrade',s)*
             PROD(CP$QSZ0(reg,zone,cp,s),PPZ(reg,zone,cp,s)**(esp(reg,zone,'nagntrade',CP,s)-esp2(reg,zone,'nagntrade',CP,s))) ;

*QSZNAGEQ(reg,zone,nag)$QSZ0(reg,zone,nag)..
*  QSZ(reg,zone,nag) =E= as(reg,zone,nag)*
*             PROD(CP$QSZ0(reg,zone,cp,s),PPZ(reg,zone,cp)**(esp(reg,zone,nag,CP)-esp2(reg,zone,nag,CP))) ;

TACEQ(c,s)$TAC0(c,s)..
  TAC(c,s) =E= sum((reg,zone)$ACZ0(reg,zone,c,s),ACZ(reg,zone,c,s));

TACZEQ(reg,zone,s)$TACZ0(reg,zone,s)..
  TACZ(reg,zone,s) =E= sum(c$ACZ0(reg,zone,c,s),ACZ(reg,zone,c,s));

TQSEQ(c,s)$TQS0(c,s)..
  TQS(c,s) =E= sum((reg,zone)$QSZ0(reg,zone,c,s),QSZ(reg,zone,c,s));

PCEQ(c,s)..
*  PC(c,s) =E= (1 + margD(c,s)*(sum((reg,zone),QSZ0(reg,zone,'nagntrade',s)*PPZ(reg,zone,'nagntrade'))/
*                sum((reg,zone),QSZ0(reg,zone,'nagntrade',s)) ) )*PP(c,s) ;
  PC(c,s) =E= (1 + margD(c,s))*PP(c,s) ;

PCZEQ(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s))..
   PCZ(reg,zone,c,s) =E= (1 + PPZ(reg,zone,'nagntrade',s)*gapZ(reg,zone,c,s))*PC(c,s) ;
*   PCZ(reg,zone,c,s) =E= (1 + PPZ0(reg,zone,'nagntrade',s)*gapZ(reg,zone,c,s))*PC(c,s) ;
*   PCZ(reg,zone,c,s) =E= (1 + gapZ(reg,zone,c,s))*PC(c,s) ;

PPZEQ(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s))..
* PPZ(reg,zone,c,s) =E= PCZ(reg,zone,c,s)/(1 + PPZ(reg,zone,'nagntrade')*margZ(reg,zone,c,s) ) ;
* PPZ(reg,zone,c,s) =E= (1 + PPZ0(reg,zone,'nagntrade',s)*gapZ2(reg,zone,c,s))*PC(c,s)  ;
* PPZ(reg,zone,c,s) =E= (1 + PPZ(reg,zone,'nagntrade')*gapZ2(reg,zone,c,s))*PC(c,s)  ;
  PPZ(reg,zone,c,s) =E= (1 + PPZ(reg,zone,'nagntrade',s)*gapZ2(reg,zone,c,s))*PC(c,s)  ;
* because PP = PC in the model setup -Ying

chkPCZ0(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QFZ0(reg,zone,c,s)) = PPZ0(reg,zone,c,s) -
                PCZ0(reg,zone,c,s)/(1 + PPZ0(reg,zone,'nagntrade',s)*margZ0(reg,zone,c,s) ) ;

display chkPCZ0;


GDPZUrbPcEQ(Naddis,zone,s)$(GDPZH0(Naddis,zone,'urb',s))..
  GDPZHpc(Naddis,zone,'urb',s) =E=
         incomenagsh(Naddis,zone,'urb',s)*sum(nag$QSZ0(Naddis,zone,nag,s),
                                PPZ0(Naddis,zone,nag,s)*QSZ(Naddis,zone,nag,s))/(1000*PopH(Naddis,zone,'urb')) ;
*                                PPZ(Naddis,zone,nag)*QSZ(Naddis,zone,nag))/(1000*PopH(Naddis,zone,'urb')) ;

GDPZUrbPcEQ2(zone,s)$(GDPZH0('AddisAbaba',zone,'urb',s))..
  GDPZHpc('AddisAbaba',zone,'urb',s) =E=
*         sum(c$QSZ0('AddisAbaba',zone,c),PPZ('AddisAbaba',zone,c)*QSZ('AddisAbaba',zone,c))/(1000*PopH('AddisAbaba',zone,'urb')) ;
         sum(c$QSZ0('AddisAbaba',zone,c,s),PPZ0('AddisAbaba',zone,c,s)*QSZ('AddisAbaba',zone,c,s))/(1000*PopH('AddisAbaba',zone,'urb')) ;

GDPZRurPcEQ(Naddis,zone,'rur',s)$(GDPZH0(Naddis,zone,'rur',s))..
  GDPZHpc(Naddis,zone,'rur',s) =E=
  (incomenagsh(Naddis,zone,'rur',s)*sum(nag$QSZ0(Naddis,zone,nag,s),PPZ0(Naddis,zone,nag,s)*QSZ(Naddis,zone,nag,s))
  + sum(ag,PPZ0(Naddis,zone,ag,s)*QSZ(Naddis,zone,ag,s)) )/(1000*PopH(Naddis,zone,'rur')) ;


GDPZpcEQ(reg,zone,s)$GDPZ0(reg,zone,s)..
  GDPZpc(reg,zone,s) =E= sum(urbrur$GDPZH0(reg,zone,urbrur,s),GDPZHpc(reg,zone,urbrur,s)*(1000*PopH(reg,zone,urbrur)))/
                   (1000*sum(urbrur,PopH(reg,zone,urbrur))) ;


MARGEQ(reg,zone,s)$totmargZ0(reg,zone,s)..
 ToTmargz(reg,zone,s) =E= (sum(c$QFZ0(reg,zone,c,s),(PCZ(reg,zone,c,s) -
*           PPZ(reg,zone,c,s))*QFZ(reg,zone,c,s)) )/PPZ(reg,zone,'nagntrade') ;
           PPZ(reg,zone,c,s))*QFZ(reg,zone,c,s)) ) ;

BALZEQ(reg,zone,c,s)$(QSZ0(reg,zone,c,s) or QDZ0(reg,zone,c,s))..
*  QSZ(reg,zone,c,s) - DQEZ(reg,zone,c,s) + DQMZ(reg,zone,c,s) =E= QDZ(reg,zone,c,s) ;
  QSZ(reg,zone,c,s) + DQTZ(reg,zone,c,s) =E= QDZ(reg,zone,c,s) ;

*add by ying
*GAPZEQ(reg,zone,c)$(DQTZ0(reg,zone,c,s) ne 0)..
*GapZ(reg,zone,c,s) =E= DQTZ(reg,zone,c,s)/abs(DQTZ(reg,zone,c,s))*abs(GAPZint(reg,zone,c,s));

*GAPZEQ2(reg,zone,c)$(DQTZ0(reg,zone,c,s) eq 0)..
*GapZ(reg,zone,c,s) =E= abs(GAPZint(reg,zone,c,s));
*====

*===MCP equation
* JL: EXR removed as var and replaced with EXR0 parameter to balance eqns and vars (offsets addition of PP_rice)
EXPTEQ(C,s)$(not NTC2(c) and TQS0(c,s))..
* PP(C,S)/(1 - margW(c,s)) =G= EXR*PWE(c,s) ;
 PP(C,S)/(1 - margW(c,s)) =G= EXR0*PWE(c,s) ;

 QE.LO(c,s) = 0;
 QE.FX(ntc2,s) = 0;

IMPTEQ(C,s)$(not NTC2(c) and TQD0(c,s))..
* EXR*PWM(c,s)*(1 + margW(c,s)) =G= PC(C,S);
 EXR0*PWM(c,s)*(1 + margW(c,s)) =G= PC(C,S);

 QM.LO(c,s) = 0;
 QM.FX(ntc2,s) = 0;

TRADEEQ(c,s)$(TQS0(c,s) or TQD0(c,s))..
sum((reg,zone),QSZ(reg,zone,c,s)) + QM(C,S) - QE(c,s) =E= sum((reg,zone),QDZ(reg,zone,c,s)) ;


*=====================================================

 QFZHpc.FX(reg,zone,urbrur,c,s)$(QFZHpc0(reg,zone,urbrur,c,s) eq 0) = 0 ;
 QFZpc.FX(reg,zone,c,s)$(QFZpc0(reg,zone,c,s) eq 0) = 0 ;
 QFZ.FX(reg,zone,c,s)$(QFZ0(reg,zone,c,s) eq 0) = 0 ;
 QDZ.FX(reg,zone,c,s)$(QSZ0(reg,zone,c,s) eq 0 and QDZ0(reg,zone,c,s) eq 0) = 0 ;
 QSZ.FX(reg,zone,c,s)$(QSZ0(reg,zone,c,s) eq 0) = 0 ;
* QSZ_old.FX(reg,zone,c,s)$(QSZ0_old(reg,zone,c,s) eq 0) = 0 ;
 ACZ.FX(reg,zone,crop,s)$(QSZ0(reg,zone,crop,s) eq 0) = 0 ;
 YCZ.FX(reg,zone,crop,s)$(ACZ0(reg,zone,crop,s) eq 0) = 0 ;
 QLZ.FX(reg,zone,c,s)$(QLZ0(reg,zone,c,s) eq 0) = 0 ;
 QOZ.FX(reg,zone,c,s)$(QOZ0(reg,zone,c,s) eq 0) = 0 ;
 PCZ.FX(reg,zone,c,s)$(QSZ0(reg,zone,c,s) eq 0 and QFZ0(reg,zone,c,s) eq 0) = PCZ0(reg,zone,c,s) ;
 PPZ.FX(reg,zone,c,s)$(QSZ0(reg,zone,c,s) eq 0 and QFZ0(reg,zone,c,s) eq 0) = PPZ0(reg,zone,c,s) ;
 PP.FX(c,s)$(TQS0(c,s) eq 0 or TQD0(c,s) eq 0)           = PP0(c,s) ;
 DQEZ.FX(reg,zone,c,s)$(DQEZ0(reg,zone,c,s) eq 0) = 0 ;
 DQMZ.FX(reg,zone,c,s)$(DQMZ0(reg,zone,c,s) eq 0) = 0 ;

 QSZ_input.FX(reg,zone,c,type,s)$(QSZ_input0(reg,zone,c,type,s) eq 0) = 0 ;
* QSZ_input_old.FX(reg,zone,c,type,s)$(QSZ_input0_old(reg,zone,c,type,s) eq 0) = 0 ;
 ACZ_input.FX(reg,zone,c,type,s)$(ACZ_input0(reg,zone,c,type,s) eq 0) = 0 ;
 YCZ_input.FX(reg,zone,c,type,s)$(YCZ_input0(reg,zone,c,type,s) eq 0) = 0 ;

 GDPZHpc.FX(reg,zone,urbrur,s)$(GDPZH0(reg,zone,urbrur,s) eq 0) = 0 ;

 QE.FX(c,s)$(TQS0(c,s) eq 0) = 0 ;
 QM.FX(c,s)$(TQD0(c,s) eq 0) = 0 ;

*CPI.FX                  = CPI.L ;
 DUMMY.FX(reg,zone,c,s) = 0 ;
*DUMMY.L('AddisAbaba','Addis2','nagtrade') = 0.0001 ;
*DUMMY.UP('AddisAbaba','Addis2','nagtrade') = +INF ;
*DUMMY.LO('AddisAbaba','Addis2','nagtrade') = -INF ;

*PP.FX('nagtrade') = PP0('nagtrade');

*=====================================================
*display edfpH, PCZ0;
*$exit  ;
*execute_unload "results_ACZ_input0.gdx" ACZ_input0
*execute 'gdxxrw.exe results_ACZ_input0.gdx o=results_ACZ_input0.xls par=ACZ_input0'
*execute_unload "results_ACZ0.gdx" ACZ0
*execute 'gdxxrw.exe  results_ACZ0.gdx o=results_ACZ0.xls par=ACZ0'
*execute_unload "results_ZeroQSZ_input0.gdx" ZeroQSZ_input0
*execute 'gdxxrw.exe results_ZeroQSZ_input0.gdx o=results_ZeroQSZ_input0.xls par=ZeroQSZ_input0'
*execute_unload "results_ACZ.gdx" ACZ
*execute 'gdxxrw.exe results_ACZ.gdx o=results_ACZ.xls var=ACZ'
*execute_unload "results_ACZ_input.gdx" ACZ_input
*execute 'gdxxrw.exe results_ACZ_input.gdx o=results_ACZ_input.xls var=ACZ_input'
*execute_unload "results_QSZ_input.gdx" QSZ_input
*execute 'gdxxrw.exe results_QSZ_input.gdx o=results_QSZ_input.xls var=QSZ_input'
*execute_unload "results_QSZ.gdx" QSZ
*execute 'gdxxrw.exe results_QSZ.gdx o=results_QSZ.xls var=QSZ'
*$ontext
MODEL  MultiMkt  Multi market model for Ethiopia
/
*ALL
 CPIEQ.CPI
 QFZHpcEQ.QFZHpc
 QFZpcEQ.QFZpc
 QFZEQ.QFZ
 QLZEQ.QLZ
 QOZEQ.QOZ
 QDZEQ.QDZ
* QDZEQ2 *JL: see note above. These are left over from when Addis zones were calculated separately
* QDZEQ3
 ACZEQ.ACZ
 YCZEQ.YCZ
 QSZ_inputEQ.QSZ_input
 ACZ_inputEQ.ACZ_input
 YCZ_inputEQ1.YCZ_input
 YCZ_inputEQ2.YCZ_input
 QSZCREQ.QSZ
 QSZNCREQ.QSZ
 QSZNAGEQ
 TACEQ.TAC
 TACZEQ.TACZ
 TQSEQ.TQS
 PCEQ.PC
 PCZEQ.PCZ
 PPZEQ.PPZ
 BALZEQ.DQTZ
 MARGEQ.ToTMARGZ
 GDPZUrbPcEQ
 GDPZUrbPcEQ2
 GDPZRurPcEQ
 GDPZpcEQ
 EXPTEQ.QE
 IMPTEQ.QM
 TRADEEQ
*add by ying
*GAPZEQ.GAPZ
*GAPZEQ2.GAPZ
*===
/;

OPTIONS  ITERLIM =100000, RESLIM = 1000000,

LIMROW = 10000,
LIMCOL = 10000,
*SOLPRINT = Off ,
SOLPRINT = On ,
DOMLIM=0 ;

multimkt.holdfixed = 1;
*multimkt.optfile    = 1;


* ying3 - remove '*' below
SOLVE MULTIMKT USING MCP;
display QM.L, QE.L,PWE0,PWM0,PP0, PC0 ;

*ying3
display CPI.L, QFZHpc.L, PCZ.L;

parameter
chkTQFNEW(c,s)
chkTQSNEW(c,s)
chkPPNEW(c,s)
chkBAL(c,s)
chkQFZHNEW(reg,zone,urbrur,c,s)
;
chkPPNEW(c,s)$PP0(c,s) = PP.L(c,s)/PP0(c,s);
chkTQFNEW(c,s) = TQF0(c,s) - sum((reg,zone),QFZ.L(reg,zone,c,s));
chkTQSNEW(c,s) = TQS0(c,s) - sum((reg,zone),QSZ.L(reg,zone,c,s));
chkBAL(c,s) = SUM((reg,zone),QSZ.L(reg,zone,c,s)) - QE.L(c,s) + QM.L(c,s) - sum((reg,zone), QFZ.L(reg,zone,c,s) + QLZ.L(reg,zone,c,s) + QOZ.L(reg,zone,c,s)) ;
chkQFZHNEW(reg,zone,urbrur,c,s) = QFZHpc0(reg,zone,urbrur,c,s) - QFZHpc.L(reg,zone,urbrur,c,s) ;


display chkPPNEW,chkTQFNEW, chkTQSNEW, chkBAL, chkQFZHnew, ACZirrSh0, kc_mean, kcmean;

Execute_Unload 'tmp.gdx',PC,PP,PPZ,PCZ,QFZ,QFZpc,QFZHpc,QLZ,QOZ,QDZ,ACZ,YCZ,QSZ,ACZ_input,YCZ_input,QSZ_input,TQS,TAC,TACZ,
GDPZpc,GDPZHpc,CPI,EXR,DQTZ,QM,QE;
*Execute_Unload 'tmp.gdx',PC,PP,PPZ,PCZ,QFZ,QFZpc,QFZHpc,QLZ,QOZ,QDZ,ACZ,YCZ,QSZ,ACZ_input,YCZ_input,QSZ_input,TQS,TAC,TACZ,
*GDPZpc,GDPZHpc,CPI,DQTZ,QM,QE;
Execute 'GDXXRW.EXE tmp.gdx O=caliouputBASE.xls index=INDEX!a1';

* Add: save=save\caliBASE gdx=caliBASE during calibration to save output
*       then run simulation.gms and add: r=save\caliBASE save=save\sim gdx=sim

*$offtext






