# CartForge   

A modern e-commerce storefront UI built with React + Vite. Frontend only —
no backend, no database, no API keys.

This README covers three ways to run it:
1. [Locally on your own machine](#1-run-locally-windows--mac--linux)
2. [On an AWS EC2 instance, without Docker](#2-run-on-aws-ec2-without-docker)
3. [Anywhere, using Docker](#3-run-with-docker-locally-or-on-ec2)

---

## 1. Run locally (Windows / Mac / Linux)

**Requirements:** Node.js 18+ ([download here](https://nodejs.org))

```bash
git clone https://github.com/mantu0tech/Cart-forge.git
cd Cart-forge
npm install
npm start
```

Open **http://localhost:3000** in your browser.

- `npm start` runs the Vite **dev server** — hot-reload on save, best for
  active development.
- Stop it anytime with `Ctrl+C`.

---

## 2. Run on AWS EC2 (without Docker)

**Requirements:** an EC2 instance (Ubuntu recommended), Node.js 18+ installed on it.

### 2a. Install Node.js on the instance (if not already installed)

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs
node -v   # should print v20.x or higher
```

### 2b. Get the code and install dependencies

```bash
git clone https://github.com/mantu0tech/Cart-forge.git
cd Cart-forge
npm install
```

### 2c. Open the port in your Security Group

EC2 → your instance → **Security** tab → click the security group → **Edit
inbound rules** → **Add rule**:
- Type: **Custom TCP**
- Port: `3000`
- Source: `0.0.0.0/0` (or your IP only, for tighter access)

Skip this and the app will run fine on the instance itself but never load in
your browser — this step trips up almost everyone at least once.

### 2d. Run it

**Option A — dev server** (quick, but not meant for long-term/production use):
```bash
npm start
```

**Option B — production build, served statically** (recommended for EC2):
```bash
npm run build
npx serve -s dist -l 3000
```
`serve` binds to all network interfaces automatically — no `--host` flag
needed (it'll error if you add one).

Either way, closing your SSH session kills the process. To keep it running
in the background:
```bash
nohup npx serve -s dist -l 3000 > serve.log 2>&1 &
```
Stop it later with:
```bash
pkill -f "serve -s dist"
```

### 2e. Open it

```
http://<your-EC2-public-IP>:3000
```

---

## 3. Run with Docker (locally or on EC2)

**Requirements:** Docker installed
([Docker Desktop](https://www.docker.com/products/docker-desktop/) locally,
or Docker Engine on EC2).

This path builds the app once and serves the static output with nginx on
port 80 — no Node.js needs to be installed on the machine running it at all,
Docker handles everything inside the image.

### 3a. Get the code

```bash
git clone https://github.com/mantu0tech/Cart-forge.git
cd Cart-forge
```

### 3b. Build the image

```bash
docker build -t cartforge .
```

### 3c. Run the container

```bash
docker run -d -p 80:80 --name cartforge cartforge
```

- `-p 80:80` maps port 80 on the host to port 80 in the container
- `-d` runs it in the background (detached)

Check it's running:
```bash
docker ps
```

### 3d. If running on EC2, open the port

EC2 → your instance → **Security** tab → click the security group → **Edit
inbound rules** → **Add rule**:
- Type: **HTTP**
- Port: `80`
- Source: `0.0.0.0/0` (or your IP only)

### 3e. Open it

- **Locally:** http://localhost
- **On EC2:** http://\<your-EC2-public-IP\> (no `:80` needed, it's the default HTTP port)

### Useful Docker commands

```bash
docker logs cartforge          # view container logs
docker stop cartforge           # stop it
docker start cartforge          # start it again
docker rm -f cartforge          # stop and remove it
docker build -t cartforge . --no-cache   # rebuild from scratch after code changes
```

To pick up code changes, you need to rebuild the image and restart the
container — it doesn't hot-reload like the dev server does:
```bash
docker build -t cartforge .
docker rm -f cartforge
docker run -d -p 80:80 --name cartforge cartforge
```

---

## Quick comparison

| | Local dev | EC2, no Docker | Docker |
|---|---|---|---|
| Needs Node.js installed | ✅ | ✅ | ❌ (only inside the image) |
| Hot reload on save | ✅ (`npm start`) | ✅ (`npm start`), ❌ (`serve`) | ❌ |
| Best for | active development | quick EC2 testing | anything resembling production |
| Default port | 3000 | 3000 | 80 |

---

## Troubleshooting

- **Page loads but stays blank** — open the browser console (F12) for the
  actual JS error. Usually an old Node version (`node -v`, need 18+) or a
  half-finished `npm install` — fix with `rm -rf node_modules package-lock.json && npm install`.
- **Can't reach it via public IP at all, but `curl localhost:3000` works on
  the instance itself** — it's the Security Group, not the app. See step 2c
  or 3d above.
- **`serve: unknown or unexpected option: --host`** — `serve` binds to all
  interfaces by default; just drop the flag entirely: `npx serve -s dist -l 3000`.
