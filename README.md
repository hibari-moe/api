# hibari-api

TODO: Write a description here

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here

SSL:
```bash
crystal build --release src/api.cr
./api --ssl --ssl-key-file your_key_file --ssl-cert-file your_cert_file
```
## Development

### Building

```shell
crystal run src/api.cr              // Build and run
crystal build src/api.cr            // Build only
crystal build src/api.cr --release  // Release build
./api                               // Run built executable
```

### Install Shards

```shell
crystal deps
```

### Run Specs

```shell
KEMAL_ENV=test crystal spec
```

## Contributing

1. Fork it ( https://github.com/[your-github-name]/hibari-api/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [wopian](https://github.com/wopian) James Harris - creator, maintainer
