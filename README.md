# Tool

Bash tool for Kroma, easy to use.

# Auto-Install

Just run the following command:

```bash
curl --proto '=https' --tlsv1.2 -sSfL https://github.com/amis13/kromaTool/releases/download/Installer-Release/installer.sh | sudo sh
```

# Manual installation

Clone the repo and move to kromaTool:

```bash
git clone https://github.com/amis13/kromaTool.git && cd kromaTool
```

Install the tools:

```bash
./installer.sh
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
# updateTool

To update all tools, you only need to run:

```bash
updateTool
```
