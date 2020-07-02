
# GitHub Action: Run linter onto upfluence ruby project

## Release new version
After pull request was approved and merged into master
If code can work with old configuration, use same tag as before
If your code include breaking change change label and inform all upfuence team about your changes.


## Add this acton to your ruby project
run command into your project directory
```bash
mkdir -p .github/workflows
```
Create file lint.yml
```yml
name: reviewdog
on: [pull_request]

jobs:
  rubocop:
    name: runner / rubocop
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v1
      - name: rubocop
        uses: upfluence/action-rubocop@v1
        with:
          github_token: ${{ secrets.github_token }}
```
If you need specific rubocop_extensions, you have to add key rubocop_extensions . By default rubocop_extensions value is 'rubocop-performance:1.5.1 rubocop-minitest'
#### For example:
```yml
name: reviewdog
on: [pull_request]

jobs:
  rubocop:
    name: runner / rubocop
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v1
      - name: rubocop
        uses: upfluence/action-rubocop@v1
        with:
          rubocop_extensions: rubocop-rails
          github_token: ${{ secrets.github_token }}

```

## Overriding .rubocop.yml
 If you need to override .rubocop.yml provide by this tool, you can create .rubocop.yml into your repository and it will be use by rubocop
