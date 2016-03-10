FROM busybox:1.24-glibc

COPY phantomjs /usr/bin/phantomjs
COPY usr/lib /usr/lib
COPY usr/share/fonts/ /usr/share/fonts/
COPY etc/fonts/ /etc/fonts/

CMD ["-v"]
ENTRYPOINT ["/usr/bin/phantomjs"]
