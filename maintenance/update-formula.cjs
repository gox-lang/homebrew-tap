const fs = require('node:fs');

function update(source, version, manifest) {
  if (!/^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)$/.test(version)) throw new Error('Invalid version');
  const hashes = new Map();
  for (const line of manifest.trim().split(/\r?\n/)) {
    const match = /^([a-f0-9]{64})  (\S+)$/.exec(line);
    if (!match || hashes.has(match[2])) throw new Error('Invalid manifest');
    hashes.set(match[2], match[1]);
  }
  let count = 0;
  const result = source.replace(/version "[^"]+"/, 'version "' + version + '"').replace(
    /url "https:\/\/github.com\/gox-lang\/server\/releases\/download\/v[^/]+\/gox_[^"]+_(darwin|linux)_(amd64|arm64)\.tar\.gz"\s+sha256 "[a-f0-9]+"/g,
    (_, system, arch) => {
      count++;
      const archive = 'gox_' + version + '_' + system + '_' + arch + '.tar.gz';
      const hash = hashes.get(archive);
      if (!hash) throw new Error('Missing hash for ' + archive);
      return 'url "https://github.com/gox-lang/server/releases/download/v' + version + '/' + archive + '"\n      sha256 "' + hash + '"';
    });
  if (count !== 4) throw new Error('Expected exactly four formula archives');
  return result;
}
module.exports = { update };
if (require.main === module) {
  const filename = 'Formula/gox.rb';
  fs.writeFileSync(filename, update(fs.readFileSync(filename, 'utf8'), process.env.VERSION, fs.readFileSync(process.env.CHECKSUMS, 'utf8')));
}
