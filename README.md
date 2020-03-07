# Raspberrypi openvpn repeater
### These instructions aim to use raspberrypi as intermediate device for repeating unrestricted internet while having openvpn server on any cloud service provider.
---
## Instructions:
### <b>1. </b>Create a raspberrypi repeater :
1. To do the same, follow any of the guides as described [here](https://github.com/akss13/Raspberrypi-repeater).
2. Add additional routing rules above any existing routing rules:<br>
```bash
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
```
+ If iptables rule are being load from a file, then follow these instrucitons:
```bash
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -X
```
+ Then re-add the routing rules in order by adding the above described rule first.


### <b>2. </b>Create a openvpn server :
+ Install openvpn on raspberrypi:
```bash
sudo apt install openvpn
```
+  To create a openvpn server on any cloud service provider use this script [angristan](https://github.com/angristan/openvpn-install).
+ <b>Case-1:</b> If the internet connection you are using does not restricts access to any ports:
   + Select all the default options provided in the script.  
   + Import the file to raspberrypi.
   + Run openvpn through CLI:
   ```bash
   sudo openvpn filename.ovpn
   ```
   + Change settings in <b>/etc/resolv.conf</b> file:
   ```bash
   nano /etc/resolv.conf
   ```
   + Comment all the lines in the file and add:
   ```bash
   nameserver 8.8.8.8
   ```

+ <b>Case-2:</b> If the internet connection you are using restricts access to any ports:  
   + Select <b>tcp</b> when prompted while creating the openvpn server
   + Import the file to raspberrypi.
   + Add the following lines to the <b>.ovpn</b> file just above <b>verb 3</b>:
   ```bash
    route 162.243.166.99 255.255.255.255 net_gateway
    socks-proxy 127.0.0.1 8008
   ```
   + Here <b>162.243.166.99</b> is your server's IP.
   + Open a ssh tunnel:
   ```bash
   ssh -D 8008 root@162.243.166.99 -p 443
   ```
   + Here <b>443</b> is the port on which you can ssh your server. You can change or add ports in <b>/etc/ssh/sshd_config</b> as per your requirement.
   + Run openvpn through CLI:
   ```bash
   sudo openvpn filename.ovpn
   ```
   + Change settings in <b>/etc/resolv.conf</b> file:
   ```bash
   nano /etc/resolv.conf
   ```
   + Comment all the lines in the file and add:
   ```bash
   nameserver 8.8.8.8
   ```




