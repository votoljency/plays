#!/bin/bash
#ansible all -m ansible.builtin.user -a "name=automation groups=wheel" -u root
#ansible all -m ansible.builtin.file -a "path=/home/automation/.ssh state=directory mode=0700 owner=automation group=automation" -u root
#ansible all -m authorized_key -a "user=automation state=present key='{{ lookup('file', '/home/automation/.ssh/id_rsa.pub') }}'" -u root
#ansible all -m lineinfile -a "path=/etc/sudoers state=present regexp='^#%wheel' line='%wheel ALL=(ALL:ALL) NOPASSWD: ALL' validate='visudo -cf %s'" -u root

ansible proxy -m ansible.builtin.user -a "name=automation  state=absent remove=yes" -u panicjens   --ask-pass  --become    
ansible proxy -m ansible.builtin.user -a "name=automation  groups=wheel append=yes password={{ '\$6\$UaKM8h.thextb3TQ\$EmXSnlwo/9r4D4f26Ffk1/IPZNBicWWm93EEd6LqRsUEphpaf/ieTJlPQuaIaee42j2Jx7GAk9bzzM8vhNe/O.' }}" -u panicjens   --ask-pass  --become    
ansible   --user='panicjens' --become   -m ansible.builtin.authorized_key -a "user=automation key=present key='{{ lookup('file', '/home/automation/.ssh/id_rsa.pub') }}'"    proxy   --ask-pass       
#ansible ipaserver -m ansible.builtin.lineinfile -a "path=/etc/sudoers state=present regexp='^# %wheel       ALL=(ALL)      NOPASSWD: ALL' line='%wheel ALL=(ALL) NOPASSWD: ALL' validate='/usr/sbin/visudo -cf %s'" -u vagrant --ask-pass --become
#ansible proxy -m ansible.builtin.copy -a "dest=/etc/sudoers.d/20automation content='automation ALL=(ALL) NOPASSWD: ALL'" -u panicjens  --become  --ask-pass  --ask-become-pass
#ansible ipaserver -m ansible.builtin.copy -a "dest=/etc/sudoers.d/10vagrant content='vagrant ALL=(ALL) NOPASSWD: ALL'" -u vagrant  --become   --ask-become-pass