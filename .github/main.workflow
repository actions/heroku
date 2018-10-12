workflow "Build and Push Container" {
  on = "push"
  resolves = ["push", "license"]
}

action "shellcheck" {
  uses = "docker://superbbears/shellcheck"
  args = "*.sh"
}

action "bats" {
  uses = "docker://superbbears/bats"
  args = "test/*.bats"
}

action "dockerfilelint" {
  uses = "docker://replicated/dockerfilelint"
  args = ["Dockerfile"]
}

action "login" {
  needs = ["bats"]
  uses = "superb-bears/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "build" {
  needs = ["login", "shellcheck", "bats", "dockerfilelint"]
  uses = "superb-bears/docker/cli@master"
  args = "build -t heroku ."
}

action "license" {
  needs = ["build"]
  uses = "docker://docker:stable"
  runs = "sh -c"
  args = ["docker run -w $WORKDIR --entrypoint yarn heroku licenses list"]
  env = {
    WORKDIR = "/usr/local/share/.config/yarn/global"
  }
}

action "filter" {
  needs = ["build"]
  uses = "docker://superbbears/filter:master"
  args = "branch master"
}

action "tag" {
  needs = ["filter"]
  uses = "superb-bears/docker/tag@master"
  args = "heroku superbbears/heroku --no-latest"
}

action "push" {
  needs = ["tag"]
  uses = "superb-bears/docker/cli@master"
  args = "push superbbears/heroku"
}
