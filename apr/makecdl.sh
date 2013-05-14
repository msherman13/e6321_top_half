perl v2lvs.pl top_level
#perl v2lvs.m.pl lfsr1
#perl -e "s/\n/test/g" -p -i lfsr1*cdl;
#perl -e "s/test\+ //g" -p -i lfsr1*cdl;
#perl -e "s/test/\n/g" -p -i lfsr1*cdl;
#perl -e "s/.GLOBAL VDD//g" -p -i lfsr1*cdl;
#perl -e "s/.GLOBAL VSS//g" -p -i lfsr1*cdl;
#perl -e "s/XDECAP.*//g" -p -i lfsr1*cdl;
#perl -e "s/gnd [0-9][0-9][0-9][0-9] vdd [0-9][0-9][0-9][0-9]/gnd gnds vdd vdds/g" -p -i lfsr1*cdl;
#perl -e "s/vdds gnds vdd gnd/gnd gnds vdd vdds/g" -p -i lfsr1*cdl;
