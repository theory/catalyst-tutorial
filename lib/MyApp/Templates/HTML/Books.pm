package MyApp::Templates::HTML::Books;

use strict;
use warnings;
use parent 'Template::Declare::Catalyst';
use Template::Declare::Tags;

template list => sub {
    my ($self, $args) = @_;
    table {
        row {
            th { 'Title'  };
            th { 'Rating' };
            th { 'Author' };
        };
        my $sth = $args->{books};
        while (my $book = $sth->fetchrow_hashref) {
            row {
                cell { $book->{title}  };
                cell { $book->{rating} };
                cell { $book->{author} };
            };
        };
    };
};

=head1 NAME

MyApp::Templates::HTML::Books - HTML::Books templates for MyApp

=head1 DESCRIPTION

HTML::Books templates for MyApp.

=head1 SEE ALSO

=over

=item L<Template::Declare>

=item L<MyApp>

=item L<Catalyst::View::TD>

=back

=head1 AUTHOR

David E. Wheeler

=head1 LICENSE

This library is free software. You can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;

