# RaspberryPiセットアップスクリプト

## スクリプトの導入  
RaspberryPiにログインする  
```$
ID:pi  
PASS:raspberry  
```
  
### Gitからcloneする  
Gitをインストールする  
`$ sudo apt-get update`  
`$ sudo apt-get install git`  
セットアップスクリプトをcloneする  
`$ git clone https://github.com/hirazakura/pi_setup.git`  
  
## 使い方  
セットアップスクリプトのフォルダに移動  
`$ cd pi_setup`  
スクリプトに権限をつける  
`$ chmod +x pi_setup.sh`  
スクリプトの実行  
`$ ./pi_setup.sh`  
  
### セットアップ１  
`raspi-config`の初期設定  
#### セットアップ番号を選ぶ（１）  
```
setup number:1  
Ready?? >> （エンター）
```
  
SDカードの使われていない領域を使えるようにする（以下の順で選択）  
`7 Advanced Options -> Expand Filesystem ... -> OK`  
タイムゾーンを設定（以下の順で選択）  
`4 Localisation Options -> Change Timezone -> Asia -> Tokyo -> OK`  
ssh設定（以下の順で選択）  
`5 Interfacing Options -> P2 SSH -> Yes -> OK`  
Finishを選択し終了する  
`Finish`  
  
### セットアップ2  
本体アップデートとVimのインストール  
#### セットアップ番号を選ぶ（2）  
```
setup number:2
Ready?? >> （エンター）  
```
  
### セットアップ3  
ネットワークの設定(固定IPの設定)
#### セットアップ番号を選ぶ（3）  
```
setup number:3  
Ready?? >> （エンター）  
```
  
ipアドレスを設定（例192.168.11.10）  
固定IPの入力  
`What ipaddress? : 192.168.11.10/24(ipアドレスを入力)`  
デフォルトゲートウェイの入力  
`What Default gateway? :192.168.11.1`  
DNSの入力  
`What DNS? : 192.168.11.1`  
  
### セットアップ4  
Wi-Fiの設定
#### セットアップ番号を選ぶ（4）  
```
setup number:4  
Ready?? >> （エンター）  
```
  
ルータのSSIDの登録  
`What SSID? : SSIDの入力`  
ルータのパスワードを入力  
`What PASS? : パスワードの入力`  
  
### セットアップ5  
新しいユーザーの作成  
#### セットアップ番号を選ぶ（5）  
```
setup number:5  
Ready?? >> （エンター）  
```
  
作成したいユーザー名の登録  
`What user name? :ユーザー名を入力`  
  
```
Adding user `username' ...  
Adding new group `username' (1001) ...  
Adding new user `username' (1001) with group `username' ...  
Creating home directory `/home/username' ...  
Copying files from `/etc/skel' ...  
Enter new UNIX password:（新しくパスワードを入力する）  
Retype new UNIX password:（再びパスワードを入力する）  
passwd: password updated successfully  
Changing the user information for username  
Enter the new value, or press ENTER for the default  
Full Name :（空欄のままエンターを入力する）  
Room Number :（空欄のままエンターを入力する）  
Work Phone :（空欄のままエンターを入力する）  
Home Phone :（空欄のままエンターを入力する）  
Other []:（空欄のままエンターを入力する）  
Is the information correct? [Y/n] y（yを入力する）  
```
  
### セットアップ完了後  
以下のIDでログイン  
```
ID:新しいユーザー名  
Pass:新しいパスワード  
```

piユーザを削除  
`$ sudo userdel -r pi`  

シャットダウン  
`$ sudo shutdown -h now`  

電源を抜く
