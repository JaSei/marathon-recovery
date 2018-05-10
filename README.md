# marathon-recovery
simple script for recovery `/apps` json dump

## how to use?

### docker way
```
docker build -t marathon-recovery .
cat marathon.json | docker run -i marathon-recovery --url http://my-marathon.host.com -
```

### perl way
```
perl recovery.pl --url http://my-marathon.host.com marathon.json
```
