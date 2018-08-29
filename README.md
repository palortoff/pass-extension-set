# pass set

An extension for the [password store](https://www.passwordstore.org/) that allows to set key value pairs in a password file

[password store](https://www.passwordstore.org/) proposes a format to store meta data in the password file. The password is stored in the first line followed by data like the URL, username and other meta data in the following lines. A common password file would look like this:
```
Yw|ZSNH!}z"6{ym9pI
URL: *.amazon.com/*
Username: AmazonianChicken@example.com
```

A common use case is to copy the first line, the password, using `pass show -c <password file>`.

The meta data usually cannot be copied but needs to be displayed as it contains type and value.

## pass set

`pass set <password file> <key> <value>` sets the value for a key.

Example:

```
$ pass set shopping/amazon.com Username new@address.email
```

## Installation

- Enable password-store extensions by setting ``PASSWORD_STORE_ENABLE_EXTENSIONS=true``
- ``make install``
- alternatively add `set.bash` to your extension folder (by default at `~/.password-store/.extensions`)

## Completion

This extensions comes with the extension bash completion support added with password-store version 1.7.3

When installed, bash completion is already installed. Alternatively source `completion/pass-set.bash.completion`

fish and zsh completion are not available, feel free to contribute.

## Contribution

Contributions are always welcome.
