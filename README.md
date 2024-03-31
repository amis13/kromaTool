# Tool

Bash tool for Kroma, easy to use.

Clone the repo and go to `kromaTool`:

```bash
git clone https://github.com/amis13/kromaTool.git && cd kromaTool
```

Copy it to the binary path to call it from anywhere:

```bash
sudo cp l2Output.sh blockHeight.sh /usr/bin/
```

# blockHeight.sh

To see your block height:

```bash
blockHeight.sh
```

![blocks](https://github.com/amis13/kromaTool/assets/119992979/b8eeb174-be52-4abf-8b88-b3b66dca3714)


# l2Output.sh

To see if there are successfull or failed transactions.
## 

To view the help panel use the tool without parameters or use the `-h` flag:

```bash
l2Output.sh -h
```

![l2output-h](https://github.com/amis13/kromaTool/assets/119992979/1af5ec6c-3ea1-4dd4-9fac-d4f155fae1ae)


To see successful transactions:

```bash
l2Output.sh -s
```

![l2output-s](https://github.com/amis13/kromaTool/assets/119992979/ae8fb020-4e9b-4a14-a803-4946b8c5325d)


To see unsuccessful transactions:

```bash
l2Output.sh -f
```

![l2output-f](https://github.com/amis13/kromaTool/assets/119992979/ded4ea1b-f73d-4884-901e-c8efc8ee664a)
