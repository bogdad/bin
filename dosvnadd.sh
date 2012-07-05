svn status | grep ? | tr -s [:space:] | cut -d' ' -f2 | xargs svn add
