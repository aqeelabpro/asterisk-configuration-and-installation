# Enabling Asterisk ARI
Edit the `ari.conf` configuration file to enable ARI and define user credentials. 
Typically located in `/etc/asterisk/ari.conf`.

```ini
[general]
enabled = yes
pretty = yes
allowed_origins=http://ari.asterisk.org ; can be set to * to allow from any ip

;create a user in ari.conf
[ari_user]
type = user
read_only = no ; access any resource
password = YourStrongPassword
password_format = plain ; can be set to crypt if you want to use crypted password, like password_format=crypt


[general]
enabled=yes
bindaddr=0.0.0.0 ; 
bindport=8088

; Example Dialplan, using Stasis Application
[ARI_EXAMPLE]
exten => 1000,1,NoOp()
 same => n,Answer()
 same => n,Stasis(hello-world) ; will create a hello-world application when using wscat, i.e wscat -c 'ws://<ASTERISK_SERVER_IP or localhost>:<PORT>/ari/events?api_key=<ARI_USER>:<ARI_USER_PASSWORD>&app=hello-world'
 same => n,Hangup()

 ;Playback with ari
;curl -v -u ari_user:ari_password -X POST "http://localhost:9211/ari/channels/<ChannlelID>/play?media=sound:hello-world"
 curl -v -u asterisk:asterisk -X POST "http://localhost:9211/ari/channels/<ChannlelID>/play?media=sound:hello-world"

 ;ACCESS SWAGGER UI
 To acees Swagger UI goto http://ari.asterisk.org/ if you have http otherwise goto https, there you have to put http://<IP>:<port defined in http.conf>/ari/api-docs/resources.json and then api key which is combination of username:password of ari, like if ari user is ari and password is 1234 then api key would be ari:1234 and just hit explore button and you will be able to access Swagger UI