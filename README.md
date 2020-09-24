# setup-terragrunt

This actions sets up your GitHub Actions environment by installing Terraform and Terragrunt into a `github-bin` folder in the current workspace

# Usage

See [action.yml](action.yml)

Basic:
```yaml
steps:
  - uses: actions/checkout@v2
  - uses: ministryofjustice/setup-terragrunt@main
  - run: github-bin/terragrunt plan
```