# virtualbox_vm_setup


This is just a small role to help setup a new RHEL 7 vm in virtual box with my personal settings.

## Requirements


Run this with `-b` and make sure the home directories are correct. I'll clean this up another time to use a default user and set up dirs based on the host type.


## Role Variables


| var | default | description |
| --- | --- | --- |
| `rh_pass` | `vault_rh_pass` | Points to the password for subcription manager. Need to have a vaulted password to use, probably in `~/group_vars/all`. |
| `pool_ids` | `vault_pool_ids` | Pool ids to subscribe to. Employee pool id. |

## Dependencies


* galaxy role : geerlingguy.repo-epel
* Needs a vaulted file with the password for subscription manager. A good spot for this is `~/group_vars/all`.



## License


GPL-3.0

## Author Information

James Mighion
jmighion@redhat.com
