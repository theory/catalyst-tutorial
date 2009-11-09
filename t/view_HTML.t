use strict;
use warnings;
use Test::More tests => 54;
#use Test::More 'no_plan';
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
    SELECT isbn, title, rating, authors
      FROM books_with_authors
     ORDER BY title
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

$tx->ok('/html/body/div[@id="bodyblock"]/div[@id="content"]/table', sub {
    $_->is('count(./tr)', 6, 'Should have six rows' );
    $_->ok('./tr[1]', sub {
        $_->is('count(./th)', 3, 'Should have three table headers');
        $_->is('./th[1]', 'Title', '... first is "Title"');
        $_->is('./th[2]', 'Rating', '... second is "Rating"');
        $_->is('./th[3]', 'Authors', '... third is "Authors"');
    }, 'Should have first table row');

    $_->ok('./tr[2]', sub {
        $_->is('count(./td)', 3, 'Should have three cells');
        $_->is(
            './td[1]',
            'CCSP SNRS Exam Certification Guide',
            '... first is "CCSP SNRS Exam Certification Guide"'
        );
        $_->is('./td[2]', 5, '... second is "5"');
        $_->is(
            './td[3]',
            'Bastien, Nasseh, Degu',
            '... third is "Bastien, Nasseh, Degu"',
        );
    }, 'Should have second table row');

    $_->ok('./tr[3]', sub {
        $_->is('count(./td)', 3, 'Should have three cells');
        $_->is(
            './td[1]',
            'Designing with Web Standards',
            '... first is "Designing with Web Standards"'
        );
        $_->is('./td[2]', 5, '... second is "5"');
        $_->is(
            './td[3]',
            'Zeldman',
            '... third is "Zeldman"',
        );
    }, 'Should have third table row');

    $_->ok('./tr[4]', sub {
        $_->is('count(./td)', 3, 'Should have three cells');
        $_->is(
            './td[1]',
            'Internetworking with TCP/IP Vol.1',
            '... first is "Internetworking with TCP/IP Vol.1"'
        );
        $_->is('./td[2]', 4, '... second is "4"');
        $_->is(
            './td[3]',
            'Comer',
            '... third is "Comer"',
        );
    }, 'Should have fourth table row');

    $_->ok('./tr[5]', sub {
        $_->is('count(./td)', 3, 'Should have three cells');
        $_->is(
            './td[1]',
            'Perl Cookbook',
            '... first is "Perl Cookbook"',
        );
        $_->is('./td[2]', 5, '... second is "5"');
        $_->is(
            './td[3]',
            'Christiansen, Torkington',
            '... third is "Christiansen, Torkington"',
        );
    }, 'Should have fifth table row');

    $_->ok('./tr[6]', sub {
        $_->is('count(./td)', 3, 'Should have three cells');
        $_->is(
            './td[1]',
            'TCP/IP Illustrated, Volume 1',
            '... first is "TCP/IP Illustrated, Volume 1"'
        );
        $_->is('./td[2]', 5, '... second is "5"');
        $_->is(
            './td[3]',
            'Stevens',
            '... third is "Stevens"',
        );
    }, 'Should have sixth table row');

}, 'Should have a table');


# Call this function for every request to make sure that they all
# have the same basic structure.
sub test_basics {
    my ($tx, $title, $msg, $err) = @_;

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

    $tx->ok('/html/body/div[@id="header"]', sub {
        $_->ok('./img[@src="/static/images/btn_88x31_powered.png"]');
        $_->is('./h1', $title);
    }, 'Should have header');

    $tx->ok('/html/body/div[@id="bodyblock"]', sub {
        $_->ok('./div[@id="menu"]', sub {
            $_->is('./h3', 'Navigation', 'header should be "Navigation"');
            $_->ok('./ul', => sub {
                $_->ok('./li[1]', sub {
                    $_->is(
                        './a[@href="/books/list"]',
                        'Home',
                        'Should have Home'
                    );
                }, 'Should have home item');
                $_->ok('./li[2]', sub {
                    $_->is(
                        './a[@href="/"][@title="Catalyst Welcome Page"]',
                        'Welcome',
                        'Should have welcome page'
                    );
                }, 'Should have home item');
            }, 'Should have menu list');
        }, 'Should have menu');
        $_->ok('./div[@id="content"]', sub {
            $_->is('./span[message]', $msg) if $msg;
            $_->is('./span[error]',   $err) if $msg;
        }, 'Should have content');
    }, 'Should have bodyblock');
}
