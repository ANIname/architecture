const { execSync } = require('node:child_process')
const { prompt } = require('inquirer')

const chooseCommand = () => prompt([{
  type: 'list',
  name: 'command',
  message: 'Choose the command:',
  choices: [
    { name: '⬇️  Install dependencies', value: 'npm install' },
    { name: '🔄 Update dependencies', value: 'make npm-update' }
  ]
}])

;(async () => {
  const { command } = await chooseCommand()

  execSync(command, { stdio: 'inherit' })
})()
