#!/bin/sh

BIN_DIR=`cd $(dirname $0); pwd`
echo $BIN_DIR/java-with-classpath-local.sh  -Djava.io.tmpdir=/var/tmp ru.yandex.startrek.Main "$@"
exec $BIN_DIR/java-with-classpath-local.sh  -Djava.io.tmpdir=/var/tmp ru.yandex.startrek.Main "$@"

# vim: set ts=4 sw=4 et:
