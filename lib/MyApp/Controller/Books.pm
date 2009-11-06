package MyApp::Controller::Books;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

MyApp::Controller::Books - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MyApp::Controller::Books in Books.');
}

sub list : Local {
    my ($self, $c) = @_;
    my $stash = $c->stash;
    $stash->{title} = 'Book List';
    $stash->{books} = $c->conn->run(fixup => sub {
        my $sth = $_->prepare('SELECT isbn, title, rating FROM books');
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
