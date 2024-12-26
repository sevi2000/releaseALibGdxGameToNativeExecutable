# releaseALibGdxGameToNativeExecutable
## Purpoouse
Creates a deb exectutable from a liftoff LibGdx app built with gradle and publishes it to a release based on current datetime
## Usage
```yaml
name: Use Custom Java Setup Action

on:
  pull_request:
    types: [closed]
    branches:
      - main
jobs:
  build-and-release:
    runs-on: ubuntu-latest

    steps:
      - name: Use Setup Java Action
        uses: sevi2000/releaseALibGdxGameToNativeExecutable@1.1.7 # Replace with your repo and tag
        with:
          distribution: temurin
          java-version: 17
          version: 1.1.7
          caller-github-token: ${{ github.token }}
          platform-specific-exec-file-extention: exe
```
`distribution:` and `java-version:` are optional and default to `temurin` and `17`
