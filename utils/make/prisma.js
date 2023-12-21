const { execSync } = require('node:child_process')
const { prompt } = require('inquirer')

const SCHEMA_PATH = 'db/postgresql/schema.prisma'

const chooseCommand = () => prompt([{
  type: 'list',
  name: 'command',
  message: 'Choose the command:',
  choices: [
    { name: '🔂 migrate:dev', value: `npx prisma migrate dev --schema ${SCHEMA_PATH}` },
    { name: '🔁 migrate:deploy', value: `npx prisma migrate deploy --schema ${SCHEMA_PATH}` }
  ]
}])

;(async () => {
  const { command } = await chooseCommand()

  execSync(command, { stdio: 'inherit' })
})()
