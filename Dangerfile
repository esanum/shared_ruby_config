# frozen_string_literal: true

# See http://danger.systems/reference.html for a reference.

# Various checks

def big_pr?
  git.lines_of_code > 200
end

def work_in_progress?
  github.pr_title.include?('WIP') ||
    github.pr_labels.include?('wip') ||
    github.pr_labels.include?('work-in-progress') ||
    github.pr_labels.include?('work in progress') ||
    github.pr_labels.include?('in progress')
end

def test_changes?
  git.modified_files.grep(/(spec|test)/).any? ||
    git.added_files.grep(/(spec|test)/).any?
end

# TODO: Check if the project uses rspec or minitest and add checks for minitest
def focused_spec_exists?
  `grep -r 'focus: true' spec/`.length > 1
end

def schema_changed?
  git.modified_files.grep('schema.rb').any?
end

def short_summary?
  github.pr_body.length < 5
end

def coffee_script_added?
  git.added_files.any? { |file| file.end_with?('coffee') }
end

def vcr_cassettes_changed?
  git.modified_files.any? { |file| file.include?('vcr_cassettes') } ||
    git.added_files.any? { |file| file.include?('vcr_cassettes') }
end

def short_commit_messages?
  git.commits.any? { |c| c.message.split(' ').length < 3 }
end

def message_table(checks)
  message_string = "### Pull Request Checklist for reviewer\n\n"
  link = 'https://github.com/thoughtbot/guides/tree/master/code-review'
  message_string += "Be sure to follow follow [good code review guidelines](#{link}).\n"
  checks.shuffle.each do |check|
    message_string += "* [ ] #{check}\n"
  end
  message_string
end

# allows to add labels to an issue
def add_labels(labels:)
  repo = github.pr_json['head']['repo']['full_name']
  id = github.pr_json['id']
  github.api.add_labels_to_an_issue(repo, id, labels)
end

# Print our PR checklist
checks = [
  'Tests for new features or bug fixes have been added',
  'There are no known bugs',
  "Commit messages are explanatory (no 'fixed', 'try', etc.)"
]

# Prevent merging of WIP Pull Requests
failure('PR is classed as Work in Progress. Do not merge.') if work_in_progress?

# Don't let testing shortcuts get into master by accident
failure("'focus: true' left in specs") if focused_spec_exists?

# We do not want to have new CoffeeScript files. We should prefer plain Javascript for now.
failure('Please use Javascript over CoffeeScript') if coffee_script_added?

if big_pr?
  checks << 'Added [yard](http://www.rubydoc.info/gems/yard/file/docs/GettingStarted.md) documentation for new features'
  warn('Big PR. Please review carefully.')
end

if schema_changed?
  warn('Changes to config/schema.db detected. Please review changes to this file carefully.')
end

# Mainly to encourage writing up some reasoning about the PR, rather than
# just leaving a title
warn('Please provide a summary in the Pull Request description') if short_summary?

# Ensure git commit messages are longer than 3 words
if short_commit_messages?
  warn(
    'Some of the commit messages look really short. '\
    'They probably could be made more descriptive for other people.'
  )
end

# Warn on missing tests
warn('Tests were not updated', sticky: false) unless test_changes?

# vcr_cassettes are generated automatically, most of the time, no need to review them.
message(":eyes: You don't have to review the vcr_cassettes changes.") if vcr_cassettes_changed?

markdown(message_table(checks))

todoist.message = "New code should not contain TODO or FIXME. Please create a ticket instead."
todoist.fail_for_todos
todoist.print_todos_table
rubocop.lint(force_exclusion: true, report_danger: true)
