#!/bin/sh

umask 022

PHPRC="{$PHP_STARTER_DIR}/{$DOMAIN_NAME}/php5/"
export PHPRC

PHP_FCGI_CHILDREN=2
export PHP_FCGI_CHILDREN

TMPDIR="{$WWW_DIR}/{$DOMAIN_NAME}/phptmp" 
export TMPDIR

exec {$PHP5_FASTCGI_BIN}
