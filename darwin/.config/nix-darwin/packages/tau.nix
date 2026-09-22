# pi-coding-agent の bin/pi は zsh の alias pi (pnpm install) と被るので tau として置く
{ runCommand, pi-coding-agent }:
runCommand "tau" { } ''
  mkdir -p $out/bin
  ln -s ${pi-coding-agent}/bin/pi $out/bin/tau
''
