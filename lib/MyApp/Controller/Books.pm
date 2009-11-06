package MyApp::Controller::Books;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

MyApp::Controller::Books - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=head2 index

The default method for the books controller. Currently just says that it
matches the request; we'll likely want to change it to something more
reasonable down the line.

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MyApp::Controller::Books in Books.');
}

=head2 list

Looks up all of the books in the system and executes a template to display
them in a nice table. The data includes the title, rating, and authors of each
book

=cut

sub list : Local {
    my ($self, $c) = @_;
    my $stash = $c->stash;
    $stash->{title} = 'Book List';
    $stash->{books} = $c->conn->run(fixup => sub {
        my $sth = $_->prepare(q{
            SELECT isbn, title, rating, authors FROM books_with_authors
        });
        $sth->execute;
        $sth;
    });
}

=head1 AUTHOR

David E. Wheeler

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
