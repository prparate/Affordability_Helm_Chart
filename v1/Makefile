.PHONY: help
help:		## Displays the help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: save
save:		## Saves the given helm chart from the directory. [required: APP=${app} DIR=${dir}; optional: VERSION=${version}]
	@version=$$VERSION ; 	 \
	if [[ -z $$version ]] ;  \
	then  					 \
		version="1.0.0" ;  	 \
	fi ; 					 \
	./scripts/bash/helm.sh save $$version $$APP $$DIR

.PHONY: push
push:		## Pushes the given helm chart. [required: APP=${app}; optional: VERSION=${version}]
	@version=$$VERSION ;     \
	if [[ -z $$version ]] ;  \
	then 				     \
		version="1.0.0" ;    \
	fi ;				     \
	./scripts/bash/helm.sh push $$version $$APP

.PHONY: export
export:		## Exports the given helm chart to the desired directory. [required: APP=${app} DIR=${dir}; optional: VERSION=${version}]
	@version=$$VERSION ;     \
	if [[ -z $$version ]] ;  \
	then                     \
		version="1.0.0" ;    \
	fi ;                     \
	./scripts/bash/helm.sh export $$version $$APP $$DIR

.PHONY: pull
pull:		## Pulls the given helm chart. [required: APP=${app}; optional: VERSION=${version}]
	@version=$$VERSION ; 	 \
	if [[ -z $$version ]] ;  \
	then  					 \
		version="1.0.0" ; 	 \
	fi ; 					 \
	./scripts/bash/helm.sh pull $$version $$APP