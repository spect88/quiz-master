[![Build Status](https://travis-ci.org/spect88/quiz-master.svg?branch=master)](https://travis-ci.org/spect88/quiz-master)

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

Check out [npm\_deps/index.js](npm_deps/index.js) and
[npm\_deps/test.js](npm_deps/test.js).

Note that you'll need `yarn` (or `npm`) to  bundle the modules if you make
any changes. The output bundles are checked in to the repo for simplicity.

## Deployment

The app is supposed to be run on a [twelve-factor][8]-compatible PaaS provider
like [Heroku][9].

Since it's a 12-factor app, configuration should be provided via environment
variables. The full list of mandatory variables can be found in the
[secrets.yml](config/secrets.yml) file.

## Notes on tech choice

TL;DR: Next time I probably won't go with `react-rails`.

It's my first time using React, so I wasn't sure how to go about it. I didn't
want to completely separate Rails and JS, because it's usually faster to
maintain the whole thing together. When researching different options I've
learned that `react-rails` supports Turbolinks, so that sounded perfect -
I should be able to quickly build a traditional Rails app with some React
components and it'll still be running as nicely as a SPA.

Later I've realised that in order to keep using sprockets I'm pretty much
forced to use `jasmine-rails` if I want to test my React components.

The next problem was that I needed external React libraries (`react-rte`
most notably) and these are usually only available as npm modules. I could
have used `browserify-rails`, but that'd break my `jasmine-rails` setup.

In order not to have to rewrite a lot of setup, I've added my custom npm
modules bundling solution, which relies on rebuilding vendored files on
every npm dependency change, and a single entry file (`npm_deps/index.js`),
exposing all the npm stuff as global variables.

I kind of expected my journey with `react-rails` to be more pleasant.
Next time I'll most likely go with [react_on_rails][10].

[1]: http://rubyonrails.org/
[2]: https://auth0.com/
[3]: https://facebook.github.io/react/
[4]: https://www.ruby-lang.org/
[5]: https://www.postgresql.org/
[6]: https://redis.io/
[7]: https://brew.sh/
[8]: https://12factor.net/
[9]: https://heroku.com/
[10]: https://github.com/shakacode/react_on_rails
