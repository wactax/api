#!/usr/bin/env coffee

> path > join normalize
  fs > existsSync symlinkSync unlinkSync
  @w5/write
  @w5/read
  zx/globals:
  ./src/ROOT
  ./src/_pkg > MOD PKG_YML PROJECT PKG SRC

pnpm_install = (dir)=>
  package_json = join(dir,'package.json')
  if existsSync package_json
    {dependencies} = JSON.parse read package_json
    if Object.keys(
      dependencies or {}
    ).length
      if not existsSync join(dir, 'node_modules')
        console.log '>', dir
        await $"pnpm i -C #{dir}"
  return

< default main = =>

  RMED = new Set
  PKG_MOD = []

  for [pkg,i] from MOD.entries()
    pkg = pkg[..pkg.indexOf('/')-1]
    dp = join(ROOT,pkg)
    if not RMED.has pkg
      RMED.add pkg
      unlinkSync dp
      symlinkSync(
        join '../../pkg',pkg,'api'
        dp
      )
    if i
      {dir} = i
      if dir
        for d from dir.split(' ')
          PKG_MOD.push pkg+'/'+d

  for i from PKG_MOD.concat [
    ...PKG_YML.keys()
  ]
    await pnpm_install join SRC,i

  write(
    join(
      ROOT
      'PKG.js'
    )
    [
      'export default '+JSON.stringify(PKG_MOD)
      'export const PKG_DIR= '+JSON.stringify([...PKG_YML.keys()])
      ''
    ].join '\n'
  )
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  #process.exit()
