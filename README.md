# Shared Ruby Config

This repo is used accross all our Ruby projects to ensure some process consistency.
It includes the `Dangerfile` and the `rubocop.yml` base template that all
projects inherit from.

## Danger

[Danger](http://danger.systems) runs during our Ruby projects' CI process, and gives you a chance to automate common code review chores.

### Setup

Enable Danger for a project within the [esanum organization](https://github.com/esanum).

#### Set DANGER_GITHUB_API_TOKEN in Travis-CI

In Travis-CI, choose _Settings_ and add `DANGER_GITHUB_API_TOKEN` in _Environment Variables_. Set the value to the API key for the [megbot](https://github.com/megbot) user.

#### Add Dangerfile to a specific project

Add the following to the `Gemfile`:

```ruby
gem 'shared_ruby_config', require: false, github: 'esanum/shared_ruby_config'
```

Add the following to the `Dangerfile`
```ruby
danger.import_dangerfile(gem: 'shared_ruby_config')
```

Add Danger to `.travis.yml`, e.g:

```yaml
matrix:
  include:
    - rvm: 2.6.1
      script:
        - bundle exec danger
```

#### Commit via a Pull Request

To test things out, make a change in a random ruby file that doesn't match the standard format and make a pull request. Iterate until green.
