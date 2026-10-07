---
name: python-coding-rules
description: Rules and best practices for Python coding. Always refer to this when coding in Python.
---

# Python Coding Rules

- Use `pathlib` for all path management.
- Prefix path-related variable names according to the following:
    - File path: fpath
    - File name: fname
    - Directory path: dpath
    - Directory name: dname
    - Path that is neither clearly a file nor a directory, or may be either: path
- Variable names should be structured as `abstract_specific`.
    - This makes it easier to read when multiple related variables are listed. Example: dpath_dataset, dpath_output, fpath_config
- Use `typer` for managing command-line arguments. In doing so, enable the help display with `-h`.
- When writing long strings, use `()` effectively to fit within the line length limit.
- Style rules enforced by Ruff (line length, docstring layout, `os.path` and `glob` bans, `from __future__ import annotations` ban) are not repeated here. Run `just lint` after editing. New projects are set up with the `python-project-init` skill.

## Example

```python
from pathlib import Path

import typer

CONTEXT_SETTINGS = dict(help_option_names=["-h", "--help"])
app = typer.Typer(add_completion=False, context_settings=CONTEXT_SETTINGS)


def load_config(fpath_config: Path) -> str:
    """Read the config file."""
    return fpath_config.read_text()


@app.command()
def main(
    dpath_dataset: Path = typer.Option(..., "--dataset", "-d"),
    api_key: str = typer.Option(
        None,
        "--api-key", "-k",
        help=(
            "API key for authentication. Defaults to the value of the "
            "OPENROUTER_API_KEY environment variable."
        ),
    ),
):
    """
    Summary.

    Details.
    """
    fpath_config = dpath_dataset / "config.yaml"
    config = load_config(fpath_config)
```
