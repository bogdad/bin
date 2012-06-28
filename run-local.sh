#!/bin/sh
SRC_HOME=`pwd`
mkdir $SRC_HOME/target/tmp
java-with-classpath-local.sh  -Djava.io.tmpdir=$SRC_HOME/target/tmp ru.yandex.startrek.Main "$@"
java-with-classpath-local.sh  -Djava.io.tmpdir=$SRC_HOME/target/tmp ru.yandex.startrek.Main "$@"

# vim: set ts=4 sw=4 et:
