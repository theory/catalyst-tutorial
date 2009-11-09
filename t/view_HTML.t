use strict;
use warnings;
#use Test::More tests => 5;
use Test::More 'no_plan';
use Test::XPath;
use Test::MockObject::Extends;

BEGIN {
    use_ok 'MyApp::View::HTML' or die;
    use_ok 'MyApp' or die;
}

# Instantiate the context object and the view.
ok my $c = MyApp->new, 'Create context object';
ok my $view = $c->view('HTML'), 'Get HTML view object';

my $mocker = Test::MockObject::Extends->new($c);
$mocker->mock( uri_for => sub { $_[1]} );

# Create a statement handle for books/list.
my $sth = $c->conn->run(sub { $_->prepare(q{
    SELECT isbn, title, rating, authors FROM books_with_authors
}) });
$sth->execute;

# Render books/list.
ok my $output = $view->render($c, 'books/list', {
    title => 'Book List',
    books => $sth,
}), 'Render the "books/list" template';
#diag $output;

# Test output using Test::XPath.
my $tx = Test::XPath->new( xml => $output, is_html => 1);
test_basics($tx, 'Book List');

# Call this function for every request to make sure that they all
# have the same basic structure.
sub test_basics {
    my ($tx, $title) = @_;

    # Some basic sanity-checking.
    $tx->is( 'count(/html)',      1, 'Should have 1 html element' );
    $tx->is( 'count(/html/head)', 1, 'Should have 1 head element' );
    $tx->is( 'count(/html/body)', 1, 'Should have 1 body element' );

    # Check the head element.
    $tx->is(
        '/html/head/title',
        $title,
        'Title should be corect'
    );
    $tx->is(
        '/html/head/link[@type="text/css"][@rel="stylesheet"]/@href',
        '/static/css/main.css',
        'Should load the CSS',
    );
}
