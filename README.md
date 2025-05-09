<div align="center">

# asdf-eduardo-foo [![Build](https://github.com/eduardopoleoflipp/asdf-eduardo-foo/actions/workflows/build.yml/badge.svg)](https://github.com/eduardopoleoflipp/asdf-eduardo-foo/actions/workflows/build.yml) [![Lint](https://github.com/eduardopoleoflipp/asdf-eduardo-foo/actions/workflows/lint.yml/badge.svg)](https://github.com/eduardopoleoflipp/asdf-eduardo-foo/actions/workflows/lint.yml)

[eduardo-foo](https://github.com/eduardopoleoflipp/eduardo-foo) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add eduardo-foo
# or
asdf plugin add eduardo-foo https://github.com/eduardopoleoflipp/asdf-eduardo-foo.git
```

eduardo-foo:

```shell
# Show all installable versions
asdf list-all eduardo-foo

# Install specific version
asdf install eduardo-foo latest

# Set a version globally (on your ~/.tool-versions file)
asdf global eduardo-foo latest

# Now eduardo-foo commands are available
foo
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/eduardopoleoflipp/asdf-eduardo-foo/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Eduardo Poleo](https://github.com/eduardopoleoflipp/)
