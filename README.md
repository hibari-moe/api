# Hibari API

Work in progress API backend for extra Kitsu statistics for [Hibari](https://github.com/wopian/hibari)

Initially developed as part of the *Web Services* module at Bucks New University

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here

```bash
bin/deps_release
KEMAL_ENV=production bin/api
```

## Development

### External Dependencies

- sqlite3 (libsqlite3-dev)

### Commands

#### Install Shards

```shell
crystal deps
```

#### Start Dev Server

```shell
crystal src/api.cr
```

#### Run Tests

```shell
crystal spec
```

#### Update Documentation

```shell
crystal docs
```

#### Build Server

```shell
crystal build src/api.cr --release
./api
```

## Contributing

1. [Fork it](https://github.com/wopian/hibari-api/fork)
2. Create your feature branch (`git checkout -b feat/myFeature`)
3. Commit your changes (`git commit -am 'feat: add my feature'`)
4. Push to the branch (`git push origin feat/myFeature`)
5. Create a Pull Request

## Contributors

- [wopian](https://github.com/wopian) James Harris - creator, maintainer
