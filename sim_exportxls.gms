* Use this file to choose which outputs to save to Excel


Execute_Unload 'tmp1.gdx',PCX,PPX,PPZX,PCZX,QFZX,QFZpcX,QFZHpcX,QLZX,QOZX,QDZX,ACZX,YCZX,QSZX,ACZ_inputX,YCZ_inputX,QSZ_inputX,TQSX,TACX,TACZX,
GDPZpcX,GDPZHpcX,CPIX,EXRX,DQTZX,QMX,QEX,GDPX,AgGDPX,NAgGDPX,CALpcX,TCALpcX;
Execute 'GDXXRW.EXE tmp1.gdx O=simoutputY.xls index=INDEX!a1';

*Execute_Unload 'tmp1.gdx',PoPpoorZX,PoPpoorHX,PoPpoorX,PoorLineAllX,PoorLineHX;
*Execute 'GDXXRW.EXE tmp1.gdx O=simoutput_poverty_7Dec21fcst2.xls index=INDEX!a1';

*Execute_Unload 'tmp1.gdx',TCALZPCX;
*Execute 'GDXXRW.EXE tmp1.gdx O=simoutput_tcalzpc_7Dec21fcst2.xls index=INDEX!a1';
