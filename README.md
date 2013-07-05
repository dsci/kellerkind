# kellerkind

Kellerkind is just a Ruby script that runs mongodump and tars the resulting dump.

It should be used with its cli but it's also possible to use it with its API.

## Usage

Install it as gem:

```
gem install kellerkind
```

Run from the command line:

```
kellerkind --help
```

to the arguments you could specify.

**Example**

```
kellerkind --mongo-db appDatabase --mongo-host linus.mongohq.com --mongo-port 10010 --mongo-username myUser --mongo-password myCrypticPassword --compress true --out $HOME/tmp/mongodump
```

Dumps a database hosted at MongoHQ to <code>$HOME/tmp/mongodump</code> and create a tar file of this dump.

## Contributing to kellerkind

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 Daniel Schmidt. See LICENSE.txt for
further details.

