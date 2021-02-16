#!/usr/bin/env node

process.stdin.resume()
process.stdin.setEncoding('utf8')

function envsubst (str) {
  return str
    .replace(/\${ *([^}]+?) *}/g, (matched, var_name) => {
      return process.env[var_name] || matched
    })
}

var input = ''

process.stdin.on('data', function(chunk) {
    input += chunk

    if (/\n/.test(input)) {
        let lines = input.split('\n')
        input = lines.pop()

        lines.forEach(line => process.stdout.write(envsubst(line) + '\n'))
    }
})

process.stdin.on('end', ()=> {
  process.stdout.write(envsubst(input) + '\n')
})