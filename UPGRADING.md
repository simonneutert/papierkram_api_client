## From 0.4.2 onwards

`vat_rate` attribute of line_items, were Strings, like "19%", but the public API of Papierkram changed and expects Floats/Decimals like `0.19`. Please update your code accordingly.

**Create an invoice:**

see [Invoices#create](lib/papierkram_api/v1/endpoints/income/invoices.rb) for possible params.

```ruby
invoice = client.income_invoices.create(
  name: 'Neuausstattung des Büros',
  supply_date: '01.01.2024 - 14.01.2024',
  document_date: '2024-01-15',
  payment_term_id: 46,
  customer_id: 3,
  project_id: 15,
  line_items: [
    {
      name: 'Anlieferung',
      description: 'Anlieferung der neuen Möbel',
      quantity: 1.25,
      unit: 'Stunden',
      vat_rate: 0.19, # << here >>
      price: 100
    },
    {
      name: 'Bestuhlung',
      description: 'Bestuhlung des Bürogebäudes',
      quantity: 1.25,
      unit: 'Arbeitstage',
      vat_rate: 0.19, # << here >>
      price: 800
    },
    {
      name: 'Büroartikel',
      description: 'Neue Bürostühle',
      quantity: 200,
      unit: 'Stühle',
      vat_rate: 0.19, # << here >>
      price: 125
    }
  ]
)
```

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

