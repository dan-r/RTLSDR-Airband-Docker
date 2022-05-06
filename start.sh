#!/bin/bash
if [ ! -f /config/rtl_airband.conf ]
then
    cp /rtl_airband.conf.sample /config/rtl_airband.conf
fi

/bin/rtl_airband -c /config/rtl_airband.conf -F
