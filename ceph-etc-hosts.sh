cat |sudo tee -a /etc/hosts <<EOL
# Ceph cluster
192.168.99.40 ansible.local
192.168.99.41 mon1.local
192.168.99.42 rgw1.local
192.168.99.43 rgw2.local
192.168.99.51 osd1.local
192.168.99.52 osd2.local
192.168.99.53 osd3.local
EOL


id_rsa.pub ceph-admin
cat >>.ssh/authorized_keys <<EOL
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEI0q3unmn2maCsZBq6TWUyCEfCvNqlCAEd6mAhSG/YcfdjFihcJAMoswX9xPXHb8lRBealKyfVwSZkjXQKIRUGBDTM4tw1GxSnwny4NbOl5AV5F9LUzcVee1aujkEwSTRtxGaIpo4ezRuanUpB4uiTHFbUzYvOn/3TJnxu4WB3Jj6iLWwym91x4L6GG6ol9vdFp2NM7QXw8aDqybxKYvg+GoUErzPgmSbzZMwMASFF/zvFICfDL4bU6KmYMEtGQZNN9gRzLOTkOqyvd4oGOuMwEhjYmJliiNPpu9Uw0oN6Mu4soavqRK1bOlMZ18UDa8cYs0LF+xf5PJAP97wCVz5 ceph-admin@ansible
EOL
chmod 600 .ssh/authorized_keys

id_rsa.pub ansible@vagrant
cat >>.ssh/authorized_keys <<EOL
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBixPveO5PDjOSI47v4djmAsGus0o5SAzp9Pq72YjQu9Hcqb7VmSUR4NZloCWceG0IrY/0L4/7GU6r3TDV3Q7dd0rAWuSsbvtBFVd/FFFmHTd6ST0v6ErvGpDWrsymoFyY6Xx3ZYnMlbvhkfRt2ITzdcVqv3NQ3DJkWie8odgsbUDgMU+3HlBMQ3lxRxiFGT9WM8u3zHWYwzYjlqVSti8Ubu2vs0aC7GMSDk5cb0yUtYfxPTAHXmY0SQ8Ss9YSWesnkqCnvvYjX32Xu9KDVxgImmNX7UGxhXUSJG7BWDeauKJZaoH+YCjnUy3Ech9l0GS5uLHgjZqzVN/G8N+PzRfv vagrant@ansible
EOL

Create the ceph-ansible user
export USER_NAME="ceph-admin"
export USER_PASS="aR3@llyStrOngP@ssw0rd"
sudo useradd --create-home -s /bin/bash ${USER_NAME}
echo "${USER_NAME}:${USER_PASS}"|sudo chpasswd
echo "${USER_NAME} ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/${USER_NAME}
sudo chmod 0440 /etc/sudoers.d/${USER_NAME}

cat >> /home/ceph-admin/.ssh/config <<EOL
Host mon1
  Hostname mon1
  User ceph-admin
Host rgw1
  Hostname rgw1
  User ceph-admin
Host rgw2
  Hostname rgw2
  User ceph-admin
Host osd1
  Hostname osd1
  User ceph-admin
Host osd2
  Hostname osd2
  User ceph-admin
Host osd3
  Hostname osd3
  User ceph-admin
EOL

cat >> /home/vagrant/.ssh/config <<EOL
Host mon1.local
  Hostname mon1
  User vagrant
Host rgw1.local
  Hostname rgw1
  User vagrant
Host rgw2.local
  Hostname rgw2
  User vagrant
Host osd1.local
  Hostname osd1
  User vagrant
Host osd2.local
  Hostname osd2
  User vagrant
Host osd3.local
  Hostname osd3
  User vagrant
EOL

