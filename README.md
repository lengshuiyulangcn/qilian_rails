### How to run on local dev

1. rake db:drop && rake db:migrate && rake db:seed

2. rails s puma

### How to import data

```
#rails c
irb> load('import.rb')
```



