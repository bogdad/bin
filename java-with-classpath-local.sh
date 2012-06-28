#!/bin/sh -e

export JAVA_HOME=/usr/local/java7

exec $JAVA_HOME/bin/java -server -showversion \
    -classpath '/home/vshakhov/src/startrek/lib/bundles/*:/home/vshakhov/src/startrek/lib/jars/*:/home/vshakhov/src/startrek/target/jars:/home/vshakhov/src/startrek/target/classes:/home/vshakhov/src/startrek/src/main/java' \
    -Dfile.encoding=UTF-8 \
    -javaagent:/usr/lib/yandex/startrek/lib/org.aspectj-aspectjweaver-1.6.12.jar \
    "$@"

# vim: set ts=4 sw=4 et:
