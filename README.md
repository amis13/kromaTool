# l2Output.sh

Bash tool for Kroma, easy to use. To see if there are successfull or failed transactions.

Clone the repo and go to `kromaTool`:

```bash
git clone https://github.com/amis13/kromaTool.git && cd kromaTool
```
Grants execution permits:

```bash
chmod +x l2Output.sh
```

Copy it to the binary path to call it from anywhere:

```bash
sudo cp l2Output.sh /usr/bin/
```

## Use

To view the help panel use the tool without parameters or use the `-h` flag:

```bash
l2Output.sh -h
```

To see successful transactions:

```bash
l2Output.sh -s
```

To see unsuccessful transactions:

```bash
l2Output.sh -f
```
