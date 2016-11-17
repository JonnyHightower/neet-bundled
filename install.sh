#!/bin/bash

export NEET=/opt/neet
export CONFIDR="${NEET}/etc"
export VERSION=`cat VERSION`
export INST="${PWD}"

if [ ! -d "$NEET" ]; then
	echo "Couldn't find neet installation. Exiting."
	exit 1
fi

. ${NEET}/core/installsupport

if [ ! -z $INVOKEDBYNEETUPDATE ] && [ $INVOKEDBYNEETUPDATE -eq 1 ]; then
	FILESTOREMOVE=""
	for file in $FILESTOREMOVE; do
		rm -f "$file"
	done
	echo "   + Installing neet bundled package updates..."
	#######################################################

	for bin in iShellSQL ms08-067_check.py ndr.py ndr.pyc sadmindcmd.pl SQLaddaccount wkhtmltoimage wkhtmltoimage-amd64; do
		cp content/$bin "${NEET}/pkg/bin/$bin"
		#echo "$bin=${NEET}/pkg/bin/$bin" >> "${CONFDIR}/locations"
		newLocation "$bin" "${NEET}/pkg/bin/$bin"
		chmod 755 "${NEET}/pkg/bin/$bin"
	done

	echo -n "   + "
	# Nikto
	PkgInstall nikto Nikto
	# TestSSL
	PkgInstall testssl TestSSL

	#######################################################
	newVersion neet-bundled $VERSION
else
	echo "This package is for the neet-update script and should not be installed manually."
	exit 1
fi

exit 0



