# simple-semver

A github action to increment a semver string consisting of MAJOR, MINOR and PATCH numbers.

## Usage

```yaml
- name: Simple Semver
  id: semver
  uses: matt-FFFFFF/simple-semver@v0.1.0
  with:
    semver-input: '1.2.34'
    increment: p

- name: Use new semver
  run: echo ${{ steps.semver.outputs.semver }}
```

## Input `semver-input`

Three element string with MAJOR, MINOR and PATCH numbers, seperated by dots `.`

## Input `increment`

Must be one of the following:

* `m` - increment MAJOR version number and zero all to the right
* `i` - increment MINOR version number and zero all to the right
* `p` - increment PATCH version number

##  Output `semver`

Contains the new semver string
