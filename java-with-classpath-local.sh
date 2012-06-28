#!/bin/sh -e

export JAVA_HOME=/usr/local/java7
SRC_HOME=`pwd`
exec $JAVA_HOME/bin/java -server -showversion \
    -classpath "$SRC_HOME/lib/bundles/*:$SRC_HOME/lib/jars/*:$SRC_HOME/target/jars:$SRC_HOME/target/classes:$SRC_HOME/src/main/java" \
    -Dfile.encoding=UTF-8 \
    -javaagent:$SRC_HOME/lib/jars/org.aspectj-aspectjweaver-1.6.12.jar \
    "$@"

# vim: set ts=4 sw=4 et:
