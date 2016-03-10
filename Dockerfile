FROM busybox:1.24-glibc

COPY phantomjs /usr/bin/phantomjs
COPY usr/lib /usr/lib

CMD ["-v"]
ENTRYPOINT ["/usr/bin/phantomjs"]
