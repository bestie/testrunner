# Toy test runner

## What is it?

Test runner experiment where a server is run in one terminal and other terminals / editors can pass commands to it through a socket.

Currently I'm using Vim with [Dispatch](https://github.com/tpope/vim-dispatch), this is great however sometimes I just want my tests to always be visible in a different terminal.

## Isn't this like Guard?

Not really. The point of this project however is to make it easy to explicity and deliberately trigger commands to run tests rather than watch the file system and infer what to do from rules.

## What about Spork?

This is not intended to speed up booting your application and actually runs every command in a new fork such that nothing can be re-used between test runs.

## Usage

Open up a terminal and switch to your project directory

```
$ cd myapp
myapp$ testrunner-server
```

Then in another terminal or perhaps in your text editor

```
$ cd myapp
myapp$ testrunner-client 'echo "I like to run arbitrary commands"'
```

Of course when you're not sending amusing messages to yourself via terminal windows you can run things such as

```
myapp$ testrunner-client bundle exec rspec
```

When you've had enough run

```
myapp$ testrunner-client exit
```

or ctrl-c in the server window.

## Configuration

A socket is created in the current directory named `.test_runner_socket`. This can be configured by setting the `TEST_RUNNER_SOCKET` environment variable.

## How to install

Clone and run `install.sh` which will copy executable versions of the server and client scripts into `~/bin`. These will use whatever your default system Ruby is.

This is still a toy remember.

## Integration with Vim

Check out what I've done with my [vimrc](https://github.com/bestie/dotfiles/blob/27e275c1a0707990d4efc3f94fbd974fe7d14df8/vimrc#L126)

## Dependencies

Ruby, tested against 2.2.0 but may work with much earlier versions.
