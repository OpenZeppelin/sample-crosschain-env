const { ethers } = require('ethers');
const Spinnies = require('spinnies');

const argv = require('yargs/yargs')(process.argv.slice(2))
  .env('')
  .usage('Usage: $0 [options]')
  .help()
  .options({
    e: { alias: 'endpoint', type: 'string', default: 'http://127.0.0.1:8545' },
    s: { alias: 'silent',   type: 'count'                                    },
    w: { alias: 'wait',     type: 'count'                                    },
  })
  .argv;

const timeout = (ms) => new Promise(resolve => setTimeout(resolve, ms));

async function check(provider) {
  return provider.getNetwork().then(() => true).catch(() => false);
}

async function wait(provider) {
  while (!await check(provider)) {
    await timeout(100);
  };
  return true;
}

async function main() {
  const provider = new ethers.providers.JsonRpcProvider(argv.endpoint);
  const spinnies = new Spinnies();

  if (!argv.silent) {
    spinnies.add('check', { text: 'Waiting' });
  }

  return (argv.wait ? wait : check)(provider).then(ready => {
    if (!argv.silent) {
      ready
      ? spinnies.succeed('check', { text: 'Ready'     })
      : spinnies.fail   ('check', { text: 'Not ready' });
    }
    return ready ? 0 : 1;
  })
}

module.exports = {
  check,
  wait,
}

main()
  .then(code => process.exit(code))
  .catch(() => process.exit(127));