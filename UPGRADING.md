## From 0.2 to 0.3

Finding specific records has changed. Instead of `by(id: 123)` you now use `find_by(id: 123)`.

```ruby
banking_transaction = client.banking_transactions.find_by(id: 123)
```

