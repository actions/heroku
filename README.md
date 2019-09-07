# GitHub Deployer for Heroku

This Action wraps the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) to enable common Heroku commands.

## Usage
An example workflow to build a docker container from source and push and release the image to an existing application on Heroku:


```
on: push
name: Deploy to Heroku
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: login
      uses: actions/heroku@master
      env:
        HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
      with:
        args: container:login
    - name: push
      uses: actions/heroku@master
      env:
        HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
      with:
        args: container:push -a calm-fortress-1234 web
    - name: release
      uses: actions/heroku@master
      env:
        HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
      with:
        args: container:release -a calm-fortress-1234 web

```

### Secrets

* `HEROKU_API_KEY` - **Required**. The token to use for authentication with the Heroku API ([more info](https://help.heroku.com/PBGP6IDE/how-should-i-generate-an-api-key-that-allows-me-to-use-the-heroku-platform-api))

### Environment variables

* `HEROKU_APP` - **Optional**. To specify a Heroku application

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).

Container images built with this project include third party materials. See [THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md) for details.
