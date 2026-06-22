# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Prerequisites

- Git
- [chezmoi](https://www.chezmoi.io/install/)
- For the full encrypted setup: `age` + encryption passhrpase

## New machine without encrypted files

Use this mode when you only want the non-secret parts of the repo, or when the age bootstrap identity is not available yet.

```sh
chezmoi init --apply --exclude=encrypted,scripts jasonlyle88
```

The `encrypted` exclusion skips age-encrypted target files.
The `scripts` exclusion is intentional: this repo has a `before` script that decrypts the chezmoi age key, so a no-secrets setup should skip scripts too.

## New machine with encrypted files


```sh
chezmoi init --apply jasonlyle88
```

During the first full apply:

- `.chezmoi.toml.tmpl` writes the chezmoi config with age encryption enabled.
- `.chezmoiscripts/run_onchange_before_decrypt-private-key.sh.tmpl` runs before encrypted files are applied. If `~/.config/age/chezmoi-key.txt` does not already exist, it decrypts `dot_config/age/chezmoi-key.txt.age` into that path and sets mode `600`.
- `.chezmoiscripts/run_once_after_init-chezmoi-git-origin-to-ssh.sh` runs once after init and changes `origin` to `personal.github:jasonlyle88/dotfiles.git`.

If the first apply fails because `age` or the outside decrypt identity is missing, install or unlock that dependency and rerun:

```sh
chezmoi apply -v
```

## Encryption setup

The generated chezmoi config enables age:

```toml
encryption = "age"

[age]
    identity = "~/.config/age/chezmoi-key.txt"
    recipientsFile = "~/.config/age/chezmoi-recipient.txt"
```

Encrypted source files use chezmoi's `encrypted_` naming and the `.age` suffix.

The encrypted chezmoi age key is kept in the source tree as `dot_config/age/chezmoi-key.txt.age`, but `.chezmoiignore` prevents that encrypted copy from also being written to `~/.config/age/chezmoi-key.txt.age`. The decrypted identity should live only at `~/.config/age/chezmoi-key.txt`.

Useful commands:

```sh
chezmoi edit-encrypted <target>
chezmoi add --encrypt <path>
chezmoi diff
```

## Managing chezmoi configuration

The chezmoi config is managed by this repo through `.chezmoi.toml.tmpl`.
Do not edit the generated `.chezmoi.toml` file directly; those changes are local output and can be replaced the next time the template is applied.

To change chezmoi settings, edit `.chezmoi.toml.tmpl`, then apply the template:

```sh
chezmoi apply -v
```

After applying, inspect the active config if needed:

```sh
chezmoi cat-config
```

## Scripts

Repository-level chezmoi scripts live in `.chezmoiscripts/`. They are run by chezmoi during `apply`; they are not installed into the home directory.

- `run_onchange_before_decrypt-private-key.sh.tmpl` handles the encrypted-key bootstrap.
- `run_once_after_init-chezmoi-git-origin-to-ssh.sh` rewrites the Git remote to the `personal.github` SSH host alias.

chezmoi only reruns `run_onchange_` scripts when their rendered contents change, and only reruns `run_once_` scripts when their unique content has not been run successfully before.

## Daily workflow

Preview changes:

```sh
chezmoi diff
```

Apply changes:

```sh
chezmoi apply -v
```

Pull repo updates and apply them:

```sh
chezmoi update -v
```

Open the source repo:

```sh
chezmoi cd
```

This repo's generated config sets:

```toml
[git]
    autoCommit = true
    autoPush = true
```

Be aware that changes made through chezmoi commands can be committed and pushed automatically.

## Troubleshooting

- If `age` is missing during a full apply, install it and rerun `chezmoi apply -v`.
- If the bootstrap key cannot be decrypted, make sure the passphrase for `dot_config/age/chezmoi-key.txt.age` is available.
- If the `personal.github` remote does not resolve after setup, confirm that the SSH host alias exists in `~/.ssh/config`, or temporarily set `origin` to a standard GitHub URL.
- If you want a no-secrets apply after a full encrypted setup, keep using `--exclude=encrypted,scripts` so the decrypt bootstrap script does not run.
