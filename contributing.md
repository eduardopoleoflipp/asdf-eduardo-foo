# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test eduardo-foo https://github.com/eduardopoleoflipp/asdf-eduardo-foo.git "foo"
```

Tests are automatically run in GitHub Actions on push and PR.
