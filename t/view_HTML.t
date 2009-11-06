use strict;
use warnings;
use Test::More tests => 3;
# use Test::XPath;

BEGIN {
    use_ok 'MyApp::View::HTML' or die;
    use_ok 'MyApp' or die;
}

ok my $view = MyApp->view('HTML'), 'Get HTML view object';

# ok my $output = $view->render(undef, 'hello', { user => 'Theory' }),
#     'Render the "hello" template';

# Test output using Test::XPath or similar.
# my $tx = Test::XPath->new( xml => $output, is_html => 1);
# $tx->ok('/html', 'Should have root html element');
# $tx->is('/html/head/title', 'Hello, Theory', 'Title should be correct');

