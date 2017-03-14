# Quiz Master

Example app using [Rails 5][1], [Auth0][2] and [React][3].

## Dependencies

[Ruby 2.4.0][4], [Postgres][5] and [Redis][6] are required to run the app.

On recent version of OS X (with recent version of [Homebrew][7] installed)
you should be able to run:

```shell
brew install postgresql
brew services start postgresql

brew install redis
brew services start redis

brew install rbenv
# edit .bashrc or similar and restart shell
rbenv install 2.4.0
gem install bundler
rbenv rehash
```

Finally to setup the database:

```shell
createdb quiz_master_dev
createdb quiz_master_test
```

And get Ruby dependencies:

```shell
bundle
```

## Development

```shell
# Run dev server
rails s

# Run REPL
rails c

# Run the tests
rake # backend
rake spec:javascripts # frontend
open http://localhost:3000/specs # frontend when rails server is up
```

### Adding frontend npm dependencies

Since this project uses `sprockets` (and switching to something else would
mean ditching `jasmine-rails` and possibly additional hacks as well), npm
dependencies have to be declared in a separate manifest, where you can
also make their exports global.

Check out [npm\_deps/](npm_deps/index.js) and [npm\_deps/](npm_deps/test.js).

Note that you'll need `yarn` (or `npm`) to  bundle the modules if you make
any changes. The output bundles are checked in to the repo for simplicity.

## Deployment

The app is supposed to be run on a [twelve-factor][8]-compatible PaaS provider
like [Heroku][9].

Since it's a 12-factor app, configuration should be provided via environment
variables. The full list of mandatory variables can be found in the
[secrets.yml](config/secrets.yml) file.

[1]: http://rubyonrails.org/
[2]: https://auth0.com/
[3]: https://facebook.github.io/react/
[4]: https://www.ruby-lang.org/
[5]: https://www.postgresql.org/
[6]: https://redis.io/
[7]: https://brew.sh/
[8]: https://12factor.net/
[9]: https://heroku.com/
