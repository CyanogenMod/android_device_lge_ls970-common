#!/system/xbin/bash
BD_CONFIG=/data/misc/bluedroid/bt_config.xml
BD_ADDR_FILE=/persist/bluetooth/.bdaddr

if [ ! -e $BD_ADDR_FILE ]
then
BTCONFIGADDR=$(cat "$BD_CONFIG" | sed -n -e 's/.*<N1 Tag\=\"Address\" Type\=\"string\">\(.*\)<\/N1>.*/\1/p')
BTMAC=$(echo "$BTCONFIGADDR" | sed s/://g)
echo $BTMAC
HEXMAC=""
i=1
testexpr=0
substr=""
while [ $i -lt 13  ]; do
testexpr=`expr $i % 2` 
echo $testexpr
substr=`expr substr $BTMAC $i 1`
if [ $testexpr -eq 1 ]; then
HEXMAC=$HEXMAC"\\x$substr"
else
HEXMAC=$HEXMAC"$substr"
fi
i=`expr $i + 1`
done
echo -n -e $HEXMAC > $BD_ADDR_FILE
fi
