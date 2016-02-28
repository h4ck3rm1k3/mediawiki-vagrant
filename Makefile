#sudo mkdir /vagrant
#sudo useradd vagrant
#sudo mkdir /home/vagrant
#sudo chown vagrant:vagrant /home/vagrant

## https://docs.hhvm.com/hhvm/installation/linux#debian-8-jessie
# sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
# echo deb http://dl.hhvm.com/debian jessie main | sudo tee /etc/apt/sources.list.d/hhvm.list
# sudo apt-get update
# sudo apt-get install hhvm

runpuppet: # -v -d
	sudo puppet apply  \
	./puppet/manifests/site.pp \
	--modulepath ./puppet/modules \
	--hiera_config ./puppet/hiera.yaml \
	--config_version ./puppet/extra/config-version \
	--logdest /tmp/puppet.test.log \
	--logdest console \
	--write-catalog-summary \
	--detailed-exitcodes \
	--color=false
#	--nocolor \
