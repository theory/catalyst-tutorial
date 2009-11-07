#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

eval "use Test::Pod::Coverage 1.04";
plan skip_all => 'Test::Pod::Coverage 1.04 required' if $@;

# BEGIN {
#     package Devel::Symdump;
#     sub functions {
#         our $AUTOLOAD;
#         local $AUTOLOAD = __PACKAGE__ . '::functions';
#         map { s{::_jifty(?:_private)?_template_}{::}; $_ } shift->AUTOLOAD(@_)
#     };
# }

all_pod_coverage_ok();
