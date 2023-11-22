
````
anton@work:~/code/work/docker/kamailio-docker> docker exec  -it sip_dev_kamailio_dev bash
root@work:/# kamc
kamcmd  kamctl  
root@work:/# kamc
kamcmd  kamctl  
root@work:/# kamdbctl create
-e \E[37;33mINFO: creating database kamailio ...
-e \E[37;33mINFO: Core Kamailio tables successfully created.
Install presence related tables? (y/n): y
-e \E[37;33mINFO: creating presence tables into kamailio ...
-e \E[37;33mINFO: Presence tables successfully created.
Install tables for imc cpl siptrace domainpolicy carrierroute
                drouting userblocklist htable purple uac pipelimit mtree sca mohqueue
                rtpproxy rtpengine secfilter? (y/n): y
-e \E[37;33mINFO: creating extra tables into kamailio ...
-e \E[37;33mINFO: Extra tables successfully created.

````