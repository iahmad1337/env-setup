# Setting up home-server

```bash
sudo apt install openssh-server

# test that it works & exit
systemctl status sshd.service  # enabled
ssh localhost

# All of the sshd configuration is located at /etc/ssh.
# Do a copy of default config
cp /etc/ssh/sshd_config ./sshd_config_default
```

Then, uncomment and adjust the following settings:
```
Port <random port you've chosen>
PermitRootLogin no
PubkeyAuthentication yes

ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
```
Add the public key to ~/.ssh/authorized_keys

Then, restart the service and check that you can login in a local network
```bash
# on server
ip a  # look for something like 192.168.* - this is the local address

# on the laptop
ssh -p<ssh port> <user>@<local ip>
```

# Security
First, we install and configure ufw ([guide](https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29)):
```bash
sudo su
apt install ufw
ufw enable
ufw allow <ssh port>/tcp
```
Also, according to this [guide](https://selectel.ru/blog/ssh-ubuntu-setup/), you
can disable all incoming connections and enable all outgoing:
```bash
ufw default deny incoming
ufw default allow outgoing
ufw reload
```
And the result is
```
root@localhost:/# ufw status verbose
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), deny (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
<ssh port>/tcp                  ALLOW IN    Anywhere
<ssh port>/tcp (v6)             ALLOW IN    Anywhere (v6)
```

# Setting up static ip
First, get a white IP from ISP.
There's no single working tutorial, but a set of articles that I followed:
- https://www.cyberciti.biz/faq/add-configure-set-up-static-ip-address-on-debianlinux/
- https://habr.com/ru/articles/579924/
- https://wiki.debian.org/NetworkConfiguration

## 1. Set up static ip for server in LAN

### [FAIL] 1.a Set up on server
Link: https://www.cyberciti.biz/faq/add-configure-set-up-static-ip-address-on-debianlinux/
```bash
# backup
cp /etc/network/interfaces ./interfaces_backup
```
Write the following lines to /etc/network/interfaces:
```
auto wlp8s0
iface wlp8s0 inet static
    address 192.168.0.196
    netmask 255.255.255.0
    gateway 192.168.0.1  # router IP
    dns-nameservers 192.168.0.1  # router IP but can also be google/cloudflare DNS
```
Syntax:
https://unix.stackexchange.com/questions/128439/good-detailed-explanation-of-etc-network-interfaces-syntax
& `man 5 interfaces`.
### [SUCCESS] 1.b Set up on router
for d-link, go to `Connections Setup -> Lan -> Static IP Addresses` and assign
the server MAC address to a fixed IP

## [TBD] 2. Forward router port to machine port
- Instructions for all models: https://portforward.com/router.htm
In my case: Firewall -> Virtual Servers -> Add - there, do something like this https://mobileproxy.space/en/pages/how-to-configure-port-forwarding-in-d-link.html

Still didn't work :( ssh only works when all computers are on the same home
network


# Links:
- https://askubuntu.com/questions/430853/how-do-i-find-my-internal-ip-address
- https://www.reddit.com/r/debian/comments/14kssxo/do_i_need_fail2ban/
- https://wiki.archlinux.org/title/OpenSSH#Server_usage
- Precisely what I needed: https://habr.com/ru/articles/579924/
