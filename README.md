# Deprecated / Unmaintained

This package is no longer maintained as of 2026-05-26.

Existing versions remain available on rubygems.org for compatibility, but no new features, bug fixes, or security fixes are planned.

Please migrate away, replace it, or fork it under a new package name.

---

# Papierkram API Client<!-- omit in toc -->

[![Ruby](https://github.com/simonneutert/papierkram_api_client/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/simonneutert/papierkram_api_client/actions/workflows/main.yml)

Der erste ~~illegale~~ inoffizielle API Client in [Ruby](https://www.ruby-lang.org/de/) für [Papierkram.de](https://www.papierkram.de) als [Gem](https://rubygems.org/gems/papierkram_api_client) für dein Projekt!

<div align="center">
  <img src="logo.svg" alt="PAC Logo, Zunge leckt an Karl Klammer und zieht Daten aus dem Papierkram-Account wie Frosch die Fliege vom Teich" width="300">
</div>

---

**Aufruf zur Mitarbeit für NodeJS/JavaScript 🫠**  
Das Gleiche, nur in grün, also für [NodeJS ein Papierkram Api Client](https://github.com/simonneutert/papierkram-api-client) 😬

---

**WICHTIG** Dieses Projekt befindet sich im Entwicklungsstatus bis V1.0.0! Ich werde versuchen, die Änderungen so gut wie möglich zu dokumentieren. Wenn du einen Fehler findest, kannst du gerne einen Issue erstellen oder einen Pull Request mit einer Verbesserung erstellen. Ich freue mich über jede Hilfe!

> 🚨 **Bitte beachte**, dass DU UNBEDINGT die Requests/Responses der VCR Cassettes (die ausschliesslich bei Nutzung der Testsuite angelegt werden) von privaten Daten befreien musst, bevor du einen Pull Request erstellst oder einen Commit ins Web lädst! Ich werde die Cassettes auch nochmal durchgehen, bevor ich die Version 1.0.0 veröffentliche. ABER BITTE, BITTE, BITTE, mach das selbst auch! Ich habe keine Lust, dass irgendwelche Daten von dir oder deinen Kunden auf Github landen. Danke! 🙏

Check das [CHANGELOG.md](CHANGELOG.md), Baby!  
Schau in [UPGRADING.md](UPGRADING.md), 💃🕺!

Hier geht es zu den [offiziellen API Docs](https://demo.papierkram.de/api/v1/api-docs/index.html).  
Schau bitte dort um alle Rückgabefelder/-werte zu checken, bis ich (oder du mit deiner Zeit und Hingabe) die Dokumentation hier komplett habe.

**WENN DU PROBLEME HAST,** bitte ich dich erstmal die [offiziellen API Docs](https://demo.papierkram.de/api/v1/api-docs/index.html) zu durchstöbern. Dann lohnt es sich hier die Beispiele (weiter unten) zu lesen und von dort sowohl mal in die Methoden im Code zu springen, oder noch besser in die Tests schauen.  
Wenn du dann immer noch nicht weiterkommst, kannst du gerne einen Issue erstellen. Poste dabei so viele Informationen wie möglich, damit ich dir bestmöglich weiterhelfen kann. Achte dabei bitte darauf, dass du keine privaten Daten postest. 🙏

---

## Aktuell unterstützte Endpunkte der Papierkram API (V1)<!-- omit in toc -->

- [x] Banking::BankConnection
- [x] Banking::BankTransaction
- [x] Contact::Company (Unternehmen)
- [x] Contact::Company (Kontaktpersonen)
- [x] Expense::Voucher (Ausgabe Belege)
- [x] Income::Estimate (Angebote)
- [x] Income::Invoice (Rechnungen)
- [x] Income::PaymentTerms (Zahlungsbedingungen)
- [x] Income::Proposition (Waren / Dienstleistungen)
- [x] Info
- [ ] Settings::CustomAttribute (Datenfelder)
- [x] Project (Projekte)
- [x] Tracker::Task (Aufgaben)
- [x] Tracker::TimeEntry (Zeiterfassung)
- [ ] User

## Was, wie, warum?<!-- omit in toc -->

Papierkram.de hat nun eine API Schnittstelle für die Programmierung von eigenen Anwendungen. Die Dokumentation dazu findest du [hier](https://demo.papierkram.de/papierkram_api/v1/api-docs/index.html).

Ziele:

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
    - [alle Kontoumsätze einer Bankverbindung](#alle-kontoumsätze-einer-bankverbindung)
    - [einen Kontoumsatz](#einen-kontoumsatz)
  - [Contact::Company (Unternehmen)](#contactcompany-unternehmen)
    - [alle Unternehmen](#alle-unternehmen)
    - [ein Unternehmen](#ein-unternehmen)
    - [erstelle ein Unternehmen](#erstelle-ein-unternehmen)
    - [aktualisiere ein Unternehmen](#aktualisiere-ein-unternehmen)
    - [lösche ein Unternehmen](#lösche-ein-unternehmen)
    - [archiviere ein Unternehmen](#archiviere-ein-unternehmen)
    - [unarchiviere ein Unternehmen](#unarchiviere-ein-unternehmen)
  - [Contact::Company (Kontaktperson eines Unternehmens)](#contactcompany-kontaktperson-eines-unternehmens)
    - [alle Kontaktpersonen (eines Unternehmens)](#alle-kontaktpersonen-eines-unternehmens)
    - [eine Kontaktperson (eines Unternehmens)](#eine-kontaktperson-eines-unternehmens)
    - [erstelle eine Kontaktperson (eines Unternehmens)](#erstelle-eine-kontaktperson-eines-unternehmens)
    - [aktualisiere eine Kontaktperson (eines Unternehmens)](#aktualisiere-eine-kontaktperson-eines-unternehmens)
    - [lösche eine Kontaktperson (eines Unternehmens)](#lösche-eine-kontaktperson-eines-unternehmens)
  - [Expense::Voucher (Ausgabe Beleg)](#expensevoucher-ausgabe-beleg)
    - [alle Ausgabe Belege](#alle-ausgabe-belege)
    - [einen Ausgabe Beleg](#einen-ausgabe-beleg)
    - [einen Ausgabe Beleg als PDF](#einen-ausgabe-beleg-als-pdf)
    - [einen Ausgabe Beleg erstellen](#einen-ausgabe-beleg-erstellen)
    - [einen Ausgabe Beleg aktualisieren](#einen-ausgabe-beleg-aktualisieren)
    - [einen Ausgabe Beleg löschen](#einen-ausgabe-beleg-löschen)
    - [einen Ausgabe Beleg archivieren](#einen-ausgabe-beleg-archivieren)
    - [einen Ausgabe Beleg unarchivieren](#einen-ausgabe-beleg-unarchivieren)
    - [einen Ausgabe Beleg stornieren](#einen-ausgabe-beleg-stornieren)
    - [einen Ausgabe Beleg rückwirkend stornieren](#einen-ausgabe-beleg-rückwirkend-stornieren)
    - [einen Ausgabe Beleg als bezahlt markieren](#einen-ausgabe-beleg-als-bezahlt-markieren)
    - [einem Ausgabe Beleg ein Dokument hinzufügen](#einem-ausgabe-beleg-ein-dokument-hinzufügen)
    - [einem Ausgabe Beleg ein Dokument entfernen](#einem-ausgabe-beleg-ein-dokument-entfernen)
  - [Income::Estimate (Angebot)](#incomeestimate-angebot)
    - [alle Angebote](#alle-angebote)
    - [ein Angebot](#ein-angebot)
    - [ein Angebot als PDF](#ein-angebot-als-pdf)
  - [Income::Invoice (Rechnung)](#incomeinvoice-rechnung)
    - [alle Rechnungen](#alle-rechnungen)
    - [eine Rechnung](#eine-rechnung)
    - [eine Rechnung als PDF](#eine-rechnung-als-pdf)
    - [eine Rechnung erstellen](#eine-rechnung-erstellen)
    - [eine Rechnung aktualisieren](#eine-rechnung-aktualisieren)
    - [eine Rechnung löschen](#eine-rechnung-löschen)
    - [eine Rechnung archivieren](#eine-rechnung-archivieren)
    - [eine Rechnung unarchivieren](#eine-rechnung-unarchivieren)
    - [eine Rechnung stornieren](#eine-rechnung-stornieren)
    - [eine Rechnung verschicken](#eine-rechnung-verschicken)
  - [Income::PaymentTerms (Zahlungsbedingungen)](#incomepaymentterms-zahlungsbedingungen)
    - [eine Zahlungsbedingung](#eine-zahlungsbedingung)
    - [alle Zahlungsbedingungen](#alle-zahlungsbedingungen)
  - [Income::Proposition (Waren / Dienstleistungen)](#incomeproposition-waren--dienstleistungen)
    - [alle Waren / Dienstleistungen](#alle-waren--dienstleistungen)
    - [eine Ware / Dienstleistung](#eine-ware--dienstleistung)
    - [eine Ware / Dienstleistung erstellen](#eine-ware--dienstleistung-erstellen)
    - [eine Ware / Dienstleistung aktualisieren](#eine-ware--dienstleistung-aktualisieren)
    - [eine Ware / Dienstleistung löschen](#eine-ware--dienstleistung-löschen)
    - [eine Ware / Dienstleistung archivieren](#eine-ware--dienstleistung-archivieren)
    - [eine Ware / Dienstleistung unarchivieren](#eine-ware--dienstleistung-unarchivieren)
  - [Info](#info)
  - [Project::Project (Projekt)](#projectproject-projekt)
    - [alle Projekte](#alle-projekte)
    - [ein Projekt](#ein-projekt)
    - [erstelle ein Projekt](#erstelle-ein-projekt)
    - [aktualisiere ein Projekt](#aktualisiere-ein-projekt)
    - [lösche ein Projekt](#lösche-ein-projekt)
    - [archiviere ein Projekt](#archiviere-ein-projekt)
    - [unarchiviere ein Projekt](#unarchiviere-ein-projekt)
  - [Tracker::Task (Aufgabe)](#trackertask-aufgabe)
    - [alle Aufgaben](#alle-aufgaben)
    - [eine Aufgabe](#eine-aufgabe)
    - [erstelle eine Aufgabe](#erstelle-eine-aufgabe)
    - [aktualisiere eine Aufgabe](#aktualisiere-eine-aufgabe)
    - [lösche eine Aufgabe](#lösche-eine-aufgabe)
    - [archiviere eine Aufgabe](#archiviere-eine-aufgabe)
    - [unarchiviere eine Aufgabe](#unarchiviere-eine-aufgabe)
  - [Tracker::TimeEntry (Zeiteintrag)](#trackertimeentry-zeiteintrag)
    - [alle Zeiteinträge](#alle-zeiteinträge)
    - [einen Zeiteintrag](#einen-zeiteintrag)
    - [erstelle einen Zeiteintrag](#erstelle-einen-zeiteintrag)
    - [aktualisiere einen Zeiteintrag](#aktualisiere-einen-zeiteintrag)
    - [lösche einen Zeiteintrag](#lösche-einen-zeiteintrag)
    - [archiviere einen Zeiteintrag](#archiviere-einen-zeiteintrag)
    - [unarchiviere einen Zeiteintrag](#unarchiviere-einen-zeiteintrag)
  - [Verbleibendes Quota](#verbleibendes-quota)
- [Helpers](#helpers)
  - [Generiere ein PDF aus Response](#generiere-ein-pdf-aus-response)
- [Development / Mitentwickeln](#development--mitentwickeln)
  - [Localhost 3000! 🤫](#localhost-3000-)
- [Contributing](#contributing)
- [Releasing](#releasing)
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
client = PapierkramApi::Client.new

# ODER per Variablen
client = PapierkramApi::Client.new('subdomain', "YOUR-API-KEY");

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

[Client](lib/papierkram_api/client.rb)

Wenn du etwas hinter die Kulissen sehen willst, schau dir diese [Faraday](https://github.com/lostisland/faraday) Klasse an [Faraday::Response](https://github.com/lostisland/faraday/blob/main/lib/faraday/response.rb).

### Initialisierung

Entweder werden die Zugangsdaten als Argumente übergeben:

```ruby
# usage with subdomain and api key
client = PapierkramApi::Client.new('subdomain', "SUPER-LONG-API-KEY")
```

Oder es werden die Umgebungsvariablen `PAPIERKRAM_API_SUBDOMAIN` und `PAPIERKRAM_API_KEY` gesetzt und der Client ohne Argumente initialisiert.

Ich kann dir wärmstes https://direnv.net/ empfehlen, um die Umgebungsvariablen zu setzen. 🤓

```ruby
# usage with environment variables
client = PapierkramApi::Client.new
```

### Banking::BankConnection (Bankverbindung)

Der Endpunkt `/papierkram_api/v1/endpoints/banking/bank_connections` liefert Informationen über die Bankverbindungen. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [BankConnections](lib/papierkram_api/v1/endpoints/banking/bank_connections.rb) für mögliche Parameter.

#### alle Bankverbindungen

```ruby
bank_connections = client.banking_bank_connections.all
puts bank_connections.headers
puts bank_connections.body
```

<details>

<summary>Response</summary>

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

</details>

#### eine Bankverbindung

```ruby
bank_connection = client.banking_bank_connections.find_by(id: 1)
puts bank_connection.headers
puts bank_connection.body
```

<details>

<summary>Response</summary>

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

</details>

### Banking::Transaction (Kontoumsatz)

Der Endpunkt `/papierkram_api/v1/endpoints/banking/transactions` liefert Informationen über die Kontoumsätze. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [Transactions](lib/papierkram_api/v1/endpoints/banking/transactions.rb) für mögliche Parameter.

#### alle Kontoumsätze einer Bankverbindung

```ruby
bank_connection_id = 4
transactions = client.banking_transactions.all(bank_connection_id: bank_connection_id,
                                               page: 1,
                                               page_size: 2)
puts transactions.headers
puts transactions.body
```

#### einen Kontoumsatz

```ruby
transactions = client.banking_transactions.find_by(id: bank_connection_id)
puts transactions.headers
puts transactions.body
```

### Contact::Company (Unternehmen)

Der Endpunkt `/papierkram_api/v1/endpoints/contact/companies` liefert Informationen über die Unternehmen. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [Companies](lib/papierkram_api/v1/endpoints/contact/companies.rb) für mögliche Parameter.

#### alle Unternehmen

```ruby
companies = client.contact_companies.all
puts companies.headers
puts companies.body
```

#### ein Unternehmen

```ruby
company = client.contact_companies.find_by(id: 1)
puts company.headers
puts company.body
```

#### erstelle ein Unternehmen

```ruby
# supplier
company = client.contact_companies.create_supplier(name: 'Test GmbH')
puts company.headers
puts company.body

# customer
company = client.contact_companies.create_customer(name: 'Test GmbH')
puts company.headers
puts company.body
```

Siehe [Companies#create_customer](lib/papierkram_api/v1/endpoints/contact/companies.rb) und [Companies#create_supplier](lib/papierkram_api/v1/endpoints/contact/companies.rb) für mögliche Parameter.

#### aktualisiere ein Unternehmen

```ruby
company = client.contact_companies.update_by(
  id: 1,
  name: 'Test GmbH'
)
puts company.headers
puts company.body
```

#### lösche ein Unternehmen

```ruby
company = client.contact_companies.delete_by(id: 1)
puts company.headers
puts company.body
```

#### archiviere ein Unternehmen

```ruby
company = client.contact_companies.archive_by(id: 1)
puts company.headers
puts company.body
```

#### unarchiviere ein Unternehmen

```ruby
company = client.contact_companies.unarchive_by(id: 1)
puts company.headers
puts company.body
```

### Contact::Company (Kontaktperson eines Unternehmens)

Der Endpunkt `/papierkram_api/v1/endpoints/contact/companies/{company_id}` liefert Informationen über die Kontaktpersonen. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [CompaniesPersons](lib/papierkram_api/v1/endpoints/contact/companies_persons.rb) für mögliche Parameter.

#### alle Kontaktpersonen (eines Unternehmens)

```ruby
companies = client.contact_companies_persons.all(company_id: 1)
puts companies.headers
puts companies.body
```

#### eine Kontaktperson (eines Unternehmens)

```ruby
company = client.contact_companies_persons.find_by(company_id: 1, id: 1)
puts company.headers
puts company.body
```

#### erstelle eine Kontaktperson (eines Unternehmens)

```ruby
company = client.contact_companies_persons.create(
  company_id: 1,
  first_name: 'Max',
  last_name: 'Mustermann'
)
puts company.headers
puts company.body
```

Siehe [CompaniesPersons#create](lib/papierkram_api/v1/endpoints/contact/companies_persons.rb) für mögliche Parameter.

#### aktualisiere eine Kontaktperson (eines Unternehmens)

```ruby
company = client.contact_companies_persons.update_by(
  id: 1,
  company_id: 1,
  first_name: 'Moritz'
)
puts company.headers
puts company.body
```

Siehe [CompaniesPersons#update_by](lib/papierkram_api/v1/endpoints/contact/companies_persons.rb) für mögliche Parameter.

#### lösche eine Kontaktperson (eines Unternehmens)

```ruby
company = client.contact_companies_persons.delete_by(company_id: 1, id: 1)
puts company.headers
puts company.body
```

### Expense::Voucher (Ausgabe Beleg)

Der Endpunkt `/papierkram_api/v1/endpoints/expense/vouchers` liefert Informationen über die Ausgabe Belege. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [Vouchers](lib/papierkram_api/v1/endpoints/expense/vouchers.rb) für mögliche Parameter.

#### alle Ausgabe Belege

```ruby
vouchers = client.expense_vouchers.all
puts vouchers.headers
puts vouchers.body
```

#### einen Ausgabe Beleg

```ruby
voucher = client.expense_vouchers.find_by(id: 1)
puts voucher.headers
puts voucher.body
```

#### einen Ausgabe Beleg als PDF

```ruby
voucher = client.expense_vouchers.find_by(id: 1, pdf: true)
puts PapierkramApi::V1::Helpers::PdfFromResponse.new(voucher).to_pdf
# => {response: Faraday::Response, path_to_pdf_file: 'path/to/tempfile_pdf.pdf'}
```

#### einen Ausgabe Beleg erstellen

Siehe [Vouchers#create](lib/papierkram_api/v1/endpoints/expense/vouchers.rb) für mögliche Parameter.

```ruby
voucher = client.expense_vouchers.create(
  name: "Restaurant visit",
  due_date: "2020-06-30",
  document_date: "2020-06-14",
  description: "Took customer for dinner.",
  entertainment_reason: "sales meeting",
  flagged: true,
  provenance: "domestic",
  entertainment_persons: [
    "Carl Customer"
  ],
  creditor_id: 85,
  line_items: [
    {
      amount: 150.8,
      name: "restaurant bill",
      vat_rate: 0.19,
      category: "Bewirtungskosten"
    },
    {
      amount: 15,
      name: "tip",
      vat_rate: 0.19,
      category: "Bewirtungskosten"
    }
  ]
)
```

#### einen Ausgabe Beleg aktualisieren

Siehe [Vouchers#update_by](lib/papierkram_api/v1/endpoints/expense/vouchers.rb) für mögliche Parameter.

```ruby
voucher = client.expense_vouchers.update_by(
  id: 1,
  document_date: "2020-06-13",
  creditor_id: 102,
  line_items: [
    {
      amount: 170.8,
      name: "restaurant bill",
      vat_rate: 0.19,
      category: "Bewirtungskosten",
      billing: null,
      depreciation: null
    },
    {
      amount: 15,
      name: "tip",
      vat_rate: 0.19,
      category: "Bewirtungskosten"
    }
  ]
)
```

#### einen Ausgabe Beleg löschen

```ruby
voucher = client.expense_vouchers.delete_by(id: 1)
```

#### einen Ausgabe Beleg archivieren

```ruby
voucher = client.expense_vouchers.archive_by(id: 1)
```

#### einen Ausgabe Beleg unarchivieren

```ruby
voucher = client.expense_vouchers.unarchive_by(id: 1)
```

#### einen Ausgabe Beleg stornieren

```ruby
voucher = client.expense_vouchers.cancel_by(id: 1)
```

#### einen Ausgabe Beleg rückwirkend stornieren

```ruby
voucher = client.expense_vouchers.cancel_with_reverse_entry_by(id: 1)
```

#### einen Ausgabe Beleg als bezahlt markieren

Siehe [Vouchers#mark_as_paid_by](lib/papierkram_api/v1/endpoints/expense/vouchers.rb) für mögliche Parameter.

```ruby
voucher = client.expense_vouchers.mark_as_paid_by(
  id: 1,
  value: 119.0
)
```

#### einem Ausgabe Beleg ein Dokument hinzufügen

Siehe [Vouchers#add_document_by](lib/papierkram_api/v1/endpoints/expense/vouchers.rb) für mögliche Parameter.

Um ein PDF hinzuzufügen:

```ruby
voucher = client.expense_vouchers.add_document_by(
  id: 1,
  path_to_file: 'path/to/file.pdf',
  file_type: 'application/pdf'
)
```

oder mit einem Bild im jpeg Format

```ruby
voucher = client.expense_vouchers.add_document_by(
  id: 1,
  path_to_file: 'path/to/file.jpeg',
  file_type: 'image/jpeg'
)
```

#### einem Ausgabe Beleg ein Dokument entfernen

```ruby
voucher = client.expense_vouchers.delete_document_by(
  id: 1,
  document_id: 1
)
```

### Income::Estimate (Angebot)

Der Endpunkt `/papierkram_api/v1/endpoints/income/estimates` liefert Informationen über die Angebote. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [Estimates](lib/papierkram_api/v1/endpoints/income/estimates.rb) für mögliche Parameter.

#### alle Angebote

```ruby
estimates = client.income_estimates.all
puts estimates.headers
puts estimates.body
```

#### ein Angebot

```ruby
estimate = client.income_estimates.find_by(id: 1)
puts estimate.headers
puts estimate.body
```

#### ein Angebot als PDF

```ruby
estimate = client.income_estimates.find_by(id: 1, pdf: true)
puts PapierkramApi::V1::Helpers::PdfFromResponse.new(estimate).to_pdf
# => {response: Faraday::Response, path_to_pdf_file: 'path/to/tempfile_pdf.pdf'}
```

### Income::Invoice (Rechnung)

Der Endpunkt `/papierkram_api/v1/endpoints/income/invoices` liefert Informationen über die Rechnungen. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [Invoices](lib/papierkram_api/v1/endpoints/income/invoices.rb) für mögliche Parameter.

#### alle Rechnungen

```ruby
invoices = client.income_invoices.all
puts invoices.headers
puts invoices.body
```

#### eine Rechnung

```ruby
invoice = client.income_invoices.find_by(id: 1)
puts invoice.headers
puts invoice.body
```

#### eine Rechnung als PDF

```ruby
invoice = client.income_invoices.find_by(id: 1, pdf: true)
puts PapierkramApi::V1::Helpers::PdfFromResponse.new(invoice).to_pdf
# => {response: Faraday::Response, path_to_pdf_file: 'path/to/tempfile_pdf.pdf'}
```

#### eine Rechnung erstellen

Siehe [Invoices#create](lib/papierkram_api/v1/endpoints/income/invoices.rb) für mögliche Parameter.

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
      vat_rate: 0.19,
      price: 100
    },
    {
      name: 'Bestuhlung',
      description: 'Bestuhlung des Bürogebäudes',
      quantity: 1.25,
      unit: 'Arbeitstage',
      vat_rate: 0.19,
      price: 800
    },
    {
      name: 'Büroartikel',
      description: 'Neue Bürostühle',
      quantity: 200,
      unit: 'Stühle',
      vat_rate: 0.19,
      price: 125
    }
  ]
)
```

#### eine Rechnung aktualisieren

Siehe [Invoices#update_by](lib/papierkram_api/v1/endpoints/income/invoices.rb) für mögliche Parameter.

```ruby
response = client.income_invoices.update_by(
  id: 9,
  name: 'Neuausstattung eines Büros',
  line_items: [
    {
      name: 'Anlieferung',
      description: 'Anlieferung der neuen Möbel',
      quantity: 1.5,
      unit: 'Stunden',
      vat_rate: 0.19,
      price: 100
    },
    {
      name: 'Bestuhlung',
      description: 'Bestuhlung des Bürogebäudes',
      quantity: 1.5,
      unit: 'Arbeitstage',
      vat_rate: 0.19,
      price: 800
    },
    {
      name: 'Büroartikel',
      description: 'Neue Bürostühle',
      quantity: 200,
      unit: 'Stühle',
      vat_rate: 0.19,
      price: 125
    }
  ]
)
```

#### eine Rechnung löschen

Siehe [Invoices#delete_by](lib/papierkram_api/v1/endpoints/income/invoices.rb) für mögliche Parameter.

```ruby
invoice = client.income_invoices.delete_by(id: 1)
```

#### eine Rechnung archivieren

Siehe [Invoices#archive_by](lib/papierkram_api/v1/endpoints/income/invoices.rb) für mögliche Parameter.

```ruby
invoice = client.income_invoices.archive_by(id: 1)
```

#### eine Rechnung unarchivieren

Siehe [Invoices#unarchive_by](lib/papierkram_api/v1/endpoints/income/invoices.rb) für mögliche Parameter.

```ruby
invoice = client.income_invoices.unarchive_by(id: 1)
```

#### eine Rechnung stornieren

Siehe [Invoices#cancel_by](lib/papierkram_api/v1/endpoints/income/invoices.rb) für mögliche Parameter.

```ruby
invoice = client.income_invoices.cancel_by(id: 1)
```

#### eine Rechnung verschicken

Siehe [Invoices#send_by](lib/papierkram_api/v1/endpoints/income/invoices.rb) für mögliche Parameter.

Per E-Mail:

```ruby
invoice = client.income_invoices.deliver_by(
  id: 1,
  send_via: 'email',
  email_recipient: "test@test.test",
  email_subject: "Ich verkaufe was du brauchst",
  email_body: "Sag einfach was du brauchst und ich verkaufe es dir.",
)
```

Per PDF:

```ruby
invoice = client.income_invoices.deliver_by(
  id: 1,
  send_via: 'pdf'
)
```

### Income::PaymentTerms (Zahlungsbedingungen)

Der Endpunkt `/papierkram_api/v1/endpoints/income/payment_terms` liefert Informationen über die Zahlungsbedingungen. Die Informationen werden als `Faraday::Response` zurückgegeben.

#### eine Zahlungsbedingung

```ruby
payment_term = client.income_payment_terms.find_by(id: 1)
puts payment_term.headers
puts payment_term.body
```

#### alle Zahlungsbedingungen

Siehe [PaymentTerms](lib/papierkram_api/v1/endpoints/income/payment_terms.rb) für mögliche Parameter.

```ruby
payment_terms = client.income_payment_terms.all
puts payment_terms.headers
puts payment_terms.body
```

### Income::Proposition (Waren / Dienstleistungen)

Der Endpunkt `/papierkram_api/v1/endpoints/income/propositions` liefert Informationen über die Waren / Dienstleistungen. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [Propositions](lib/papierkram_api/v1/endpoints/income/propositions.rb) für mögliche Parameter.

#### alle Waren / Dienstleistungen

```ruby
propositions = client.income_propositions.all
puts propositions.headers
puts propositions.body
```

#### eine Ware / Dienstleistung

```ruby
proposition = client.income_propositions.find_by(id: 1)
puts proposition.headers
puts proposition.body
```

#### eine Ware / Dienstleistung erstellen

```ruby
proposition = client.income_propositions.create(
  name: 'Software design',
  article_no: '12345',
  description: 'Here, we can describe what "Software design" actually entails.',
  time_unit: 'hour',
  proposition_type: 'service',
  price: '150.0',
  vat_rate: 0.19
)
puts proposition.headers
puts proposition.body
```

Siehe [Propositions#create](lib/papierkram_api/v1/endpoints/income/propositions.rb) für mögliche Parameter.

#### eine Ware / Dienstleistung aktualisieren

```ruby
client.income_propositions.update_by(
  id: 1,
  name: 'Software design',
  vat_rate: 0.19 # verpflichtend bei Änderung
)
```

Siehe [Propositions#update_by](lib/papierkram_api/v1/endpoints/income/propositions.rb) für mögliche Parameter.

#### eine Ware / Dienstleistung löschen

```ruby
client.income_propositions.delete_by(id: 1)
```

#### eine Ware / Dienstleistung archivieren

```ruby
client.income_propositions.archive_by(id: 1)
```

#### eine Ware / Dienstleistung unarchivieren

```ruby
client.income_propositions.unarchive_by(id: 1)
```

### Info

Der Endpunkt `lib/papierkram_api/v1/endpoints/info.rb` liefert Informationen über die API. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [Info](lib/papierkram_api/v1/endpoints/info.rb).

```ruby
info = client.info.details
puts info.headers
puts info.body
```

### Project::Project (Projekt)

Der Endpunkt `/papierkram_api/v1/endpoints/projects` liefert Informationen über die Projekte. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [Projects](lib/papierkram_api/v1/endpoints/projects.rb) für mögliche Parameter.

#### alle Projekte

```ruby
projects = client.projects.all
puts projects.headers
puts projects.body
```

#### ein Projekt

```ruby
project = client.projects.find_by(id: 1)
puts project.headers
puts project.body
```

#### erstelle ein Projekt

```ruby
project = client.projects.create(name: 'Projekt 1')
puts project.headers
puts project.body
```

Siehe [Projects](lib/papierkram_api/v1/endpoints/projects.rb) für mögliche Parameter.

#### aktualisiere ein Projekt

```ruby
project = client.projects.update_by(
  id: 1,
  name: 'Projekt 2'
)
puts project.headers
puts project.body
```

Siehe [Projects](lib/papierkram_api/v1/endpoints/projects.rb) für mögliche Parameter.

#### lösche ein Projekt

```ruby
project = client.projects.delete_by(id: 1)
puts project.headers
puts project.body
```

#### archiviere ein Projekt

```ruby
project = client.projects.archive_by(id: 1)
puts project.headers
puts project.body
```

#### unarchiviere ein Projekt

```ruby
project = client.projects.unarchive_by(id: 1)
puts project.headers
puts project.body
```

### Tracker::Task (Aufgabe)

Der Endpunkt `/papierkram_api/v1/tracker/tasks` liefert Informationen über die Aufgaben. Die Informationen werden als `Faraday::Response` zurückgegeben.

Siehe [Tasks](lib/papierkram_api/v1/endpoints/tracker/tasks.rb) für mögliche Parameter.

#### alle Aufgaben

```ruby
tasks = client.tracker_tasks.all
puts tasks.headers
puts tasks.body
```

#### eine Aufgabe

```ruby
task = client.tracker_tasks.find_by(id: 1)
puts task.headers
puts task.body
```

#### erstelle eine Aufgabe

Siehe [Tasks#create](lib/papierkram_api/v1/endpoints/tracker/tasks.rb) für mögliche Parameter.

```ruby
task = client.tracker_tasks.create(name: 'Aufgabe 1')
puts task.headers
puts task.body
```

#### aktualisiere eine Aufgabe

Siehe [Tasks#update_by](lib/papierkram_api/v1/endpoints/tracker/tasks.rb) für mögliche Parameter.

```ruby
task = client.tracker_tasks.update_by(id: 1, name: 'Aufgabe 2' )
puts task.headers
puts task.body
```

#### lösche eine Aufgabe

```ruby
task = client.tracker_tasks.delete_by(id: 1)
puts task.headers
puts task.body
```

#### archiviere eine Aufgabe

```ruby
task = client.tracker_tasks.archive_by(id: 1)
puts task.headers
puts task.body
```

#### unarchiviere eine Aufgabe

```ruby
task = client.tracker_tasks.unarchive_by(id: 1)
puts task.headers
puts task.body
```

### Tracker::TimeEntry (Zeiteintrag)

Der Endpunkt `/papierkram_api/v1/tracker/time_entries` liefert Informationen über die Zeiteinträge. Die Informationen werden als `Faraday::Response` zurückgegeben.

[TimeEntries](lib/papierkram_api/v1/endpoints/tracker/time_entries.rb)

#### alle Zeiteinträge

Siehe [TimeEntries](lib/papierkram_api/v1/endpoints/tracker/time_entries.rb) für mögliche Parameter.

```ruby
time_entries = client.tracker_time_entries.all
puts time_entries.headers
puts time_entries.body
```

#### einen Zeiteintrag

```ruby
time_entry = client.tracker_time_entries.find_by(id: 1)
puts time_entry.headers
puts time_entry.body
```

#### erstelle einen Zeiteintrag

Siehe [TimeEntries](lib/papierkram_api/v1/endpoints/tracker/time_entries.rb) für mögliche Parameter.

```ruby
time_entry = client.tracker_time_entries.create(
  task_id: 1,
  date: '2020-01-01',
  duration: 60,
  description: 'Test'
)
puts time_entry.headers
puts time_entry.body
```

#### aktualisiere einen Zeiteintrag

Siehe [TimeEntries](lib/papierkram_api/v1/endpoints/tracker/time_entries.rb) für mögliche Parameter.

```ruby
time_entry = client.tracker_time_entries.update_by(
  id: 1,
 comments: 'Test'
)
puts time_entry.headers
puts time_entry.body
```

#### lösche einen Zeiteintrag

```ruby
time_entry = client.tracker_time_entries.delete_by(id: 1)
puts time_entry.headers
puts time_entry.body
```

#### archiviere einen Zeiteintrag

```ruby
time_entry = client.tracker_time_entries.archive_by(id: 1)
puts time_entry.headers
puts time_entry.body
```

#### unarchiviere einen Zeiteintrag

```ruby
time_entry = client.tracker_time_entries.unarchive_by(id: 1)
puts time_entry.headers
puts time_entry.body
```

### Verbleibendes Quota

Jede API Anfrage "kostet" 1 Quota. Das Quota wird bei jedem Request aktualisiert. Um das verbleibende Quota zu erhalten, kann die Methode `remaining_quota` aufgerufen werden.

[Base](lib/papierkram_api/v1/endpoints/base.rb)

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

Mit dem Helper `PapierkramApi::V1::Helpers::PdfFromResponse` kannst du für unterstützte Endpunkte aus einer `Faraday::Response` ein PDF schreiben.

Unterstützte Endpunkte sind beispielsweise: `Income::Estimate`, `Income::Invoice`, `Expense::Voucher`.

[Api::V1::Helpers::PdfFromResponse](lib/papierkram_api/v1/helper/pdf_from_response.rb)

```ruby
response = client.income_invoices.find_by(id: 1, pdf: true)
pdf = PapierkramApi::V1::Helpers::PdfFromResponse.new(response).to_pdf("Rechnung Nummer XXX")
puts pdf
```

```ruby
# value of `pdf`
{
  response: Faraday::Response,
  path_to_pdf_file: 'path/to/temp/Rechnung Nummer XXX.pdf'
}
```

## Development / Mitentwickeln

🇬🇧/🇺🇸

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

You need to have at least the following environment variables set to run the tests:

- `MT_COMPAT=true` or `export MT_COMPAT=true` (when in .envrc)

Please, see the [`.envrc.sample`](.envrc.sample) file for more (https://direnv.net/).

🇩🇪

Nachdem du das Repository überprüft hast, führe `bin/setup` aus, um Abhängigkeiten zu installieren. Anschließend führe `rake test` aus, um die Tests durchzuführen. Du kannst auch `bin/console` ausführen, um eine interaktive Konsole zu starten und Experimente durchzuführen.

Um dieses Gem auf deinem lokalen Rechner zu installieren, führe `bundle exec rake install` aus. Um eine neue Version zu veröffentlichen, aktualisiere die Versionsnummer in `version.rb` und führe dann `bundle exec rake release` aus. Dadurch wird ein Git-Tag für die Version erstellt, Git-Commits und das erstellte Tag werden gepusht, und die `.gem`-Datei wird nach [rubygems.org](https://rubygems.org) gepusht.

Um die Tests auszuführen, muss die Umgebungsvariable `MT_COMPAT=true` gesetzt sein.

Bitte, schaue in die Datei [`.envrc.sample`](.envrc.sample) für mehr Details (https://direnv.net/).

### Localhost 3000! 🤫

Es gibt Menschen da draußen, die können gegen direkt gegen die Papierkram API entwickeln. 🤯  
Und wie das geht, verrate ich hier allen Lesern! 🤫

`DEBUG_LOCALHOST=true bin/console`

siehe: [test/test_api_v1_client.rb](test/test_api_v1_client.rb)

OR to make it stick:  
- Set `export DEBUG_LOCALHOST=true` in your `.env` or `.envrc` file.  
- Enjoy the magic: `bin/setup && bin/console` 🎉

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/simonneutert/papierkram_api_client.

Bitte achte darauf, dass du die Tests ausführst und die Tests dann auch grün sind 🤓

🚨 **SEHR WICHTIG!** Dein API Key wird in den Tests verwendet werden. **Bitte achte darauf**, dass du den API Key nicht in deinen Commits hast! Wenn du per Environment Variable arbeitest, dann wird dein API Key **nicht von VCR aufgezeichnet**. Das bedeutet, dass du deine Tests nicht mit deinem API Key ausführen solltest. ⚠️

🚨 **NOCH WICHTIGER!** deine Kundendaten, also Klarnamen, E-Mails und Telefonnummern haben hier nichts verloren! Bitte sorge dafür, dass du deine Tests mit einem Testaccount ausführst. 🙏 ODER editiere deine Kundendaten in den _VCR Cassettes_ nach dem Test. 🙏

Wenn du unsicher bist, sprich mich an oder erstelle ein Issue. Ich helfe dir gerne weiter. 🤗

## Releasing

1. checkout `main`
2. close the changelog
3. Set the correct/desired version number in `version.rb` and run `bundle install` just for sure
4. commit changes if needed
5. `bundle exec rake release`

After a successful release, the gem is pushed to [rubygems.org](https://rubygems.org/gems/papierkram_api_client).

Here are the steps you need to take after a successful release:

1. edit `lib/papierkram_api_client/version.rb` and bump the version number to the next patch version
2. run `bundle install`
3. open the changelog again
4. commit and push the changes

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
