Minion
==============

Overview
========

This is a Salt_ formula for managing the /etc/salt/minion config file (specifically roles) from the salt master.

pillar.example file:
```minion:
  hostname: salt.domain.com
  sample.domain.com:
    roles:
      - role1
      - role2
      - role3
 ```
Define each Salt client's roles as seen in the example above. If changes take place, this formula restarts the salt-minion service. If the hostname is not defined, no changes will take place. 
You must also define your salt master on the hostname line. 
