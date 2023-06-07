# Скрипт для запуска ноды для майнинга токенов NKN:

cat << "EOF"
================================================================================
Введите Ваш Адрес NKN кошелька.
Полученный на wallet.nkn.org
================================================================================
Адрес кошелька NKN:
EOF
# Input beneficiary wallet adddress
read -r benaddress

apt update -y
apt purge needrestart -y
apt-mark hold linux-image-generic linux-headers-generic openssh-server snapd
apt upgrade -y
apt -y install unzip vnstat htop screen mc

username="nkn"
config="https://nknrus.ru/config.tar"

useradd -m -p "pass" -s /bin/bash "$username" > /dev/null 2>&1
usermod -a -G sudo "$username" > /dev/null 2>&1

printf "Загрузка........................................... "
cd /home/$username > /dev/null 2>&1
wget --quiet --continue --show-progress https://commercial.nkn.org/downloads/nkn-commercial/linux-amd64.zip > /dev/null 2>&1
printf "Готово!\n"

printf "Установка............................................ "
unzip linux-amd64.zip > /dev/null 2>&1
mv linux-amd64 nkn-commercial > /dev/null 2>&1
chown -c $username:$username nkn-commercial/ > /dev/null 2>&1
/home/$username/nkn-commercial/nkn-commercial -b $benaddress -d /home/$username/nkn-commercial/ -u $username install > /dev/null 2>&1
printf "Готово!\n"
printf "sleep 180"

sleep 180

DIR="/home/$username/nkn-commercial/services/nkn-node/"

systemctl stop nkn-commercial.service > /dev/null 2>&1
sleep 20
cd $DIR > /dev/null 2>&1
rm config.json > /dev/null 2>&1
rm -Rf ChainDB > /dev/null 2>&1
wget -O - "$config" -q --show-progress | tar -xf -
chown -R $username:$username config.* > /dev/null 2>&1
printf "Загрузка.......................................... Готово!\n"
systemctl start nkn-commercial.service > /dev/null 2>&1
