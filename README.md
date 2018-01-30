# hibari-api

Work in progress API backend for extra Kitsu statistics for Hibari.
Initially developed as part of the *Open Source Systems* module at Bucks New University

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

### Install Dependencies
#### External Dependencies

- sqlite3 (libsqlite3-dev)

#### Crystal Shards
```shell
crystal deps
```

### Running

```shell
crystal src/api.cr
```

### Testing

```shell
crystal spec
```

### Building

```shell
crystal build src/api.cr            // Dev build
crystal build src/api.cr --release  // Release build
./api                               // Run built executable
```

## Contributing

1. [Fork it](https://github.com/wopian/hibari-api/fork)
2. Create your feature branch (`git checkout -b feat/myFeature`)
3. Commit your changes (`git commit -am 'feat: add my feature'`)
4. Push to the branch (`git push origin feat/myFeature`)
5. Create a Pull Request

## Contributors

- [wopian](https://github.com/wopian) James Harris - creator, maintainer
