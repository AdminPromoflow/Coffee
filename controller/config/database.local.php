<?php

declare(strict_types=1);

if (!defined('DOT63_DATABASE_CONFIG_ALLOWED')) {
    http_response_code(404);
    exit;
}

// Copy to database.local.php on the hosting server and enter the real password there.
// Use the database HOST supplied by the hosting panel, not the website URL.
return [
    'host' => 'localhost',
    'port' => 3306,
    'name' => 'u273173398_coffee',
    'user' => 'u273173398_aleina',
    'password' => 'coffee123?U', // Complete only on the hosting server, not in this example.
];
