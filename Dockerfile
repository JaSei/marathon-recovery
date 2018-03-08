FROM avastsoftware/perl-extended

WORKDIR /app
COPY cpanfile /app/
COPY recovery.pl /app/

RUN cpanm --installdeps .

ENTRYPOINT ["perl", "/app/recovery.pl"]
