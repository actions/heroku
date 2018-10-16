# GitHub Deployer for Heroku

The GitHub Deployer for [Heroku](https://heroku.com/) task wraps the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) to enable common Heroku commands.

## Usage
An example workflow to build a docker container from source and push and release the image to an existing application on Heroku:


```
workflow "Deploy to Heroku" {
  on = "push"
  resolves = "release"
}

action "login" {
  uses = "actions/heroku@master"
  args = "container:login"
  secrets = ["HEROKU_API_KEY"]
}

action "push" {
  uses = "actions/heroku@master"
  needs = "login"
  args = "container:push -a calm-fortress-1234 web"
  secrets = ["HEROKU_API_KEY"]
}

action "release" {
  uses = "actions/heroku@master"
  needs = "push"
  args = "container:release -a calm-fortress-1234 web"
  secrets = ["HEROKU_API_KEY"]
}
```

### Secrets

* `HEROKU_API_KEY` - **Required**. The token to use for authentication with the Heroku API ([more info](https://help.heroku.com/PBGP6IDE/how-should-i-generate-an-api-key-that-allows-me-to-use-the-heroku-platform-api))

### Environment variables

* `HEROKU_APP` - **Optional**. To specify a Heroku application

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).

Container images built with this project include third party materials. See [THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md) for details.
