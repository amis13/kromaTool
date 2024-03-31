# Tool

Bash tool for Kroma, easy to use.

Clone the repo and go to `kromaTool`:

```bash
git clone https://github.com/amis13/kromaTool.git && cd kromaTool
```

Copy it to the binary path to call it from anywhere:

```bash
sudo cp l2Output blockHeight /usr/bin/
```

# blockHeight

To see if your node is synced or the block height of your node.

## Use

To view the help panel use the tool without parameters or use the `-h` flag:

```bash
blockHeight -h
```

To see your block height:

```bash
blockHeight -b
```

To see if your node is synced:

```bash
blockHeight -s
```

# l2Output

To see if there are successfull or failed transactions.

## Use

To view the help panel use the tool without parameters or use the `-h` flag:

```bash
l2Output -h
```

To see successful transactions:

```bash
l2Output -s
```

To see unsuccessful transactions:

```bash
l2Output -f
```
