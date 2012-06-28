#!/bin/sh
SRC_HOME=`pwd`
BIN_DIR="$SRC_HOME/src/main/bin"
mkdir $SRC_HOME/target/tmp
echo $BIN_DIR/java-with-classpath-local.sh  -Djava.io.tmpdir=$SRC_HOME/target/tmp ru.yandex.startrek.Main "$@"
exec $BIN_DIR/java-with-classpath-local.sh  -Djava.io.tmpdir=$SRC_HOME/target/tmp ru.yandex.startrek.Main "$@"

# vim: set ts=4 sw=4 et:
