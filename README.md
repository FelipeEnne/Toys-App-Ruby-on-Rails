# Toy App (Ruby on Rails)

Small Rails app with **Users** and **Microposts**, session-based authentication, and a modern Rails 8 stack.

## Stack

| Component | Version / notes |
| --- | --- |
| Ruby | 3.4.4 (see `.ruby-version`) |
| Rails | 8.0.5 |
| Assets | Propshaft + Importmap + Turbo + Stimulus |
| Auth | `has_secure_password` (bcrypt) |
| Dev / test DB | SQLite |
| Production DB | PostgreSQL (`DATABASE_URL`) |

## Features

- Sign up, log in, and log out
- Users can only edit or delete their own profile
- Microposts are always owned by the logged-in user (`user_id` is not mass-assignable)
- Production uses SSL (`force_ssl`), filtered logs, and secrets from the environment

## Prerequisites

- Ruby **3.4.4** and Bundler 2.x, **or** Docker
- For production: PostgreSQL and a strong `SECRET_KEY_BASE`

## Configuration

Copy the example env file and set a secret key:

```bash
cp .env.example .env
```

Generate a key:

```bash
bin/rails secret
```

Put the value in `.env` (or export it in your shell):

```bash
SECRET_KEY_BASE=your_generated_secret
```

Never commit `.env` or real secrets. `.env` is listed in `.gitignore`.

### Production

| Variable | Purpose |
| --- | --- |
| `SECRET_KEY_BASE` | Cookie / session signing (required) |
| `DATABASE_URL` | PostgreSQL connection string |
| `APP_HOST` | Host used in mailer URLs (optional, default `example.com`) |
| `RAILS_LOG_LEVEL` | Log level (default `info`) |

## Setup (local)

```bash
bundle install
bin/rails db:prepare
bin/rails server
```

Open [http://localhost:3000](http://localhost:3000).

## Setup (Docker)

```bash
docker build -t toy-app .
docker run --rm -e SECRET_KEY_BASE="$(openssl rand -hex 64)" -p 3000:3000 toy-app
```

For a one-off test run inside Docker (Windows-friendly):

```bash
docker run --rm \
  -e SECRET_KEY_BASE=test_secret_key_base_for_ci_only \
  -e RAILS_ENV=test \
  -v "%cd%":/app -w /app \
  ruby:3.4.4-slim \
  bash -c "apt-get update -qq && apt-get install -y -qq build-essential libsqlite3-dev libpq-dev git libyaml-dev dos2unix > /dev/null && dos2unix bin/* > /dev/null; bundle install > /dev/null && bundle exec rails db:prepare && bundle exec rails test"
```

## Tests and security checks

```bash
bin/rails test

bundle exec bundler-audit update
bundle exec bundler-audit check

bundle exec brakeman --no-pager -q
```

CI runs the same checks on push and pull requests (see [`.github/workflows/security.yml`](.github/workflows/security.yml)). Dependabot is configured for Bundler and GitHub Actions ([`.github/dependabot.yml`](.github/dependabot.yml)).

## App routes (high level)

| Path | Description |
| --- | --- |
| `/` | Users index |
| `/signup` | Create account |
| `/login` / `/logout` | Session |
| `/users`, `/microposts` | CRUD (mutations require login and ownership where applicable) |
| `/up` | Health check |

## License

This project is provided as-is for learning and demonstration.
