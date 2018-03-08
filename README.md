# marathon-recovery
simple script for recovery `/apps` json dump

## how to use?

### docker way
```
docker build -t marathon-recovery .
cat marathon.json | docker run marathon-recovery --url my-marathon.host.com -
```

### perl way
```
perl recovery.pl --url my-marathon.host.com marathon.json
```
