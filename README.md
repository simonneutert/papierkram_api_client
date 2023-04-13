# Papierkram API Client<!-- omit in toc -->

[![Ruby](https://github.com/simonneutert/papierkram_api_client/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/simonneutert/papierkram_api_client/actions/workflows/main.yml)

Der erste ~~illegale~~ inoffizielle API Client in [Ruby](https://www.ruby-lang.org/de/) für [Papierkram.de](https://www.papierkram.de)!

<img src="pac.svg" alt="PAC Logo, Zunge leckt an Karl Klammer und zieht Daten aus dem Papierkram-Account wie Frosch die Fliege vom Teich" width="300">

**WICHTIG** Dieses Projekt befindet sich im Entwicklungsstatus bis V1.0.0! Ich werde versuchen, die Änderungen so gut wie möglich zu dokumentieren. Wenn du einen Fehler findest, kannst du gerne einen Issue erstellen oder einen Pull Request mit einer Verbesserung erstellen. Ich freue mich über jede Hilfe!

> 🚨 **Bitte beachte**, dass DU UNBEDINGT die Requests/Responses (VCR Cassettes) von privaten Daten befreien musst, bevor du einen Pull Request erstellst oder einen Commit ins Web lädst! Ich werde die Cassettes auch nochmal durchgehen, bevor ich die Version 1.0.0 veröffentliche. ABER BITTE, BITTE, BITTE, mach das selbst auch! Ich habe keine Lust, dass irgendwelche Daten von dir oder deinen Kunden auf Github landen. Danke! 🙏

Check das [CHANGELOG.md](CHANGELOG.md), Baby!

 Hier geht es zu den offiziellen API Docs  
https://DEINE-SUBDOMAIN.papierkram.de/api/v1/api-docs/index.html  
(wenn du bereits ein Papierkram-Konto hast).  
Schau bitte dort um alle Rückgabefelder/-werte zu checken, bis ich die Dokumentation hier komplett habe.

---

Ruby client für die Papierkram API (V1).

Aktuell unterstützte Endpunkte / Objekte:

- [x] Banking::BankConnection
- [ ] Banking::BankTransaction
- [x] Contact::Company (Unternehmen)
- [x] Contact::Company (Kontaktpersonen)
- [x] Expense::Voucher (Ausgabe Belege)
- [x] Income::Estimate (Angebote)
- [x] Income::Invoice (Rechnungen)
- [x] Income::Proposition (Waren / Dienstleistungen)
- [x] Info
- [x] Project (Projekte)
- [x] Tracker::Task (Aufgaben)
- [x] Tracker::TimeEntry (Zeiterfassung)

## Was, wie, warum?<!-- omit in toc -->

Papierkram.de hat nun endlich eine API Schnittstelle für die Programmierung von eigenen Anwendungen. Die Dokumentation findest du hier: [https://DEINE-SUBDOMAIN.papierkram.de/api/v1/api-docs/index.html](https://DEINE-SUBDOMAIN.papierkram.de/api/v1/api-docs/index.html). Dieses Projekt soll eine einfache Schnittstelle für die Papierkram API bereitstellen.

Ziele:

- Eine einfache als Gem verfügbare Schnittstelle für die Papierkram API.
- Rückgabe von Hashes, Arrays, etc. statt von komplexeren Objekten (der gefürchtete DIY-Ansatz).
- Einfach zu testen und zu erweitern.

---

- [Installation](#installation)
- [Schnellstart](#schnellstart)
- [API Client](#api-client)
  - [Initialisierung](#initialisierung)
  - [Banking::BankConnection (Bankverbindung)](#bankingbankconnection-bankverbindung)
    - [alle Bankverbindungen](#alle-bankverbindungen)
    - [eine Bankverbindung](#eine-bankverbindung)
  - [Banking::Transaction (Kontoumsatz)](#bankingtransaction-kontoumsatz)
  - [Contact::Company (Unternehmen)](#contactcompany-unternehmen)
    - [alle Unternehmen](#alle-unternehmen)
    - [ein Unternehmen](#ein-unternehmen)
  - [Contact::Company (Kontaktperson eines Unternehmens)](#contactcompany-kontaktperson-eines-unternehmens)
    - [alle Kontaktpersonen (eines Unternehmens)](#alle-kontaktpersonen-eines-unternehmens)
    - [eine Kontaktperson (eines Unternehmens)](#eine-kontaktperson-eines-unternehmens)
  - [Expense::Voucher (Ausgabe Beleg)](#expensevoucher-ausgabe-beleg)
    - [alle Ausgabe Belege](#alle-ausgabe-belege)
    - [einen Ausgabe Beleg](#einen-ausgabe-beleg)
    - [einen Ausgabe Beleg als PDF](#einen-ausgabe-beleg-als-pdf)
  - [Income::Estimate (Angebot)](#incomeestimate-angebot)
    - [alle Angebote](#alle-angebote)
    - [ein Angebot](#ein-angebot)
    - [ein Angebot als PDF](#ein-angebot-als-pdf)
  - [Income::Invoice (Rechnung)](#incomeinvoice-rechnung)
    - [alle Rechnungen](#alle-rechnungen)
    - [eine Rechnung](#eine-rechnung)
    - [eine Rechnung als PDF](#eine-rechnung-als-pdf)
  - [Income::Proposition (Waren / Dienstleistungen)](#incomeproposition-waren--dienstleistungen)
    - [alle Waren / Dienstleistungen](#alle-waren--dienstleistungen)
    - [eine Ware / Dienstleistung](#eine-ware--dienstleistung)
  - [Info](#info)
  - [Project::Project (Projekt)](#projectproject-projekt)
    - [alle Projekte](#alle-projekte)
    - [ein Projekt](#ein-projekt)
  - [Tracker::Task (Aufgabe)](#trackertask-aufgabe)
    - [alle Aufgaben](#alle-aufgaben)
  - [Tracker::TimeEntry (Zeiteintrag)](#trackertimeentry-zeiteintrag)
    - [alle Zeiteinträge](#alle-zeiteinträge)
    - [einen Zeiteintrag](#einen-zeiteintrag)
  - [Verbleibendes Quota](#verbleibendes-quota)
- [Helpers](#helpers)
  - [Generiere ein PDF aus Response](#generiere-ein-pdf-aus-response)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add papierkram_api_client

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install papierkram_api_client

## Schnellstart

1. Repository klonen
2. `bundle install`
3. `bin/console`

```ruby
# client instanziieren

# wenn ENV gesetzt sind (siehe Readme)
client = PapierkramApiClient::Client.new

# ODER per Variablen
client = PapierkramApiClient::Client.new('subdomain', "YOUR-API-KEY");

# info Endpunkt abfragen
info_details = client.info.details
puts info_details.headers
puts info_details.body

# erste Seite von "allen Rechnungen" abfragen
invoices = client.income_invoices.all(page: 1, page_size: 5)
puts invoices.headers
puts invoices.body
```

## API Client

Der API Client ist die Hauptklasse für die Kommunikation mit der Papierkram API. Er wird mit den Zugangsdaten initialisiert.

[Client](/lib/papierkram_api_client.rb)

Wenn du etwas hinter die Kulissen sehen willst, schau dir diese [Faraday](https://github.com/lostisland/faraday) Klasse an [Faraday::Response](https://github.com/lostisland/faraday/blob/main/lib/faraday/response.rb).


### Initialisierung

Entweder werden die Zugangsdaten als Argumente übergeben:

```ruby
# usage with subdomain and api key
client = PapierkramApiClient::Client.new('subdomain', "SUPER-LONG-API-KEY")
```

Oder es werden die Umgebungsvariablen `PAPIERKRAM_SUBDOMAIN` und `PAPIERKRAM_API_KEY` gesetzt und der Client ohne Argumente initialisiert.

```ruby
# usage with environment variables
client = PapierkramApiClient::Client.new
```

### Banking::BankConnection (Bankverbindung)

Der Endpunkt `/api/v1/banking/bank_connections` liefert Informationen über die Bankverbindungen. Die Informationen werden als `Faraday::Response` zurückgegeben.

[BankConnections](/lib/api/v1/banking/bank_connections.rb)

#### alle Bankverbindungen

```ruby
bank_connections = client.banking.bank_connections.all
puts bank_connections.headers
puts bank_connections.body
```

```ruby
# body
{
  "type"=>"list",
  "page"=>1,
  "page_size"=>100,
  "total_pages"=>1,
  "total_entries"=>1,
  "has_more"=>false,
  "entries"=>[
    { "type"=>"bank_connection",
      "id"=>4,
      "name"=>"Standard" }
  ]
}
```

#### eine Bankverbindung

```ruby
bank_connection = client.banking.bank_connections.by(id: 1)
puts bank_connection.headers
puts bank_connection.body
```

```ruby
# body
{
  "type"=>"bank_connection",
  "id"=>4,
  "name"=>"Standard",
  "account_no"=>nil,
  "account_type"=>"default",
  "bic"=>nil,
  "blz"=>nil,
  "connection_type"=>"default",
  "created_at"=>"2019-12-31T13:29:19.000+01:00",
  "customer_id"=>nil,
  "hbci"=>nil,
  "hbci_host_url"=>nil,
  "hbci_version"=>nil,
  "primary"=>nil,
  "title"=>"Standard",
  "updated_at"=>"2020-11-03T10:31:56.000+01:00",
  "user_id"=>nil,
  "iban"=>""
}
```

### Banking::Transaction (Kontoumsatz)

WORK IN PROGRESS

[Transactions](/lib/api/v1/banking/transactions.rb)

### Contact::Company (Unternehmen)

Der Endpunkt `/api/v1/contact/companies` liefert Informationen über die Unternehmen. Die Informationen werden als `Faraday::Response` zurückgegeben.

[Companies](/lib/api/v1/contact/companies.rb)

#### alle Unternehmen

```ruby
companies = client.contact.companies.all
puts companies.headers
puts companies.body
```

#### ein Unternehmen

```ruby
company = client.contact.companies.by(id: 1)
puts company.headers
puts company.body
```

### Contact::Company (Kontaktperson eines Unternehmens)

Der Endpunkt `/api/v1/contact/companies/{company_id}` liefert Informationen über die Kontaktpersonen. Die Informationen werden als `Faraday::Response` zurückgegeben.

#### alle Kontaktpersonen (eines Unternehmens)

```ruby
companies = client.contact.companies_persons.all(company_id: 1)
puts companies.headers
puts companies.body
```

#### eine Kontaktperson (eines Unternehmens)

```ruby
company = client.contact.companies_persons.by(company_id: 1, id: 1)
puts company.headers
puts company.body
```

### Expense::Voucher (Ausgabe Beleg)

Der Endpunkt `/api/v1/expense/vouchers` liefert Informationen über die Ausgabe Belege. Die Informationen werden als `Faraday::Response` zurückgegeben.

[Vouchers](/lib/api/v1/expense/vouchers.rb)

#### alle Ausgabe Belege

```ruby
vouchers = client.expense.vouchers.all
puts vouchers.headers
puts vouchers.body
```

#### einen Ausgabe Beleg

```ruby
voucher = client.expense.vouchers.by(id: 1)
puts voucher.headers
puts voucher.body
```

#### einen Ausgabe Beleg als PDF

```ruby
voucher = client.expense.vouchers.by(id: 1, pdf: true)
puts Api::V1::Helpers::PdfFromResponse.new(voucher).to_pdf 
# => {response: Faraday::Response, path_to_pdf_file: 'path/to/tempfile_pdf.pdf'}
```

### Income::Estimate (Angebot)

Der Endpunkt `/api/v1/income/estimates` liefert Informationen über die Angebote. Die Informationen werden als `Faraday::Response` zurückgegeben.

[Estimates](/lib/api/v1/income/estimates.rb)

#### alle Angebote

```ruby
estimates = client.income.estimates.all
puts estimates.headers
puts estimates.body
```

#### ein Angebot

```ruby
estimate = client.income.estimates.by(id: 1)
puts estimate.headers
puts estimate.body
```

#### ein Angebot als PDF

```ruby
estimate = client.income.estimates.by(id: 1, pdf: true)
puts Api::V1::Helpers::PdfFromResponse.new(estimate).to_pdf 
# => {response: Faraday::Response, path_to_pdf_file: 'path/to/tempfile_pdf.pdf'}
```

### Income::Invoice (Rechnung)

Der Endpunkt `/api/v1/income/invoices` liefert Informationen über die Rechnungen. Die Informationen werden als `Faraday::Response` zurückgegeben.

[Invoices](/lib/api/v1/income/invoices.rb)

#### alle Rechnungen

```ruby
invoices = client.income.invoices.all
puts invoices.headers
puts invoices.body
```

#### eine Rechnung

```ruby
invoice = client.income.invoices.by(id: 1)
puts invoice.headers
puts invoice.body
```

#### eine Rechnung als PDF

```ruby
invoice = client.income.invoices.by(id: 1, pdf: true)
puts Api::V1::Helpers::PdfFromResponse.new(invoice).to_pdf 
# => {response: Faraday::Response, path_to_pdf_file: 'path/to/tempfile_pdf.pdf'}
```

### Income::Proposition (Waren / Dienstleistungen)

Der Endpunkt `/api/v1/income/propositions` liefert Informationen über die Waren / Dienstleistungen. Die Informationen werden als `Faraday::Response` zurückgegeben.

[Propositions](/lib/api/v1/income/propositions.rb)

#### alle Waren / Dienstleistungen

```ruby
propositions = client.income.propositions.all
puts propositions.headers
puts propositions.body
```

#### eine Ware / Dienstleistung

```ruby
proposition = client.income.propositions.by(id: 1)
puts proposition.headers
puts proposition.body
```

### Info

Der Endpunkt `/api/v1/info` liefert Informationen über die API. Die Informationen werden als `Faraday::Response` zurückgegeben.

[Info](/lib/api/v1/info.rb)

```ruby
info = client.info.details
puts info.headers
puts info.body
```

### Project::Project (Projekt)

Der Endpunkt `/api/v1/projects` liefert Informationen über die Projekte. Die Informationen werden als `Faraday::Response` zurückgegeben.

[Projects](/lib/api/v1/projects.rb)

#### alle Projekte

```ruby
projects = client.projects.all
puts projects.headers
puts projects.body
```

#### ein Projekt

```ruby
project = client.projects.by(id: 1)
puts project.headers
puts project.body
```

### Tracker::Task (Aufgabe)

Der Endpunkt `/api/v1/tracker/tasks` liefert Informationen über die Aufgaben. Die Informationen werden als `Faraday::Response` zurückgegeben.

#### alle Aufgaben

```ruby
tasks = client.tracker.tasks.all
puts tasks.headers
puts tasks.body
```

### Tracker::TimeEntry (Zeiteintrag)

Der Endpunkt `/api/v1/tracker/time_entries` liefert Informationen über die Zeiteinträge. Die Informationen werden als `Faraday::Response` zurückgegeben.

[TimeEntries](/lib/api/v1/tracker/time_entries.rb)

#### alle Zeiteinträge

```ruby
time_entries = client.tracker.time_entries.all
puts time_entries.headers
puts time_entries.body
```

#### einen Zeiteintrag

```ruby
time_entry = client.tracker.time_entries.by(id: 1)
puts time_entry.headers
puts time_entry.body
```

### Verbleibendes Quota

Jede API Anfrage "kostet" 1 Quota. Das Quota wird bei jedem Request aktualisiert. Um das verbleibende Quota zu erhalten, kann die Methode `remaining_quota` aufgerufen werden.

[Base](/lib/api/v1/base.rb)

Du kannst dein Quota über die Papierkram Webseite einsehen. Die Anzahl der verbleibenden Anfragen wird dir dort angezeigt.

Oder nach jeder Anfrage per Client:

```ruby
# `client.info` ist nur eine Möglichkeit, es kann jeder andere Endpoint verwendet werden ✌️
response = client.info.details
quota = client.info.remaining_quota(response)
```

## Helpers

Es gibt einige Helper, die dir das Leben leichter machen.

### Generiere ein PDF aus Response

Mit dem Helper `Api::V1::Helpers::PdfFromResponse` kannst du für unterstützte Endpunkte aus einer `Faraday::Response` ein PDF schreiben.

Unterstützte Endpunkte sind beispielsweise: `Income::Estimate`, `Income::Invoice`, `Expense::Voucher`.

[Api::V1::Helpers::PdfFromResponse](/lib/api/v1/helpers/pdf_from_response.rb)

```ruby
response = client.income.invoices.by(id: 1, pdf: true)
pdf = Api::V1::Helpers::PdfFromResponse.new(response).to_pdf("Rechnung Nummer XXX")
puts pdf
```

```ruby
# value of `pdf`
{
  response: Faraday::Response,
  path_to_pdf_file: 'path/to/temp/Rechnung Nummer XXX.pdf'
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/simonneutert/papierkram_api_client.

Bitte achte darauf, dass du die Tests ausführst und die Tests dann auch grün sind 🤓

🚨 **SEHR WICHTIG!** Dein API Key wird in den Tests verwendet werden. **Bitte achte darauf**, dass du den API Key nicht in deinen Commits hast! Wenn du per Environment Variable arbeitest, dann wird dein API Key **nicht von VCR aufgezeichnet**. Das bedeutet, dass du deine Tests nicht mit deinem API Key ausführen solltest. ⚠️

🚨 **NOCH WICHTIGER!** deine Kundendaten, also Klarnamen, E-Mails und Telefonnummern haben hier nichts verloren! Bitte sorge dafür, dass du deine Tests mit einem Testaccount ausführst. 🙏 ODER editiere deine Kundendaten in den *VCR Cassettes* nach dem Test. 🙏

Wenn du unsicher bist, sprich mich an oder erstelle ein Issue. Ich helfe dir gerne weiter. 🤗

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
