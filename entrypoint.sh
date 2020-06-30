#!/bin/sh
get_version_or_null() {
  if [ -n "$1" ]; then
    echo "-v $1"
  fi
}

cd "${GITHUB_WORKSPACE}/" || exit 1

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"
export RUBOCOP_VERSION=''
export FILTER_MODE=added
export FAILED_ON_ERROR=false
export LEVEL=error
export REPORTER=github-pr-review

gem install -N rubocop $(get_version_or_null $RUBOCOP_VERSION)

echo $INPUT_RUBOCOP_EXTENSIONS | xargs gem install -N

#Check if rubocop is present into repository
[ -f .rubocop.yml ] || cp /.rubocop.yml .

rubocop --force-exclusion \
  | reviewdog -f=rubocop \
      -name="rubocop-linter" \
      -reporter="${REPORTER}" \
      -filter-mode="${FILTER_MODE}" \
      -fail-on-error="${FAILED_ON_ERROR}" \
      -level="${LEVEL}"
