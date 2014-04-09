prowl
=====

Lasso 9 Prowl API


Description
-----------

Wrapper for the Prowl iPhone notification API. Allows you to send messages from Lasso to your iPhone via Push notifications. Requires the iPhone Prowl app to receive the notifications. (see http://bit.ly/17moncj ) 

More info on Prowl: http://www.prowlapp.com/api.php

NOTE: this is a Lasso 9 port of Lieven Gekiere's SHp_prowl tag for Lasso 8.5 (http://tagswap.net/SHp_prowl)

Sample Usage
------------
```lasso

local(test = prowl)
#test->apikey = 'XXX'
#test->update(-event='testing 1',-description='this is using the new api',-application='Lasso 9')
```
