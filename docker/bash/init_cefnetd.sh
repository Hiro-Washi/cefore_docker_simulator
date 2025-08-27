sudo sysctl -w net.core.rmem_default=10000000
sudo sysctl -w net.core.wmem_default=10000000
sudo sysctl -w net.core.rmem_max=10000000
sudo sysctl -w net.core.wmem_max=10000000

#sudo rm /tmp/cef_9896.0
sudo cefnetdstop -F
sleep 1
sudo csmgrdstop
sleep 1
sudo csmgrdstart
sleep 1

echo "env NODE_TYPE: $NODE_TYPE"
if [ $1 -eq "unknown" ]; then
    sudo cefnetdstart
elif [ "$#" -eq 0 ]; then
    sudo cefnetdstart
elif [ $1 = "router" ]; then
    sudo cefnetdstart -d r_cefnetd.conf
elif [ $1 = "producer" ]; then
    sudo cefnetdstart -d p_cefnetd.conf
elif [ $1 = "consumer" ]; then
    sudo cefnetdstart -d c_cefnetd.conf
else
    sudo cefnetdstart 
fi

echo "DO TEST: sudo cefputfile ccnx:/test -f Readme.md"
