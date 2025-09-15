<?php

define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('MYSQL_USER'));
define('DB_PASSWORD', getenv('MYSQL_PASSWORD'));
define('DB_HOST', 'mariadb:3306');

define('WP_DEBUG', false);

define('AUTH_KEY',         getenv('WP_AUTH_KEY')         ?: 'fallback_AUTH_KEY');
define('SECURE_AUTH_KEY',  getenv('WP_SECURE_AUTH_KEY')  ?: 'fallback_SECURE_AUTH_KEY');
define('LOGGED_IN_KEY',    getenv('WP_LOGGED_IN_KEY')    ?: 'fallback_LOGGED_IN_KEY');
define('NONCE_KEY',        getenv('WP_NONCE_KEY')        ?: 'fallback_NONCE_KEY');
define('AUTH_SALT',        getenv('WP_AUTH_SALT')        ?: 'fallback_AUTH_SALT');
define('SECURE_AUTH_SALT', getenv('WP_SECURE_AUTH_SALT') ?: 'fallback_SECURE_AUTH_SALT');
define('LOGGED_IN_SALT',   getenv('WP_LOGGED_IN_SALT')   ?: 'fallback_LOGGED_IN_SALT');
define('NONCE_SALT',       getenv('WP_NONCE_SALT')       ?: 'fallback_NONCE_SALT');

if (!defined('WP_CACHE')) define('WP_CACHE', true);
if (!defined('WP_REDIS_HOST')) define('WP_REDIS_HOST', getenv('WP_REDIS_HOST') ?: 'redis');
if (!defined('WP_REDIS_PORT')) define('WP_REDIS_PORT', (int)(getenv('WP_REDIS_PORT') ?: 6379));


$table_prefix = 'wp_';

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';

