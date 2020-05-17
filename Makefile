os_type := $(shell uname -s)
db_name := typo3_mfc_corporate
export_url_dev := export.mfc-corporate.web-factory.de
export_url_live := export.mfc-corporate.web-factory.de
export USER_ID=$(shell id -u)
export GROUP_ID=$(shell id -g)

ifeq ($(os_type),Linux)
	export CURRENT_HOST_ADDRESS=172.17.0.1
endif
ifeq ($(os_type),Darwin)
	export CURRENT_HOST_ADDRESS=docker.for.mac.localhost
    zcat_expansion = .Z
endif



all:
	make start
	make repo
	make pipeline
	gnome-terminal -- sh -c "make serve"

serve:
	symfony serve

new-tab:
	gnome-terminal --tab

install:
	npm install

push:
	git add .
	@read -p "Enter commit message:" MESSAGE; \
	git commit -m $$MESSAGE
	git push
	git status

start:
	xdg-open "https://127.0.0.1:8080"
api:
	xdg-open "https://putzplan-admin.herokuapp.com/api"
make android:
	quasar dev -m cordova -T android
make ios:
	quasar dev -m cordova -T android
make windows:
	quasar build -m electron
make mac:
	quasar dev -m electron
