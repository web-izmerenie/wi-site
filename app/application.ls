/**
 * main application module
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://www.gnu.org/licenses/agpl-3.0.txt|License}
 * @copyright based on https://github.com/unclechu/test-01
 */

require! {
	express
	jade
	\body-parser
	\express-session : session
	multer
	path
	http
	co
	\./config : {config}
	\./utils : {logger}
	\./router
}

co ->*
	cfg = yield config

	logger.debug 'application.ls',\
		"Express.js application instance initialization..."
	app = express!
		.use session do
			secret: cfg.SECRET_SALT
			save-uninitialized: no
			resave: off
		.use body-parser.urlencoded extended: true
		.engine \jade, jade.__express
		.set \views, path.resolve process.cwd!, cfg.TEMPLATES_PATH
		.set 'view engine', \jade
		.use /^\/static\//,\
			express.static path.resolve process.cwd!, cfg.STATIC_PATH

	{PORT, HOST} = cfg.SERVER

	router.init app

	logger.debug 'application.ls',\
		"Trying to start http-server at http://#{HOST}:#{PORT}..."

	yield new Promise (resolve, reject)!->
		http
		.create-server app
		.on \error, !->
			logger.error 'application.ls',\
				"Can't start http-server at http://#{HOST}:#{PORT}", it
			reject it
		.listen PORT, HOST, !->
			resolve!

	logger.info 'application.ls',\
		"http-server started at http://#{HOST}:#{PORT}"

.catch !->
	logger.error 'application.ls:catch()',\
		"Application initialization error", it
	.catch !-> # ignore error
	.then !-> process.exit 1
