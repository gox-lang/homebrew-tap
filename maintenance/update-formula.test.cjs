const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const { update } = require('./update-formula.cjs');
const source = fs.readFileSync('Formula/gox.rb', 'utf8');
const manifest = ['darwin_amd64', 'darwin_arm64', 'linux_amd64', 'linux_arm64'].map((t, i) => String(i + 1).repeat(64) + '  gox_0.1.4_' + t + '.tar.gz').join('\n');
test('updates four immutable URLs and checksums without changing launcher', () => {
  const candidate = update(source, '0.1.4', manifest);
  assert.equal((candidate.match(/download\/v0.1.4/g) || []).length, 4);
  assert(candidate.includes('version "0.1.4"'));
  assert.equal(candidate.slice(candidate.indexOf('  def install')), source.slice(source.indexOf('  def install')));
  assert.equal(update(candidate, '0.1.4', manifest), candidate);
});
test('rejects incomplete or duplicate checksums before writing', () => {
  assert.throws(() => update(source, '0.1.4', manifest.split('\n').slice(1).join('\n')));
  assert.throws(() => update(source, '0.1.4', manifest + '\n' + manifest.split('\n')[0]));
  assert.throws(() => update(source, 'main', manifest));
});
