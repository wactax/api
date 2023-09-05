#!/usr/bin/env coffee

> @w5/pg/PG > ONE EXE
  crypto

bin = crypto.randomBytes(16)

console.log bin
await EXE"INSERT INTO img.test (id,hash) VALUES (0, #{bin}) ON CONFLICT (id) DO UPDATE set hash=EXCLUDED.hash"

console.log await ONE"SELECT id,hash::bytea from img.test WHERE id=0"

process.exit(0)

