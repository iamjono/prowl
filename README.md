prowl
=====

Lasso 9 Prowl API


Description
-----------

Wrapper for the Prowl iPhone notification API. Allows you to send messages from Lasso to your iPhone via Push notifications. Requires the iPhone Prowl app to receive the notifications. (see http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=320876271 ) 
More info on Prowl: http://prowl.weks.net

NOTE: this is a Lasso 9 port of Lieven Gekiere's SHp_prowl tag for Lasso 8.5 (http://tagswap.net/SHp_prowl)

Sample Usage
------------
```
local(p = prowl)
#p->apikey = 'XXX'
#p->application = 'Lasso 9'
 
#p->update('Hello, this is a test.')
```
