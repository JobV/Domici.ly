# Domici.ly

Domici.ly runs on:
- ruby 2.1.1
- redis
- postgres (sqlite in dev, but should be changed to just use pg)


To run the tests:
```
bundle exec rake test
```

To keep running the tests:
```
bundle exec guard -p -c
```

Run the server:

```
foreman start -f Profile_dev
```

## Deploy

Just merge into the production branch. Should be deployed automatically, instantly.
