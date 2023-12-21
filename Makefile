prisma:
	@make npm-install-if-not-exists
	@node utils/make/prisma.js

npm:
	@make npm-install-if-not-exists
	@node utils/make/npm.js

npm-update:
	@ncu
	@ncu -u
	@npm install

npm-install-if-not-exists:
	@[ -d "node_modules" ] || npm install