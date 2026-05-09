# Contributing to SuperVim

We love your input! We want to make contributing to SuperVim as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

## Development Process

We use GitHub to sync code, track issues and feature requests, as well as accept pull requests.

## Pull Requests

Pull requests are the best way to propose changes to the codebase. We actively welcome your pull requests:

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

## Any contributions you make will be under the MIT Software License

In short, when you submit code changes, your submissions are understood to be under the same [MIT License](http://choosealicense.com/licenses/mit/) that covers the project.

## Report bugs using Github's [issues](https://github.com/yourusername/supervim/issues)

We use GitHub issues to track public bugs. Report a bug by [opening a new issue](https://github.com/yourusername/supervim/issues/new); it's that easy!

## Write bug reports with detail, background, and sample code

**Great Bug Reports** tend to have:

- A quick summary and/or background
- Steps to reproduce
  - Be specific!
  - Give sample code if you can
- What you expected would happen
- What actually happens
- Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

## Development Guidelines

### Code Style

- Use consistent indentation (2 spaces for Lua)
- Follow existing code patterns
- Add comments for complex logic
- Keep functions small and focused

### Plugin Structure

- Create new plugins in `lua/plugins/` directory
- Use descriptive filenames (e.g., `ui.lua`, `git.lua`)
- Follow the existing plugin structure
- Add proper documentation

### Testing

- Test your changes with different file types
- Ensure startup time is not significantly impacted
- Test with a clean Neovim installation

### Documentation

- Update README.md if you add new features
- Add docstrings to functions
- Update keybinding documentation

## License

By contributing, you agree that your contributions will be licensed under its MIT License.