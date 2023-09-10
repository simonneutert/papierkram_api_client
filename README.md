# Papierkram API Client<!-- omit in toc -->

[![Ruby](https://github.com/simonneutert/papierkram_api_client/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/simonneutert/papierkram_api_client/actions/workflows/main.yml)

Der erste ~~illegale~~ inoffizielle API Client in [Ruby](https://www.ruby-lang.org/de/) für [Papierkram.de](https://www.papierkram.de) als [Gem](https://rubygems.org/gems/papierkram_api_client) in dein Projekt!

<div align="center">
  <img src="logo.svg" alt="PAC Logo, Zunge leckt an Karl Klammer und zieht Daten aus dem Papierkram-Account wie Frosch die Fliege vom Teich" width="300">
</div>

---

**WERBUNG** (es ist ein Aufruf zur Mitarbeit 🫠)
JETZT NEU! Ohne Lack und frei von Glamour!  
Das Gleiche, nur in grün, also für [NodeJS](https://github.com/simonneutert/papierkram-api-client). Und als Mega-Baustelle 😬

---

**WICHTIG** Dieses Projekt befindet sich im Entwicklungsstatus bis V1.0.0! Ich werde versuchen, die Änderungen so gut wie möglich zu dokumentieren. Wenn du einen Fehler findest, kannst du gerne einen Issue erstellen oder einen Pull Request mit einer Verbesserung erstellen. Ich freue mich über jede Hilfe!

> 🚨 **Bitte beachte**, dass DU UNBEDINGT die Requests/Responses der VCR Cassettes (die ausschliesslich bei Nutzung der Testsuite angelegt werden) von privaten Daten befreien musst, bevor du einen Pull Request erstellst oder einen Commit ins Web lädst! Ich werde die Cassettes auch nochmal durchgehen, bevor ich die Version 1.0.0 veröffentliche. ABER BITTE, BITTE, BITTE, mach das selbst auch! Ich habe keine Lust, dass irgendwelche Daten von dir oder deinen Kunden auf Github landen. Danke! 🙏

Check das [CHANGELOG.md](CHANGELOG.md), Baby!  
Schau in [UPGRADING.md](UPGRADING.md), 💃🕺!

Hier geht es zu den [offiziellen API Docs](https://demo.papierkram.de/api/v1/api-docs/index.html).  
Schau bitte dort um alle Rückgabefelder/-werte zu checken, bis ich (oder du mit deiner Zeit und Hingabe) die Dokumentation hier komplett habe.

---

## Aktuell unterstützte Endpunkte der Papierkram API (V1)<!-- omit in toc -->

- [x] Banking::BankConnection
- [x] Banking::BankTransaction
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
  - [Tracker::TimeEntry (Zeiteintrag)](#trackertimeentry-zeiteintrag)
    - [alle Zeiteinträge](#alle-zeiteinträge)
    - [einen Zeiteintrag](#einen-zeiteintrag)
  - [Verbleibendes Quota](#verbleibendes-quota)
- [Business Intelligence](#business-intelligence)
  - [Business::Intelligence (BI) ExpenseByCategory (Ausgaben nach Kategorie)](#businessintelligence-bi-expensebycategory-ausgaben-nach-kategorie)
    - [alle Ausgaben eines Monats nach Kategorie](#alle-ausgaben-eines-monats-nach-kategorie)
    - [alle Ausgaben eines Monats nach Kategorie gefiltert nach Steuersatz](#alle-ausgaben-eines-monats-nach-kategorie-gefiltert-nach-steuersatz)
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
company = client.contact_companies
                .update_by(id: 1, attributes: { name: 'Test GmbH' })
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
  attributes: { 
    first_name: 'Max',
    last_name: 'Mustermann'
  }
)
puts company.headers
puts company.body
```

Siehe [CompaniesPersons#create](lib/papierkram_api/v1/endpoints/contact/companies_persons.rb) für mögliche Parameter.

#### aktualisiere eine Kontaktperson (eines Unternehmens)

```ruby
company = client.contact_companies_persons
                .update_by(company_id: 1, id: 1, attributes: { first_name: 'Moritz' })
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
  vat_rate: '19%'
)
puts proposition.headers
puts proposition.body
```

Siehe [Propositions#create](lib/papierkram_api/v1/endpoints/income/propositions.rb) für mögliche Parameter.

#### eine Ware / Dienstleistung aktualisieren

```ruby
client.income_propositions.update_by(
  id: 1,
  attributes: {
    name: 'Software design',
    vat_rate: '19%' # verpflichtend bei Änderung
  }
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
project = client.projects.update_by(id: 1, attributes: { name: 'Projekt 2' })
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

### Tracker::TimeEntry (Zeiteintrag)

Der Endpunkt `/papierkram_api/v1/tracker/time_entries` liefert Informationen über die Zeiteinträge. Die Informationen werden als `Faraday::Response` zurückgegeben.

[TimeEntries](lib/papierkram_api/v1/endpoints/tracker/time_entries.rb)

#### alle Zeiteinträge

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

## Business Intelligence

Ich lasse diesen ersten Ausflug in Auswertungen erstmal hier im Gem. Aber sollte ich die Zeit finden und weitere KPIs wichtig finden, dann gehören die Auswertungen eigentlich in ein eigenes Package.

TODO ergänzen wie man `SmartQueries` erstellt und verwendet.  
TODO ergänzen wie man `SmartQueries` funktioneren.  
TODO ergänzen wie die Rückgabewerte von `SmartQueries` gestaltet werden sollten.

### Business::Intelligence (BI) ExpenseByCategory (Ausgaben nach Kategorie)

Der Endpunkt `/papierkram_api/v1/business_intelligence/expense_by_categories` liefert Informationen über die Ausgaben nach Kategorie. Die Informationen werden als `Hash` zurückgegeben.

#### alle Ausgaben eines Monats nach Kategorie

```ruby
client = PapierkramApi::Client.new
expense_voucher_data_service = client.expense_vouchers.data_service(:for_month_in_year_service)
expense_vouchers_in_date_range = expense_voucher_data_service.for_month_in_year(year: 2020, month: 8)

service = client.business_intelligence.expenses_by_category
result = service.call(expense_vouchers: expense_vouchers_in_date_range)
puts result
```

```ruby
{"Betriebsbedarf"=>
  {"amount"=>476.0,
   "amount_by_creditor"=>{nil=>476.0},
   "line_items"=>
    [{"name"=>"2020-01-03",
      "amount"=>119.0,
      "category"=>"Betriebsbedarf",
      "vat_rate"=>"19%",
      "billing"=>nil,
      "depreciation"=>nil,
      "voucher_name"=>"B-00214 - 2020-08-01",
      "voucher_id"=>641,
      "creditor"=>nil},
     {"name"=>"2020-01-03",
      "amount"=>119.0,
      "category"=>"Betriebsbedarf",
      "vat_rate"=>"19%",
      "billing"=>nil,
      "depreciation"=>nil,
      "voucher_name"=>"B-00215 - 2020-08-02",
      "voucher_id"=>644,
      "creditor"=>nil},
     {"name"=>"2020-01-03",
      "amount"=>119.0,
      "category"=>"Betriebsbedarf",
      "vat_rate"=>"19%",
      "billing"=>nil,
      "depreciation"=>nil,
      "voucher_name"=>"B-00216 - 2020-08-03",
      "voucher_id"=>647,
      "creditor"=>nil},
     {"name"=>"2020-01-03",
      "amount"=>119.0,
      "category"=>"Betriebsbedarf",
      "vat_rate"=>"19%",
      "billing"=>nil,
      "depreciation"=>nil,
      "voucher_name"=>"B-00217 - 2020-08-04",
      "voucher_id"=>650,
      "creditor"=>nil}]}}
```

#### alle Ausgaben eines Monats nach Kategorie gefiltert nach Steuersatz

```ruby
client = PapierkramApi::Client.new
expense_voucher_data_service = client.expense_vouchers.data_service(:for_month_in_year_service)
expense_vouchers_in_date_range = expense_voucher_data_service.for_month_in_year(year: 2020, month: 8)

service = client.business_intelligence.expenses_by_category
result = service.call(expense_vouchers: expense_vouchers_in_date_range) do |line_items|
  line_items.select { |v| v['vat_rate'] == '19%' }
end
puts result
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/simonneutert/papierkram_api_client.

Bitte achte darauf, dass du die Tests ausführst und die Tests dann auch grün sind 🤓

🚨 **SEHR WICHTIG!** Dein API Key wird in den Tests verwendet werden. **Bitte achte darauf**, dass du den API Key nicht in deinen Commits hast! Wenn du per Environment Variable arbeitest, dann wird dein API Key **nicht von VCR aufgezeichnet**. Das bedeutet, dass du deine Tests nicht mit deinem API Key ausführen solltest. ⚠️

🚨 **NOCH WICHTIGER!** deine Kundendaten, also Klarnamen, E-Mails und Telefonnummern haben hier nichts verloren! Bitte sorge dafür, dass du deine Tests mit einem Testaccount ausführst. 🙏 ODER editiere deine Kundendaten in den _VCR Cassettes_ nach dem Test. 🙏

Wenn du unsicher bist, sprich mich an oder erstelle ein Issue. Ich helfe dir gerne weiter. 🤗

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
