# global service name
SERVICE                 := termhub-www-files

#######################################################################
#                 OVERRIDE THIS TO MATCH YOUR PROJECT                 #
#######################################################################

# Most applications have their own method of maintaining a version number.
# Override this command to populate the
APP_VERSION             := $(shell cat version.txt)

# Builds should be repeatable, therefore we need a method to reference the git
# sha where a version came from.
GIT_VERSION          	?= $(shell echo `git describe --match=NeVeRmAtCh --always --dirty`)
GIT_COMMIT          	?= $(shell echo `git log | grep -m1 -oE '[^ ]+$'`)
GIT_COMMITTED_AT        ?= $(shell echo `git log -1 --format=%ct`)
GIT_BRANCH				?=
ENV                     ?= local
FULL_VERSION            := v$(APP_VERSION)-g$(GIT_VERSION)

install:
	/bin/rm -rf /var/www/html/files/*
	/bin/rm -rf /var/www/html/images/*
	zip -r /var/www/html/www.zip files images
	echo "A" | unzip /var/www/html/www.zip -d /var/www/html
	/bin/rm -f /var/www/html/www.zip
	cp version.txt /var/www/html/files/version.txt
