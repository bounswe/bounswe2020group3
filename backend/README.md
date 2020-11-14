## Installing dependencies

Install poetry in your global:
```
python3 -m pip install --upgrade pip
python3 -m pip install poetry
```

Activate virtual environment with poetry in the project directory:
```
poetry shell
```
You can check whether virtual environment is activated by running this command:
```
which python
```
You should see something like `/Users/username/Library/Caches/pypoetry/virtualenvs/backend-HbhKE7kK-py3.9/bin/python`

If it returns `/usr/bin/python` or `/usr/local/bin/python3` it means it didn't activate the virtual environment. Try opening new terminal and run `poetry shell` again

Install dependencies with poetry:
```
poetry install
```

## Linting
You can either see linting errors in your IDE if you configure `flake8`.

Also you can run linting directly in your terminal with `flake8` command.


## Visual Studio Settings
In .vscode/settings.json:
```
{
    "python.pythonPath": "path-to-python-in-your-virtual-environment",
    "python.linting.flake8Enabled": true,
    "python.linting.enabled": true
}
```
You can find your python path with `which python` command after activating the virtual environment with `poetry shell`
