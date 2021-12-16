# OpenZeppelin cross-chain environments

:warning: :wrench: This repository is experimental and may not be actively maintained in the future.

This repository is an effort toward improving the testing of cross-chain contracts and applications. It contains
ressources to easily spin-up local test environments.

For now only [optimism](https://www.optimism.io/) is supported. We hope to soon offer test frameworks for other
scalability solutions.

## [Optimism](https://www.optimism.io/)

### Start the environment

```bash
npm run optimism:start
```

### Check status

The optimism containers need to go through a configuration step. It takes some time (1~2 min) before the environment
is ready for running tests. You can check the current status or activelly wait for it to be ready using the following
commands:

```bash
npm run optimism:check
```

```bash
npm run optimism:wait
```

### Stop the environment

```bash
npm run optimism:start
```

## Upcoming networks

We hope to soon include support for:

- [Arbitrum](https://arbitrum.io/)
- [Gnosis Chain](https://www.xdaichain.com/)
- [Loopring](https://loopring.org/)
- [Polygon](https://polygon.technology/)
- [zkSync](https://zksync.io/)

If you are an expert in any of these, external contributions to expand this repository are welcome!
