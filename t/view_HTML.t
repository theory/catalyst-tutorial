use strict;
use warnings;
use Test::More tests => 5;
# use Test::XPath;
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

__END__

# Test output using Test::XPath or similar.
# my $tx = Test::XPath->new( xml => $output, is_html => 1);
# $tx->ok('/html', 'Should have root html element');
# $tx->is('/html/head/title', 'Hello, Theory', 'Title should be correct');

