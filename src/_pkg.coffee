#!/usr/bin/env coffee

> ./ROOT
  @w5/yml > load
  fs > existsSync
  path > dirname join

< PROJECT = dirname ROOT
export SRC = join(PROJECT,'src')
export PKG = join(dirname(PROJECT),'pkg')

< PKG_YML = new Map
< MOD = new Map

load_pkg = (pkg, need)=>
  need = need.split ' '
  meta = load join PKG, pkg, 'api/pkg.yml'
  for [key,val] from Object.entries meta
    pkg_key = pkg+'/'+key
    if not MOD.has pkg_key
      if need.includes key
        {dep} = val
        if dep
          for [p,li] from Object.entries dep
            load_pkg p, li
        MOD.set pkg_key, val
  PKG_YML.set pkg, meta
  return

pkg_yml = join PROJECT,'pkg.yml'

if not existsSync pkg_yml
  console.log pkg.yml, "not exist\ncopy #{SRC}/pkg.example.yml to "+PKG_YML
  process.exit(1)

for [pkg,li] from Object.entries load pkg_yml
  load_pkg pkg,li

