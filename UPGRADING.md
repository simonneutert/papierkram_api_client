## From 0.3 to 0.4

Some endpoints are calling `update` have changed. Instead of `update_by(id: 123, attributes: { ... })` you now use keywords e.g. `update_by(id: 123, name: 'New name')`.

Please check the [CHANGELOG](CHANGELOG.md) for more details.

- Income::Propositions
- Projects
- Contact::Companies

## From 0.2 to 0.3

Finding specific records has changed. Instead of `by(id: 123)` you now use `find_by(id: 123)`.

```ruby
banking_transaction = client.banking_transactions.find_by(id: 123)
```

